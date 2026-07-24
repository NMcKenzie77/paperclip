#!/usr/bin/env bash
set -euo pipefail

STACK_NAME="${STACK_NAME:-arkon-paperclip}"
REGION="${AWS_REGION:-${AWS_DEFAULT_REGION:-us-east-1}}"
REPOSITORY_RAW_BASE="https://raw.githubusercontent.com/NMcKenzie77/paperclip/master/deploy/aws"
WORK_DIR="${HOME}/arkon-paperclip-aws"
TEMPLATE_FILE="${WORK_DIR}/paperclip-ec2.yaml"

say() {
  printf '\n%s\n' "$*"
}

fail() {
  printf '\nERROR: %s\n' "$*" >&2
  exit 1
}

command -v aws >/dev/null 2>&1 || fail "AWS CLI was not found. Run this inside AWS CloudShell."
command -v curl >/dev/null 2>&1 || fail "curl was not found."
command -v python3 >/dev/null 2>&1 || fail "python3 was not found."

say "Checking the AWS identity available to this CloudShell session..."
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --region "$REGION")
CALLER_ARN=$(aws sts get-caller-identity --query Arn --output text --region "$REGION")
printf 'Account: %s\nCaller:  %s\nRegion:  %s\n' "$ACCOUNT_ID" "$CALLER_ARN" "$REGION"

say "Finding instance types AWS currently marks Free Tier eligible for this account and Region..."
ELIGIBLE_TEXT=$(aws ec2 describe-instance-types \
  --region "$REGION" \
  --filters Name=free-tier-eligible,Values=true \
  --query 'sort_by(InstanceTypes,&MemoryInfo.SizeInMiB)[].InstanceType' \
  --output text 2>/dev/null || true)

if [[ -n "$ELIGIBLE_TEXT" && "$ELIGIBLE_TEXT" != "None" ]]; then
  printf 'Eligible instance types reported by AWS:\n%s\n' "$(tr '\t' ' ' <<<"$ELIGIBLE_TEXT")"
else
  printf 'AWS did not return a Free Tier eligible instance list. You can still enter an instance type, but verify billing eligibility in the EC2 console.\n'
fi

DEFAULT_INSTANCE=""
for candidate in m7i-flex.large t3.medium t3.small t3.micro t2.micro; do
  if [[ " $ELIGIBLE_TEXT " == *" $candidate "* ]] || [[ "$ELIGIBLE_TEXT" == *$'\t'"$candidate"* ]] || [[ "$ELIGIBLE_TEXT" == "$candidate" ]]; then
    DEFAULT_INSTANCE="$candidate"
    break
  fi
done

if [[ -z "$DEFAULT_INSTANCE" ]]; then
  DEFAULT_INSTANCE="t3.small"
fi

read -r -p "Instance type [${DEFAULT_INSTANCE}]: " INSTANCE_TYPE </dev/tty
INSTANCE_TYPE="${INSTANCE_TYPE:-$DEFAULT_INSTANCE}"

INSTANCE_INFO=$(aws ec2 describe-instance-types \
  --region "$REGION" \
  --instance-types "$INSTANCE_TYPE" \
  --query 'InstanceTypes[0].[VCpuInfo.DefaultVCpus,MemoryInfo.SizeInMiB]' \
  --output text 2>/dev/null) || fail "Instance type '$INSTANCE_TYPE' is unavailable in $REGION."

VCPU=$(awk '{print $1}' <<<"$INSTANCE_INFO")
MEMORY_MIB=$(awk '{print $2}' <<<"$INSTANCE_INFO")
printf 'Selected: %s (%s vCPU, %s MiB RAM)\n' "$INSTANCE_TYPE" "$VCPU" "$MEMORY_MIB"

if (( MEMORY_MIB < 4096 )); then
  printf '\nWARNING: This can prove the Paperclip dashboard, but less than 4 GB RAM is not a realistic long-term coding-agent server.\n'
  read -r -p "Continue with this smaller instance? [y/N]: " CONTINUE_SMALL </dev/tty
  [[ "$CONTINUE_SMALL" =~ ^[Yy]$ ]] || fail "Deployment cancelled. Choose an eligible instance with at least 4 GB RAM when available."
fi

say "Paperclip will be reachable only from your current public IP."
printf 'Open this in another browser tab and copy the IPv4 address shown:\n  https://checkip.amazonaws.com\n'
read -r -p "Paste your public IPv4 address: " PUBLIC_IP_INPUT </dev/tty
PUBLIC_IP="${PUBLIC_IP_INPUT%/32}"

if ! python3 - "$PUBLIC_IP" <<'PY'
import ipaddress
import sys
try:
    value = ipaddress.ip_address(sys.argv[1])
except ValueError:
    raise SystemExit(1)
raise SystemExit(0 if value.version == 4 else 1)
PY
then
  fail "'$PUBLIC_IP_INPUT' is not a valid public IPv4 address."
fi
ALLOWED_CIDR="${PUBLIC_IP}/32"

VPC_ID=$(aws ec2 describe-vpcs \
  --region "$REGION" \
  --filters Name=is-default,Values=true \
  --query 'Vpcs[0].VpcId' \
  --output text)
[[ -n "$VPC_ID" && "$VPC_ID" != "None" ]] || fail "No default VPC exists in $REGION. Create a default VPC or deploy in a Region that has one."

SUBNET_ID=$(aws ec2 describe-subnets \
  --region "$REGION" \
  --filters Name=vpc-id,Values="$VPC_ID" Name=default-for-az,Values=true \
  --query 'sort_by(Subnets,&AvailabilityZone)[0].SubnetId' \
  --output text)
