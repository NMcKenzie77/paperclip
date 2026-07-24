# ARKON Repository Registry

This registry gives the ARKON Development Control Room a starting map. Agents must still inspect the current default branch and governing documents before relying on a repository.

| Repository | Default branch | Primary purpose | Reuse guidance |
|---|---|---|---|
| `NMcKenzie77/ARKON-Platform` | `main` | Shared ARKON control plane, company and employee configuration, reusable agents, onboarding, email, automation, command center | Authoritative for shared platform contracts |
| `NMcKenzie77/ARKON-Vertical-Template` | `main` | Starter architecture and conventions for new vertical execution applications | Use as structural guidance, not as a finished product |
| `NMcKenzie77/ARKON-Property-Operations` | `main` | Target property-management vertical | Current repository is the destination for Property Operations work |
| `NMcKenzie77/Arkon-RealEstateAgents` | `main` | Real-estate execution, Vera voice, ElevenLabs, SignalWire, Naya, Marcus, Iris, Caleb, Grant, calendars, usage and multi-tenant patterns | Harvest voice, communication, calendar, memory, briefing, and UI patterns; keep real-estate records in this vertical |
| `NMcKenzie77/HostHalo` | `main` | Original HostHalo runtime with working guest, cleaner, vendor, turnover, photo and field-operation behavior | Harvest proven behavior; do not copy the legacy runtime patch architecture |
| `NMcKenzie77/ARKON-SRT-HostHalo` | `main` | New short-term-rental vertical foundation and migration work | Use current architecture and migration direction for future STR work |
| `NMcKenzie77/ARKON-AutoRepair` | `main` | Auto-repair vertical, vehicle and repair operations, service roles, Platform automation handlers and operational failure patterns | Harvest vehicle, maintenance, handoff, idempotency, retry and failure-handling patterns |
| `NMcKenzie77/ARKON-Insurance` | `main` | Insurance vertical and licensed-workflow boundaries | Harvest insurance-specific roles, compliance boundaries and policy workflow only when relevant |
| `NMcKenzie77/ARKON-SalesCRM` | `main` | ARKON or client sales operations, business/contact records, activity, outreach, research and pipeline patterns | Harvest CRM, inbox, assignment, activity and research patterns; do not mix ARKON internal CRM with customer runtime without approval |
| `NMcKenzie77/ARKON-Homepage` | `main` | Public ARKON website, Porter intake, vertical positioning and shared visual language | Harvest public intake and presentation patterns; keep marketing and SEO in the homepage repo |
| `NMcKenzie77/NMcKenzie77-ARKON-Control-Room` | `main` | ARKON operational control-room experiments and internal visibility | Inspect for useful control and supervision patterns before reuse |
| `NMcKenzie77/ARKON-BotLab` | `main` | Agent evaluation, regression and promotion experiments | Use later for agent testing and release gates; not a production configuration source of truth |
| `NMcKenzie77/paperclip` | `master` | Development orchestration control room for AI coding agents | Use to coordinate work; do not embed it into customer-facing ARKON products |

## Repository-selection rule

Before opening a new project or implementation task, the Repo Harvest Engineer should answer:

1. Which repository already owns the behavior?
2. Is the behavior working, partial, obsolete, or concept-only?
3. Does the reusable contract belong in ARKON Platform?
4. Does the specialized execution belong in a vertical?
5. What architecture must not be copied forward?
6. Which tests prove the harvested behavior still works after adaptation?

## Adding future projects

When a repository becomes active work in Paperclip:

- Create a `PROJECT.md` under `arkon-development/projects/<project-slug>/`.
- Set an agent owner.
- Record the repository URL and default ref under `metadata.paperclip`.
- Bind the imported project to an isolated local worktree in Paperclip.
- Seed only approved work. Do not import the entire product backlog automatically.