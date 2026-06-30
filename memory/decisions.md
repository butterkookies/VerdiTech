# VerdiTech — Decision Log
> Project: VerdiTech | Last Updated: June 30, 2026

This file tracks all major project decisions, their rationale, and current status. Every architectural choice, scope change, or client-confirmed direction is recorded here for traceability.

---

## Decision Record

| # | Date | Decision | Rationale | Status | Decided By |
|---|------|----------|-----------|--------|------------|
| D001 | 2026-06-27 | App name is temporarily **'Temp'** (pending client confirmation of **'VerdiTech'**) | Client has not yet confirmed the proposed name. 'VerdiTech' was suggested as a blend of 'Verde' (green) + 'Tech' (technology), fitting the plant growth prediction theme. Working folder uses 'Temp' until confirmed. | ⏳ Pending Client | Developer |
| D002 | 2026-06-27 | Using **Flutter** framework | Client specified Flutter as the required framework. Aligns with cross-platform capability and Dart language. Likely a thesis/capstone requirement. | ✅ Confirmed | Client |
| D003 | 2026-06-27 | Target platform: **Android** (iOS TBD) | Primary target is Android due to prevalence in the Philippine market and likely thesis demo requirements. iOS support may be added later if needed, since Flutter supports both. | ✅ Confirmed (Android) / ⏳ Pending (iOS) | Developer + Client |
| D004 | 2026-06-27 | Using **1D Cellular Automata** for prediction engine (recommended hybrid with optional 2D visualization) | 1D CA is sufficient for modeling plant growth stages as a linear progression influenced by environmental factors. A hybrid approach is recommended: 1D CA handles the core prediction logic, while an optional 2D grid visualization can provide a more engaging user experience. Pure 2D CA would add complexity without proportional benefit for this use case. | ✅ Confirmed | Developer + Client |
| D005 | 2026-06-27 | Three vegetables selected: **Tomato**, **Eggplant**, **Siling Labuyo** | Client specified these three crops. All are common Philippine vegetables with well-documented growth patterns. Siling Labuyo is a native Philippine chili pepper, adding local relevance to the project. | ✅ Confirmed | Client |
| D006 | 2026-06-27 | Four growth stages: **Seedling → Young Plant → Flowering → Fruiting** | Simplified growth model appropriate for the app's scope. Covers the key observable stages a home gardener would recognize. More granular stages (germination, transplanting, harvesting) excluded for simplicity but could be added later. | ✅ Confirmed | Developer + Client |
| D007 | 2026-06-27 | Three environmental factors: **Sunlight**, **Water**, **Soil Quality** | These are the most impactful and user-observable factors for home gardening. Temperature, humidity, and pH were considered but excluded to keep the input model simple for SHS-level understanding and user experience. Each factor will be rated on a scale (e.g., Low/Medium/High or 1–5). | ✅ Confirmed | Developer + Client |
| D008 | 2026-06-27 | State Management: **Riverpod (v3.x)** | Chosen over BLoC due to lower boilerplate, better async data handling, and compile-time safety. It's the modern industry standard and easier to explain in an academic defense than strict event-driven architectures. | ✅ Confirmed | Developer |
| D009 | 2026-06-27 | Local Database: **Drift** | Chosen over NoSQL options (Hive/ObjectBox) because the app handles relational data (Plants have multiple Predictions). Drift provides a type-safe ORM over SQLite with excellent offline-first reactive streams. | ✅ Confirmed | Developer |
| D010 | 2026-06-27 | Architecture Pattern: **Feature-First (Domain-Driven)** | Chosen over strict layer-by-layer Clean Architecture. Organizing folders by feature (e.g., `plants/`, `predictions/`) makes the codebase more cohesive and significantly easier to present during a thesis defense. | ✅ Confirmed | Developer |
| D011 | 2026-06-28 | Unified Live Timeline & Staging Logs System | User confirmed implementation of daily log history + dynamic CA future forecast (concept analogous to Flo app's cycle tracker) to improve UI/UX engagement and panel demonstrability. | ✅ Confirmed | Developer + Client |
| D012 | 2026-06-28 | **Automated Skill Chooser for Implementation** | Utilized Antigravity 2.0 agent rules (`AGENTS.md`) and specialized skills (`.agents/skills/`) to automatically map Flutter architectural patterns, UI standards, and testing setups to their respective domains during codebase construction. | ✅ Confirmed | Developer + Client |
| D013 | 2026-06-30 | **Architecture documentation must be audited against code before each phase delivery** | During Phase 5 review, 9 inaccuracies were found in `docs/architecture_flow.html` Codebase Visualization — missing features, layers, models, and wrong interactive wire flows. Established practice: any documentation visualization must be verified line-by-line against real source files before delivery. | ✅ Confirmed | Developer |
---

## Decision Status Legend

| Status | Meaning |
|--------|---------|
| ✅ Confirmed | Agreed upon by client and developer |
| ⏳ Pending Client | Awaiting client response/confirmation |
| 🔄 Revised | Previously decided, now changed |
| ❌ Rejected | Proposed but not accepted |

---

## Notes

- Remaining decisions will be confirmed once client finishes the questionnaire.
- Decision numbering is sequential. Never reuse a decision number; mark old decisions as Revised if they change.
- All decisions should reference the relevant questionnaire item or communication entry where applicable.
