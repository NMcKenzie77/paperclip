---
schema: agentcompanies/v1
kind: task
name: Review Property Operations Security and Architecture Boundaries
slug: property-operations-security-review
assignee: security-architecture-reviewer
project: arkon-property-operations
priority: critical
---

# Review Property Operations Security and Architecture Boundaries

Independently review the integrated Property Operations pilot before board release approval.

Required review areas:

- Tenant, company, location, employee, resident, vendor, property, unit, work-order, vehicle, and document scoping
- Role and permission boundaries for owner, right-hand manager, office staff, maintenance staff, and outside vendors
- Secure assignment tokens, expiry, replay resistance, and direct-object access
- Photograph upload type, size, storage, access, retention, and deletion controls
- SignalWire, ElevenLabs, email, SMS, webhook, and provider credential boundaries
- Resident consent, opt-out, recording, emergency, and escalation behavior
- Duplicate notification and race-condition protection
- Secrets, environment variables, logs, transcripts, summaries, and audit records
- Production migration and rollback risk
- ARKON Platform versus vertical ownership drift
- Legacy behavior that may have carried obsolete architecture into the new vertical

Produce findings with evidence, severity, required remediation, and retest criteria. Do not approve your own implementation, merge, deploy, or access production systems.