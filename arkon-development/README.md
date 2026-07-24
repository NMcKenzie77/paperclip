# ARKON Development Control Room

This directory is an importable Paperclip company package for building and maintaining the ARKON product family.

It configures Paperclip as a supervised engineering control room. It does not modify Paperclip core and it does not become part of any customer-facing ARKON application.

## Team

- **Carl** — engineering chief of staff and board-facing coordinator
- **Platform Architect** — ARKON Platform boundaries, contracts, and cross-repository architecture
- **Repo Harvest Engineer** — inventories working ARKON behavior before new code is written
- **Backend Integration Engineer** — schemas, APIs, automation, provider integrations, and vertical-to-platform contracts
- **Frontend Vertical Engineer** — ARKON vertical interfaces and mobile field workflows
- **QA & Release Lead** — tests, regression checks, release evidence, and handoff quality
- **Security & Architecture Reviewer** — tenant isolation, permissions, secrets, provider boundaries, and architecture drift

## Prerequisites

Install or confirm:

- Node.js 20 or newer
- npm
- Git
- GitHub CLI (`gh`) authenticated to `NMcKenzie77`
- Codex CLI authenticated through a ChatGPT subscription or `OPENAI_API_KEY`
- Claude Code authenticated through a subscription or `ANTHROPIC_API_KEY`

Do not place secret values in this repository. Paperclip stores secret bindings in the local instance.

## Import from the repository

Dry-run first:

```powershell
npx --registry https://registry.npmjs.org companies.sh add NMcKenzie77/paperclip/arkon-development --target new --include company,agents,projects,tasks --dry-run
```

Apply after reviewing the preview:

```powershell
npx --registry https://registry.npmjs.org companies.sh add NMcKenzie77/paperclip/arkon-development --target new --include company,agents,projects,tasks -y
```

The included PowerShell bootstrap script performs the same sequence and defaults to a dry run:

```powershell
powershell -ExecutionPolicy Bypass -File .\arkon-development\scripts\bootstrap-arkon-paperclip.ps1
```

Apply the import:

```powershell
powershell -ExecutionPolicy Bypass -File .\arkon-development\scripts\bootstrap-arkon-paperclip.ps1 -Apply
```

## First activation sequence

1. Start Paperclip locally and open the board at `http://127.0.0.1:3100`.
2. Confirm the ARKON Development Control Room company imported correctly.
3. Confirm each agent has the expected Claude or Codex local adapter.
4. Bind the ARKON Platform and ARKON Property Operations projects to local repository workspaces.
5. Verify `gh auth status`, `codex`, and `claude` from the same Windows account running Paperclip.
6. Leave all scheduled heartbeats disabled.
7. Manually invoke the Repo Harvest Engineer on the first inventory task.
8. Review its output before enabling another agent.
9. Enable agents one at a time only after their repository and permission boundaries are confirmed.

## Initial projects

The package seeds two projects:

- **ARKON Platform & Shared Infrastructure**
- **ARKON Property Operations**

The repository registry lists the remaining ARKON repositories so they can be added as projects when their next approved work begins.

## Default delivery rule

Agents may prepare branches, code, tests, documentation, and pull requests. Nathan McKenzie remains the final authority for architecture changes, merges, deployments, production access, credentials, and paid services.