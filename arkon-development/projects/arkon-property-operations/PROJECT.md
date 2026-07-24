---
schema: agentcompanies/v1
kind: project
name: ARKON Property Operations
slug: arkon-property-operations
description: Assemble a property, maintenance, vendor, fleet, field-operations, communications, compliance, and owner-reporting vertical from proven ARKON capabilities.
owner: platform-architect
metadata:
  paperclip:
    repoUrl: https://github.com/NMcKenzie77/ARKON-Property-Operations.git
    repoRef: main
    workspaceStrategy: git_worktree
---

# ARKON Property Operations

Build a sellable property-operations vertical for conventional property managers while preserving ARKON Platform as the shared control plane.

## Initial product scope

- Properties, units, residents, leases, staff, and outside vendors
- Maintenance requests and work orders
- Field assignments, en-route status, check-in, check-out, and calendar updates
- Before-and-after photographs and issue evidence
- Resident appointment, on-the-way, arrival, completion, and follow-up notifications
- Internal maintenance staff and outside vendor coordination
- Fleet records, employee-to-truck assignment, maintenance, availability, and compliance documents
- Vera phone intake and available-unit lookup
- Iris inbound-email classification and routing
- Naya resident and prospect communication
- Marcus operational memory
- Caleb scheduling and field coordination
- Clara property, vendor, and fleet deadline monitoring
- Rachel financial exceptions and work-order cost linkage
- Grant owner command brief

## Explicit exclusions for the first pilot

- Continuous GPS tracking
- Uber-style live maps and dynamic ETAs
- Full general-ledger accounting
- Full transportation management or freight dispatch
- Automatic legal, financial, or insurance decisions
- Deep PMS integration as a launch dependency unless separately approved

## Delivery rule

Harvest working behavior from existing ARKON repositories, reimplement it cleanly in the target architecture, and require independent QA and security review before presenting the pilot as release-ready.