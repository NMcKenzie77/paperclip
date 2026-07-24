# Deploy ARKON Paperclip from AWS CloudShell

This deployment is designed for an operator who does not want Paperclip installed on a personal computer.

It creates:

- One Amazon Linux 2023 EC2 instance
- One encrypted gp3 root volume
- One Elastic IP
- One security group allowing HTTPS only from the operator's current public IPv4 address
- One EC2 IAM role with Systems Manager access
- Docker, Nginx, Paperclip, Codex CLI, Claude Code CLI, GitHub CLI, and persistent Paperclip data
- Authenticated/private Paperclip mode with browser-based first-admin claiming

## Run from AWS CloudShell

Open AWS CloudShell and run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/NMcKenzie77/paperclip/master/deploy/aws/cloudshell-deploy.sh)
```

The script will:

1. Confirm the active AWS account and Region.
2. Ask AWS which instance types are currently Free Tier eligible for that account and Region.
3. Ask the operator to choose an instance type.
4. Ask for the operator's current public IPv4 address.
5. Locate the default VPC and a default public subnet.
6. Validate and deploy the CloudFormation stack.
7. Wait for Systems Manager connectivity.
8. Wait until Paperclip's health endpoint succeeds.
9. Print the Paperclip URL and first-admin instructions.

## First administrator

Open the generated HTTPS URL from the same internet connection whose public IP was entered during deployment.

The initial certificate is self-signed. Review the browser warning and continue only when the displayed IP matches the Elastic IP shown by the deployment script.

Then:

1. Create or sign into a Paperclip account.
2. Choose **Claim this instance**.
3. The signed-in account becomes the first `instance_admin`.

The browser claim is available because the deployment uses `authenticated/private` mode and restricts the security group to one operator IP.

## Free Tier warning

The script queries the EC2 `free-tier-eligible` flag directly from AWS. Eligibility and charges still depend on the account plan, remaining credits, Region, EBS usage, Elastic IP rules, data transfer, and how long the instance remains running.

Paperclip may boot on a 1 GB instance with swap, but the coding agents are not realistically usable there. Prefer at least 4 GB RAM. Eight GB is safer when AWS credits cover it.

Create an AWS Budget before leaving the instance running.

## AI and GitHub credentials

The web application runs without coding-agent credentials. To let agents work against ARKON repositories, add these later through Paperclip's secret and project configuration:

- `GH_TOKEN` with access only to the required ARKON repositories
- `OPENAI_API_KEY` for Codex agents
- `ANTHROPIC_API_KEY` for Claude agents

Do not place those values in GitHub, CloudFormation parameters, user data, or shell history.

## When the operator IP changes

Run the same CloudShell command again. Enter the new public IPv4 address and keep the same stack name and instance type. CloudFormation updates the security group while preserving the existing Paperclip instance and data when no replacement-triggering parameter changed.

## Administration without SSH

The EC2 instance is registered with AWS Systems Manager. No SSH port or EC2 key pair is created.

Useful AWS CLI commands from CloudShell:

```bash
aws cloudformation describe-stacks --stack-name arkon-paperclip
aws ec2 describe-instances --filters Name=tag:Application,Values=ARKON-Paperclip
aws ssm describe-instance-information
```

To inspect bootstrap logs through Systems Manager Run Command:

```bash
INSTANCE_ID=$(aws cloudformation describe-stacks \
  --stack-name arkon-paperclip \
  --query "Stacks[0].Outputs[?OutputKey=='InstanceId'].OutputValue | [0]" \
  --output text)

aws ssm send-command \
  --instance-ids "$INSTANCE_ID" \
  --document-name AWS-RunShellScript \
  --parameters 'commands=["tail -n 300 /var/log/paperclip-bootstrap.log","docker logs --tail 300 paperclip"]'
```

## Removing the deployment

Deleting the stack deletes the EC2 instance, its root volume, the Elastic IP, security group, instance profile, and role:

```bash
aws cloudformation delete-stack --stack-name arkon-paperclip
```

Back up Paperclip before deleting the stack. The root EBS volume is configured to be deleted with the instance.