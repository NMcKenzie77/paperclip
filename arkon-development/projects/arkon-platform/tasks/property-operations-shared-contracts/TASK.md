---
schema: agentcompanies/v1
kind: task
name: Reconcile Shared Platform Contracts for Property Operations
slug: property-operations-platform-contracts
assignee: platform-architect
project: arkon-platform
priority: high
---

# Reconcile Shared Platform Contracts for Property Operations

Review the approved Property Operations architecture against the current ARKON Platform implementation and punch list.

Identify only the shared Platform work genuinely required for the pilot, such as:

- Client company, package, location, team, employee, role, and enabled-agent setup
- Runtime keys and vertical bootstrap
- Shared outbound email and inbound-route metadata
- Agent settings and prompt assembly
- Routing and escalation contracts
- Global automation action creation and vertical handler execution
- Shared conversation or audit contracts where the current Platform API is sufficient or must be extended
- Provider and readiness visibility

For each required change, state whether the capability already exists, requires a small integration contract, or requires approved Platform development. Do not pull property, unit, lease, work-order, vendor, fleet, or field-session records into Platform.

Create separate implementation tasks for approved Platform changes. Do not combine unrelated Platform punch-list work into the Property Operations pilot.