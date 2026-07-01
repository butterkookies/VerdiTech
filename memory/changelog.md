# VerdiTech — Changelog
> Project: VerdiTech | Last Updated: June 30, 2026

Chronological record of all project changes, releases, and milestones. Follows [Semantic Versioning](https://semver.org/) principles adapted for this project.

---

## Versioning Scheme

- **Major (X.0.0)** — Significant feature releases or milestones (e.g., v1.0.0 = thesis-ready release)
- **Minor (0.X.0)** — New features or substantial additions
- **Patch (0.0.X)** — Bug fixes, refinements, documentation updates

---

## Changelog

### v0.0.1 — Project Initialization (June 27, 2026)

**Author:** Developer

**Changes:**
- 📁 Project folder structure created under `COMMISSIONS/Temp/`
- 📊 Comprehensive technical analysis of client specification completed
- 📝 Client questionnaire prepared and sent (15+ clarification questions)
- 🧠 Project memory system established with 13 tracking files:
  - `decisions.md` — Decision log with 7 initial decisions
  - `errors_and_solutions.md` — Error tracking (empty, pre-development)
  - `features.md` — 10 features catalogued (F001–F010)
  - `techstack.md` — Technology stack candidates identified
  - `requirements.md` — 24 functional + 7 non-functional requirements documented
  - `client_communication.md` — 2 communication entries logged
  - `changelog.md` — This file
  - `constraints.md` — 8 project constraints identified
  - `research.md` — CA theory, plant data, Philippine seasons documented
  - `risks.md` — 5 risks assessed with mitigations
  - `milestones.md` — 6-phase project plan outlined
  - `scope.md` — In/Out/Pending scope defined
  - `references.md` — Reference sources catalogued
- 🌱 Three plants identified: Tomato, Eggplant, Siling Labuyo
- 🔬 1D Cellular Automata recommended as prediction engine (hybrid with optional 2D viz)
- 📱 Android confirmed as primary platform; Flutter confirmed as framework

**Status:** Phase 0 (Requirements Gathering) — Awaiting client questionnaire responses.

### v0.1.0 — Design & Spec Confirmation (June 27, 2026)

**Author:** Developer

**Changes:**
- 📝 Core specification (F001-F005) explicitly confirmed by client.
- 🎨 Interactive Architecture and App Flow visualization created (`docs/architecture_flow.html`).
- 📱 Actual UI Mockups designed and integrated (Material Design, green accents).
- 🧠 Domain knowledge guide generated, capturing plant biology, Philippine agriculture context, and 1D CA theory.
- 🗂️ Memory files updated (requirements, scope, milestones, decisions) to reflect confirmed Phase 0 and Phase 1 completion.

**Status:** Phase 2 (Core Development) — In Progress.

---

### v0.2.0 — Staging Logs & Unified Timeline Planning (June 28, 2026)

**Author:** Developer

**Changes:**
- 📝 Proposed and approved **Unified Live Timeline** & **Daily Staging Logs** (Flo-app cycle tracking concept).
- 🧠 Documented new specifications and data models for `DailyLog` entity.
- 🗂️ Promoted local database persistence and dashboard tracking features to confirmed core scope.
- 🎨 Planned integration of 24 dynamic staging illustrations.

**Status:** Phase 2 (Core Development) — DB & CA Engine implementation scheduled.

---

### v0.4.0 — Core Engine & UI Implementation (June 28, 2026)

**Author:** Agent

**Changes:**
- ⚙️ **Prediction Engine**: Fully implemented `CaEngine` for 1D growth state transitions, factoring in plant type, seasons (Tag-init, Tag-ulan, Malamig), and 3 environmental factors.
- 💡 **Recommendation Engine**: Intelligent `RecommendationEngine` added for situational care tips.
- 🗄️ **Database Layer**: Drift schema, DAOs, and Repositories built for local persistence.
- 🔄 **State Management**: Integrated full Riverpod provider suite (Streams and StateNotifiers).
- 🎨 **UI/UX**: Feature-first screens created for dashboard, plant forms, details, CA visualizations, and about pages.
- 🧪 **Testing**: Added smoke tests and `ca_engine_test.dart` to verify logic.
- 🛠️ **Static Analysis**: Resolved all linting, deprecations, and generated type issues.

**Status:** Phase 4 (Integration) — Complete. App is ready for physical device testing.

---

### v0.4.1 — Documentation Accuracy Audit & UI Fix (June 30, 2026)

**Author:** Agent

**Changes:**
- 🔍 **Architecture Doc Audit**: Full line-by-line verification of `docs/architecture_flow.html` Codebase Visualization section against the real `src/lib/` codebase.
- 🐛 **9 Inaccuracies Found & Fixed** in the Codebase Visualization:
  - Added missing features: `ca_visualization` and `about` (5 features are now shown, not 3).
  - Added 4 missing domain models: `enums.dart`, `environment_profile.dart`, `day_prediction.dart`, `recommendation.dart` (all 6 models now shown).
  - Added entirely missing `data/mappers/` layer (`plant_mapper.dart`, `daily_log_mapper.dart`).
  - Added missing `daily_log_table.dart` to the data/tables section.
  - Corrected `main.dart` tooltip (it does NOT initialize the DB; correctly lists all 5 GoRouter routes).
  - Fixed `triggerPlantCard` wire: removed false DB read hop — `CaEngine` is pure computation.
  - Fixed `triggerTodayLog` wire: now correctly points to `plant_providers.dart` (`dailyLogsForPlantProvider`) instead of `databaseProvider`.
  - Fixed `triggerSaveLog` wire: now correctly shows full 4-hop path: `database_provider (plantRepositoryProvider) → plant_repository → daily_log_dao → daily_log_table` (was bypassing the repository entirely).
  - Updated all tooltips to reflect real method names, types, and relationships.
- 🐛 **Tooltip Layering Bug Fixed**: Tooltips were rendering behind sibling `.code-layer` cards and the SVG wire overlay. Fixed by elevating hovered elements to `z-index: 9999` and adding `overflow: visible` to `.code-grid` and `.split-right`.

**Status:** Phase 5 (Polish & Delivery) — Documentation and visualization accuracy verified.

---

### v0.5.0 — Staging Logs & Unified Timeline Implementation (June 30, 2026)

**Author:** Developer & Client

**Changes:**
- ✨ **Daily Staging Logs**: Fully implemented the `add_daily_log_dialog.dart` and `daily_log_providers.dart` allowing users to record actual environmental inputs over time.
- 🕒 **Unified Live Timeline**: Successfully integrated historical daily logs with the CA engine's forecasted growth timeline inside `plant_details_screen.dart`.
- 📱 **Client Verification**: App successfully built and verified on a physical device/emulator. Core flow, predictions, and UI have been signed off.

**Status:** Phase 5 (Polish & Delivery) — In Progress.

### v0.5.1 — Phase 5 Polish Paused & UI Redesign Branch (June 30, 2026)

**Author:** Developer & Client

**Changes:**
- ✨ **UI Redesign Planned**: Received "Living Earth" Figma Make UI code.
- 🌿 **Branch Created**: `feature/ui-enhancements-living-earth` branch created to integrate the premium UI over the functional Phase 5 codebase.
- 💾 **Memory Updated**: Saved raw Figma Make output to `memory/figma_make_living_earth_ui.md` for safe incremental integration.

**Status:** Phase 5 (Polish & Delivery) — UI Redesign in progress on feature branch.

---

### v0.5.2 — Phase 5 Final Polish & Notifications (June 30, 2026)

**Author:** Agent

**Changes:**
- 🔔 **Push Notifications**: Implemented local push notifications via `flutter_local_notifications` with three channels (Harvest Alerts, Daily Care Reminders, Stage Milestones). Configured `coreLibraryDesugaring` in `build.gradle.kts` to support Java 8+ time APIs on older Androids.
- 🎨 **About Screen Redesign**: Fully redesigned `about_screen.dart` with animated hero banner, card-based sections, and transition rule pills. Fixed visibility issues in dark mode by correctly applying `VTTheme.of(context)`.
- 🌱 **Growth Stage Selector**: Added `GrowthStage` selector in the Add Plant flow, allowing users to track mature plants, which dynamically offsets prediction timelines and notification schedules.
- 📖 **Care Tutorials**: Added `care_tutorial_sheet.dart` offering species-specific care instructions (Tomato, Eggplant, Siling Labuyo) accessible via a book icon in the Plant Details screen.
- 🧹 **Dashboard Clean-up**: Removed redundant "VerdiTech Dashboard" title and "Your Plants" section header for a cleaner UI.
- 🌿 **Theme Expansion**: Added `VTSpace.xxl` spacing constant to `verditech_theme.dart`.
- 🔀 **Branching**: All changes committed to `feature/temp`, merged into `staging`, and pushed to remote GitHub repository.

**Status:** Phase 5 (Polish & Delivery) — Complete. Codebase pushed to `staging`.

---

### v0.5.3 — CA Engine Prediction Tuning & Fixes (July 1, 2026)

**Author:** Agent

**Changes:**
- ⚙️ **Accurate CA Timelines**: Resolved an issue where greenhouse tomatoes were incorrectly forecasting harvest at 58 days. Updated `_minStageDays` to scientifically grounded values (Seedling: 25, Young: 20, Flowering: 20, Fruiting: 25) yielding ~90+ days before harvest.
- 🌦️ **Environmental Penalties**: Added logic in `computeEnvScore()` inside `CaEngine` to enforce growth penalties when exposed to extreme moisture (>4.5 deducts 0.30) or extreme light (>4.5 deducts 0.20) simulating fungal risk and photo-inhibition.
- 🐛 **Forecast Limit Fixed**: The CA engine `forecastProvider` was artificially truncating timeline generation at exactly 60 days, preventing it from completing later stages like Flowering and Fruiting. Increased the simulation limit to 180 days.
- 🐛 **UI Hardcoding Removed**: Replaced the hardcoded '58 days' string in `add_plant_sheet.dart` with a dynamic forecast generated via `engine.estimateDaysToHarvest()` using a dummy `Plant` model based on user slider inputs.
- 🐛 **Compiler Fix**: Fixed a build failure (`The argument type 'int' can't be assigned to the parameter type 'double'`) when providing the dummy `sunlightScore` and `waterScore` to `Plant` in the Add Plant UI by switching from `.round()` to `.roundToDouble()`.

**Status:** Phase 5 (Polish & Delivery) — Final UI fixes complete and verified.

---

### v0.5.3 — Codebase Consolidation & Client Specs Audit (July 1, 2026)

**Author:** Agent

**Changes:**
- 🔍 **Client Specs Audit**: Conducted an exhaustive audit cross-referencing all client specs (`requirements.md`, `ca_model_spec.md`, `verditech_spec.md`) against the actual codebase. Findings documented in `audit_report.md`.
- ✅ **Compliance Verified**: Confirmed ~100% implementation of core and optional features, including animated CA grids and push notifications.
- 🗑️ **Codebase Consolidation**: Removed the redundant `verditech_flutter` directory. Standardized all future development strictly onto the `src/` directory, which holds the robust Drift database layer and integrated CA engines.

**Status:** Phase 5 (Polish & Delivery) — Codebase consolidated and fully audited against specs.

---

### v0.5.4 — UI Variant Mockup Generation (July 1, 2026)

**Author:** Agent

**Changes:**
- 🎨 **Minimalist Modern Soft UI Design System**: Created a new UI mockup variant in Stitch MCP enforcing the "Gentle Growth" aesthetic (soft greens, heavily rounded components, off-white canvas, Inter typography).
- 🖼️ **Stitch Home Dashboard**: Generated a mobile-first UI for the VerdiTech Home Dashboard mapped perfectly to current app functionality (Tomato, Eggplant, Siling Labuyo list with prediction states).

---

### Upcoming

- **v1.0.0** — Thesis-ready release (Final polish, assets, and documentation)

*Dates TBD — awaiting client deadline confirmation.*

---

## Notes

- Every code commit or significant change should have a corresponding changelog entry.
- Group related changes under a single version bump when possible.
- Reference related decisions (`decisions.md`) and features (`features.md`) in change descriptions.
