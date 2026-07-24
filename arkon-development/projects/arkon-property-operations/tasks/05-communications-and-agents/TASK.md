---
schema: agentcompanies/v1
kind: task
name: Adapt ARKON Communications and Operating Agents
slug: property-operations-communications
assignee: backend-integration-engineer
project: arkon-property-operations
priority: high
---

# Adapt ARKON Communications and Operating Agents

Adapt the approved existing ARKON communication and agent capabilities to the Property Operations domain.

Minimum scope:

- Vera inbound call routing through the existing SignalWire and ElevenLabs pattern
- Known resident, prospect, vendor, and unknown caller handling
- Approved available-unit lookup and showing-request handoff
- Iris inbound-email webhook mapping and routing
- Naya resident, prospect, employee, and vendor SMS or email communication
- Marcus operational history and relationship memory
- Caleb maintenance, showing, access, and field calendar updates
- Charlie maintenance ticket and follow-up creation
- Clara property, vendor, vehicle, registration, insurance, inspection, and deadline monitoring
- Rachel work-order cost and invoice exception linkage without pretending to be a full accounting system
- Grant daily owner brief for properties, maintenance, vendors, field staff, fleet, compliance, and matters requiring approval
- Resident appointment confirmation, reminder, on-the-way, arrival, completion, reschedule, and follow-up-required notifications

Do not promise live GPS or dynamic ETA. The on-the-way message is triggered by a reliable `EN_ROUTE` status change. Prevent duplicate notifications and preserve consent and opt-out behavior.