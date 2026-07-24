---
schema: agentcompanies/v1
kind: task
name: Run the Property Operations Paid Pilot Release Gate
slug: property-operations-pilot-release-gate
assignee: qa-release-lead
project: arkon-property-operations
priority: critical
---

# Run the Property Operations Paid Pilot Release Gate

Independently validate the integrated paid-pilot build after implementation tasks are presented for review.

Required coverage:

- Tenant, company, location, role, employee, resident, vendor, property, unit, work-order, and vehicle isolation
- Property and unit import
- Maintenance request through assignment, en-route, check-in, photographs, completion, check-out, and follow-up
- Internal employee and outside vendor paths
- Resident confirmation, reminder, on-the-way, arrival, completion, reschedule, and follow-up messages
- Duplicate notification prevention
- Expired or invalid field links
- Failed photograph upload and retry
- Vera call, unit lookup, human handoff, after-hours, emergency, and provider-failure behavior
- Iris inbound email and thread routing
- Grant owner brief accuracy
- Clara compliance reminders
- Rachel cost and invoice exceptions
- Truck assignment, maintenance, out-of-service, registration, and insurance states
- Permission denial and audit evidence
- Migration, rollback, build, typecheck, unit, integration, and targeted end-to-end checks

The deliverable must state exactly what passed, what failed, what remains limited, and whether the build is ready for Nathan's approval. Do not merge or deploy.