---
schema: agentcompanies/v1
kind: task
name: Build the Property Operations Backend Foundation
slug: property-operations-backend-foundation
assignee: backend-integration-engineer
project: arkon-property-operations
priority: high
---

# Build the Property Operations Backend Foundation

Implement the approved first-pilot backend architecture in ARKON-Property-Operations.

Minimum scope:

- Vertical application and database foundation
- Platform tenant, location, employee, and enabled-agent binding
- Property, unit, resident, lease, vendor, truck, work-order, field-session, photo, compliance, and expense models
- Role and permission checks
- Work-order and field-operation status transitions
- Idempotent action and notification handling
- Audit records and operational failure visibility
- Initial import or seed path for ten units, staff, vendors, and fleet records
- Targeted unit and integration tests

Do not build customer-specific schemas or duplicate shared ARKON Platform models. Do not deploy. Hand the implementation to QA and Security review with migration and rollback notes.