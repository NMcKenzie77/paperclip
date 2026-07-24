---
schema: agentcompanies/v1
kind: company
name: ARKON Development Control Room
slug: arkon-development
description: Supervised AI engineering company that inventories, builds, reviews, and releases ARKON Platform and ARKON vertical products.
version: 1.0.0
license: MIT
authors:
  - name: Nathan McKenzie
goals:
  - Build ARKON as one shared control plane with configuration-driven vertical execution applications.
  - Harvest existing working capabilities before writing replacements.
  - Deliver stable, tested, tenant-safe products without patch-stack architecture or customer-specific forks.
tags:
  - arkon
  - engineering
  - multi-repository
  - ai-development
---

# ARKON Development Control Room

This company exists to help Nathan McKenzie build and maintain the ARKON product family. It is a supervised software-development organization, not a customer-facing ARKON product and not a replacement for ARKON Platform.

## Board authority

Nathan McKenzie is the board and final product authority. Agents may investigate, plan, create branches, implement approved work, test, review, and prepare pull requests. They may not merge to a default branch, deploy to production, alter production data, rotate credentials, purchase services, or approve material architecture changes without explicit board approval.

## Operating doctrine

1. Inspect before building.
2. Reuse proven ARKON behavior before creating new behavior.
3. ARKON Platform owns shared company, employee, agent, routing, identity, onboarding, email, automation, and control-plane contracts.
4. Vertical repositories own industry-specific records, interfaces, integrations, and execution workflows.
5. No repository per customer and no customer-specific backend fork.
6. No runtime patch chains, HTML injection architecture, giant catch-all files, or hardcoded live customer records.
7. No agent reviews or approves its own work.
8. Every meaningful change must leave a durable task record, verification evidence, and clear handoff.
9. Work on isolated branches or worktrees. Default branches remain protected.
10. Production activation is a board decision.

## Initial focus

The first active build is ARKON Property Operations. The team will harvest working capabilities from ARKON Platform, Arkon-RealEstateAgents, HostHalo, ARKON-AutoRepair, ARKON-SalesCRM, and related repositories, then assemble them cleanly inside ARKON-Property-Operations.