---
schema: agentcompanies/v1
kind: task
name: Port the Field Operations and Photo Workflow
slug: property-operations-field-interface
assignee: frontend-vertical-engineer
project: arkon-property-operations
priority: high
---

# Port the Field Operations and Photo Workflow

Using the approved backend contract and the proven HostHalo turnover behavior, build the clean Property Operations field workflow.

Minimum scope:

- Secure expiring assignment link for an employee or outside vendor
- Job, property, unit, access, scheduled time, and instruction display
- En-route action
- Arrival check-in
- Required before or arrival photographs
- On-site status and calendar update
- Completion details
- Required after photographs
- Parts, materials, notes, issue flag, and follow-up-required state
- Check-out and completion timestamp
- Management visibility into scheduled, late, en-route, on-site, completed, and follow-up work
- Responsive mobile experience using device camera input
- Expired, completed, invalid, upload-failure, permission, and retry states

Do not add continuous GPS or live vehicle tracking. Location capture is not required for the first pilot. Do not copy the old runtime patch architecture; port the proven behavior into clean routes, services, components, and data models.