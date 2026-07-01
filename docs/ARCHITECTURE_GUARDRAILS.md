# Architecture Guardrails

These rules exist to prevent the repo from turning into a patch stack or all-in-one page mess.

## Non-negotiable rules

- No runtime patch files.
- No `node -r patch-file` startup chains.
- No HTML string injection as an architecture pattern.
- No all-in-one admin, portal, dashboard, or app pages.
- No business logic inside frontend HTML files.
- No hardcoded live customer, host, lead, or user records in runtime code.
- No giant catch-all `index.js`, `app.js`, or route file that owns unrelated features.

## Preferred structure

Use separate pages, route modules, service modules, and shared utilities.

```txt
server.js
src/
  app.js
  config/
  db/
  middleware/
  routes/
  services/
  utils/
public/
  assets/
  pages-or-feature-folders/
docs/
```

## Migration rule

When refactoring legacy code, copy behavior only after understanding it. Do not copy bad architecture forward.

Every migrated feature must answer:

1. What route owns this?
2. What service owns the business logic?
3. What page or component owns the UI?
4. What data model owns the records?
5. What can be tested without clicking through the UI?