[[ -n "$SUBNET_ID" && "$SUBNET_ID" != "None" ]] || fail "No default public subnet was found in VPC $VPC_ID."

mkdir -p "$WORK_DIR"
curl -fsSL "${REPOSITORY_RAW_BASE}/paperclip-ec2.yaml" -o "$TEMPLATE_FILE"

say "Validating the CloudFormation template..."
aws cloudformation validate-template \
  --region "$REGION" \
  --template-body "file://${TEMPLATE_FILE}" >/dev/null

say "Deploying the ${STACK_NAME} CloudFormation stack..."
aws cloudformation deploy \
  --region "$REGION" \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --capabilities CAPABILITY_IAM \
  --no-fail-on-empty-changeset \
  --parameter-overrides \
    VpcId="$VPC_ID" \
    SubnetId="$SUBNET_ID" \
    AllowedCidr="$ALLOWED_CIDR" \
    InstanceType="$INSTANCE_TYPE" \
    RootVolumeSize=30 \
    PaperclipRef=master

PAPERCLIP_URL=$(aws cloudformation describe-stacks \
  --region "$REGION" \
  --stack-name "$STACK_NAME" \
  --query "Stacks[0].Outputs[?OutputKey=='PaperclipUrl'].OutputValue | [0]" \
  --output text)

INSTANCE_ID=$(aws cloudformation describe-stacks \
  --region "$REGION" \
  --stack-name "$STACK_NAME" \
  --query "Stacks[0].Outputs[?OutputKey=='InstanceId'].OutputValue | [0]" \
  --output text)

say "The EC2 instance exists. Checking Systems Manager connectivity..."
SSM_ONLINE=0
for _ in $(seq 1 120); do
  PING_STATUS=$(aws ssm describe-instance-information \
    --region "$REGION" \
    --filters "Key=InstanceIds,Values=$INSTANCE_ID" \
    --query 'InstanceInformationList[0].PingStatus' \
    --output text 2>/dev/null || true)
  if [[ "$PING_STATUS" == "Online" ]]; then
    SSM_ONLINE=1
    break
  fi
  sleep 5
done

if [[ "$SSM_ONLINE" -ne 1 ]]; then
  fail "The instance did not register with Systems Manager. Check EC2 instance $INSTANCE_ID and /var/log/cloud-init-output.log."
fi

say "Checking the Paperclip bootstrap inside the EC2 instance..."
HEALTH_COMMAND='for attempt in $(seq 1 240); do if [ -f /opt/paperclip/READY ] && curl -skf https://127.0.0.1/api/health >/dev/null 2>&1; then echo PAPERCLIP_READY; exit 0; fi; if [ -f /opt/paperclip/FAILED ]; then echo PAPERCLIP_BOOTSTRAP_FAILED; tail -n 300 /var/log/paperclip-bootstrap.log; docker logs --tail 300 paperclip 2>&1 || true; exit 1; fi; sleep 10; done; echo PAPERCLIP_HEALTH_TIMEOUT; tail -n 300 /var/log/paperclip-bootstrap.log; docker logs --tail 300 paperclip 2>&1 || true; exit 1'
export HEALTH_COMMAND
PARAMETERS_FILE=$(mktemp)
python3 - <<'PY' > "$PARAMETERS_FILE"
import json
import os
print(json.dumps({"commands": [os.environ["HEALTH_COMMAND"]], "executionTimeout": ["3600"]}))
PY

COMMAND_ID=$(aws ssm send-command \
  --region "$REGION" \
  --instance-ids "$INSTANCE_ID" \
  --document-name AWS-RunShellScript \
  --comment "Wait for ARKON Paperclip bootstrap" \
  --timeout-seconds 3600 \
  --parameters "file://${PARAMETERS_FILE}" \
  --query 'Command.CommandId' \
  --output text)
rm -f "$PARAMETERS_FILE"

FINAL_STATUS="Pending"
for _ in $(seq 1 360); do
  FINAL_STATUS=$(aws ssm get-command-invocation \
    --region "$REGION" \
    --command-id "$COMMAND_ID" \
    --instance-id "$INSTANCE_ID" \
    --query Status \
    --output text 2>/dev/null || true)

  case "$FINAL_STATUS" in
    Success|Failed|TimedOut|Cancelled|Cancelling)
      break
      ;;
  esac
  sleep 10
done

if [[ "$FINAL_STATUS" != "Success" ]]; then
  printf '\nPaperclip bootstrap status: %s\n' "$FINAL_STATUS" >&2
  aws ssm get-command-invocation \
    --region "$REGION" \
    --command-id "$COMMAND_ID" \
    --instance-id "$INSTANCE_ID" \
    --query '{Output:StandardOutputContent,Error:StandardErrorContent}' \
    --output json >&2 || true
  exit 1
fi

say "Paperclip is running."
printf 'URL: %s\n' "$PAPERCLIP_URL"
printf '\nFirst administrator setup:\n'
printf '1. Open the URL from the same internet connection whose IP you entered.\n'
printf '2. Your browser will warn that the temporary certificate is self-signed. Choose Advanced and continue.\n'
printf '3. Create or sign into your Paperclip account.\n'
printf '4. Choose Claim this instance. Your account becomes the first instance administrator.\n'
printf '\nThe security group currently allows HTTPS only from %s.\n' "$ALLOWED_CIDR"
printf 'Instance ID: %s\n' "$INSTANCE_ID"
printf 'Stack:       %s\n' "$STACK_NAME"
printf 'Region:      %s\n' "$REGION"
