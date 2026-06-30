# VerdiTech — Errors & Solutions Log
> Project: VerdiTech | Last Updated: June 30, 2026

This file tracks all bugs, errors, blockers, and unexpected issues encountered during development. Every error is documented with its root cause and solution for future reference and pattern recognition.

---

## Error Log

| # | Date | Error Description | Context / Where | Root Cause | Solution | Status | Time Spent |
|---|------|-------------------|-----------------|------------|----------|--------|------------|
| E001 | 2026-06-28 | Mappers throw `Undefined class 'PlantTableData'` | `lib/data/mappers/` | Drift generates data classes in `app_database.g.dart` which is part of `app_database.dart`, not the table definitions. | Replaced table imports (`plant_table.dart`) with the main database import (`app_database.dart`) where the generated part lives. | ✅ Resolved | 10 mins |
| E002 | 2026-06-30 | [LOW] Tooltips in Codebase Visualization render behind sibling layer cards and SVG wire overlay | `docs/architecture_flow.html` — `.code-file:hover`, `.code-folder:hover` tooltips | Each `.code-layer` has `position: relative` which creates a CSS stacking context. The tooltip's `z-index: 100` was scoped to that context, not the page root, so it sat behind adjacent layers (`z-index` siblings) and the SVG `#code-wires` overlay (`z-index: 50` on the page). | (1) Set tooltip `z-index` to `9999`. (2) Added `:hover` rule to elevate the hovered element itself to `z-index: 9999; position: relative`, promoting its stacking context above all siblings. (3) Added `overflow: visible` to `.code-grid` and `.split-right` to prevent ancestor clipping. | ✅ Resolved | 15 mins |

---

## How to Log Errors

When adding a new error entry, use this format:

```
| E001 | YYYY-MM-DD | Brief but specific error description | File/module/screen/feature where it occurred | What actually caused the issue | How it was fixed (include code snippets if helpful) | Open/Resolved | Estimated time spent debugging |
```

### Status Values
| Status | Meaning |
|--------|---------|
| 🔴 Open | Error identified, not yet resolved |
| 🟡 In Progress | Actively being investigated/fixed |
| ✅ Resolved | Fixed and verified |
| 🔁 Recurring | Was resolved but has reappeared |
| ⏸️ Deferred | Known issue, intentionally postponed |

### Severity Levels (optional tag in description)
- **[CRITICAL]** — App crashes, data loss, or blocks development entirely
- **[HIGH]** — Major feature broken, significant UX impact
- **[MEDIUM]** — Feature partially broken, workaround exists
- **[LOW]** — Cosmetic issue, minor inconvenience

---

## Common Error Patterns

*This section will be updated as patterns emerge during development.*

| Pattern | Occurrences | Notes |
|---------|-------------|-------|
| — | — | *No patterns identified yet.* |

---

## Environment Info

| Item | Value |
|------|-------|
| Flutter Version | TBD (not yet set up) |
| Dart Version | TBD |
| Android SDK | TBD |
| IDE | TBD |
| Test Device(s) | TBD |
| OS | Windows |

---

## Notes

- Always log errors immediately when encountered, even if the fix is quick. This builds a knowledge base.
- Include stack traces or error messages verbatim when possible (use code blocks).
- Link to related decisions (decisions.md) or features (features.md) when relevant.
- Time spent helps estimate debugging overhead for future project planning.
