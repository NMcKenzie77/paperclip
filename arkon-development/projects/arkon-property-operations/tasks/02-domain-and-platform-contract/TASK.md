---
schema: agentcompanies/v1
kind: task
name: Define the Property Operations Domain and Platform Contract
slug: property-operations-domain-contract
assignee: platform-architect
project: arkon-property-operations
priority: critical
---

# Define the Property Operations Domain and Platform Contract

Using the approved repository harvest map, define the first-pilot architecture for ARKON Property Operations.

The design must cover:

- Properties, units, residents, leases, staff, vendors, trucks, work orders, field sessions, photographs, documents, compliance items, expenses, and communication records
- Which records live in the vertical and which identities or settings are referenced from ARKON Platform
- Stable tenant, company, location, employee, contact, property, unit, work-order, vendor, and vehicle identifiers
- Platform configuration and runtime bootstrap contract
- Communication, email, voice, calendar, automation, audit, and provider ownership boundaries
- Status machines for maintenance and field operations
- Permission model for owner, right-hand manager, office staff, maintenance staff, and outside vendors
- Retry, duplicate prevention, escalation, recovery, and audit behavior
- Migration, seed data, and rollback approach
- Tests required before the paid pilot

Do not implement the design in this task. Produce a decision-ready architecture document and identify any material choice that requires Nathan's approval.