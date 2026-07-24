# ARKON Development Governance

## Board

Nathan McKenzie is the board, product owner, and final approval authority.

## Changes that require board approval

- Merging or pushing directly to a default branch
- Production deployments or Railway environment changes
- Database migrations against production
- Changes to ARKON Platform ownership boundaries
- New paid services, purchases, or material usage increases
- Credential creation, rotation, deletion, or exposure
- Destructive data changes
- Customer-specific forks or hardcoded customer behavior
- Public releases, pricing changes, or customer promises

## Required delivery path

1. Inspect the target repository and its governing documents.
2. Record the existing behavior and the requested outcome.
3. Identify reusable behavior in other ARKON repositories.
4. Produce a scoped plan for material architecture or multi-repository work.
5. Use an isolated branch or Paperclip execution worktree.
6. Implement the smallest complete approved scope.
7. Run targeted tests first, then broader checks appropriate to the change.
8. Hand the work to a different agent for review.
9. Resolve review findings and record verification evidence.
10. Prepare a pull request or board-ready handoff. Do not merge or deploy without approval.

## Separation of duties

- Carl coordinates and escalates. Carl does not silently rewrite implementation work.
- The Platform Architect defines boundaries and contracts. The architect does not approve their own architecture.
- Implementation engineers build approved work.
- The QA & Release Lead validates behavior and release readiness.
- The Security & Architecture Reviewer independently reviews tenant isolation, permissions, secrets, provider boundaries, and architectural drift.
- No agent marks its own implementation production-ready.

## ARKON architecture rules

- ARKON Platform is the shared control plane.
- Vertical applications remain specialized execution layers.
- Shared company identity, employee identity, reusable agent configuration, routing, email transport, onboarding, automation coordination, and platform health belong to ARKON Platform.
- Properties, repair orders, listings, policies, stays, work orders, vehicles, and other industry records remain in their vertical applications.
- Harvest behavior, not obsolete architecture.
- Do not carry forward runtime patch stacks, startup injection chains, giant route files, HTML business logic, or hardcoded customer records.
- Support multiple businesses in a vertical through configuration rather than code forks.

## Safety defaults

- Imported agent timer heartbeats remain disabled until each adapter, workspace, and permission boundary has been verified.
- Agents receive only the secrets and repositories required for assigned work.
- Production databases and production provider consoles are out of scope unless the board explicitly grants access for a named task.
- A blocked agent must document the blocker and stop rather than guess or bypass controls.