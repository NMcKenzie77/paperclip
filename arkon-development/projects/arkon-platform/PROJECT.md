---
schema: agentcompanies/v1
kind: project
name: ARKON Platform and Shared Infrastructure
slug: arkon-platform
description: Maintain the shared ARKON control plane and approved contracts consumed by vertical execution applications.
owner: platform-architect
metadata:
  paperclip:
    repoUrl: https://github.com/NMcKenzie77/ARKON-Platform.git
    repoRef: main
    workspaceStrategy: git_worktree
---

# ARKON Platform and Shared Infrastructure

ARKON Platform owns reusable company configuration, employee configuration, agent behavior, routing, channel identity, prompt assembly, conversations, onboarding, implementation work, email transport, automation coordination, health visibility, and platform-wide operating rules.

This project exists to maintain those shared contracts and to support vertical integrations without absorbing vertical-specific records or execution workflows.

## Project rules

- Read the Platform architecture, email lock, onboarding specification, build manual, punch list, and repo harvest map before material changes.
- Preserve stable tenant identifiers and runtime keys.
- Do not duplicate vertical records in Platform.
- Do not modify protected infrastructure during routine vertical work.
- Every integration contract must be tenant-safe, auditable, testable, and versioned where appropriate.
- Material architecture changes require board approval.