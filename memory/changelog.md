# VerdiTech — Changelog
> Project: VerdiTech | Last Updated: June 27, 2026

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

### Upcoming

- **v0.5.0** — Integration & Asset Packing (WebP crop drawings)
- **v1.0.0** — Thesis-ready release (polished, tested, documented)

*Dates TBD — awaiting client deadline confirmation.*

---

## Notes

- Every code commit or significant change should have a corresponding changelog entry.
- Group related changes under a single version bump when possible.
- Reference related decisions (`decisions.md`) and features (`features.md`) in change descriptions.
