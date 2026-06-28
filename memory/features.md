# VerdiTech — Feature List
> Project: VerdiTech | Last Updated: June 27, 2026

Complete feature inventory for the VerdiTech plant growth prediction app. Features are categorized by priority and tracked through development phases.

---

## Feature Registry

| ID | Feature | Description | Priority | Status | Phase |
|----|---------|-------------|----------|--------|-------|
| F001 | **User Input System** | Form-based input allowing users to select: plant type (Tomato/Eggplant/Siling Labuyo), planting date, current growth stage (Seedling/Young Plant/Flowering/Fruiting), current season, and rate three environmental factors (Sunlight, Water, Soil Quality) on a scale. | 🔴 Core | 📋 Planned | Phase 2–3 |
| F002 | **Growth Prediction Engine** | 1D Cellular Automata model that takes user inputs and simulates plant growth progression. Calculates expected days to next stage, overall health score, and predicted timeline to harvest. Uses transition rules weighted by environmental factor scores and seasonal modifiers. | 🔴 Core | 📋 Planned | Phase 2 |
| F003 | **Plant Health Monitoring** | Real-time health status display based on current environmental factor ratings. Shows overall health indicator (Excellent/Good/Fair/Poor) and identifies which factors are suboptimal. Updates dynamically as user adjusts input values. | 🔴 Core | 📋 Planned | Phase 2–3 |
| F004 | **Recommendation System** | Generates actionable, context-specific tips based on identified deficiencies. If water is rated Low for Tomato in Tag-init (dry season), suggests specific watering frequency/volume. Tips are plant-specific and season-aware. | 🔴 Core | 📋 Planned | Phase 2–3 |
| F005 | **Growth Timeline Visualization** | Visual representation of the predicted growth journey — from current stage to harvest. Shows estimated days per stage, progress indicators, and key milestones. Could be a horizontal timeline, progress bar, or stage-based card layout. | 🔴 Core | 📋 Planned | Phase 3 |
| F006 | **Plant Dashboard** | Multi-plant tracking interface allowing users to manage several plants simultaneously. Each plant has its own profile with input data, predictions, and health status. List/grid view of all tracked plants. | 🔴 Core | ✅ Confirmed | Phase 2–3 |
| F007 | **CA Visualization** | Animated grid visualization showing the Cellular Automata computation in action. Cells change color/state over time to illustrate how the prediction evolves. Educational and visually engaging — may strengthen thesis presentation. | 🟡 Nice-to-Have | ⏳ Pending Client | Phase 3–4 |
| F008 | **Data Persistence** | Local storage solution to save plant profiles, prediction history, and user preferences across app sessions. No cloud sync — purely on-device storage. Candidates: sqflite, Hive, or drift. | 🔴 Core | ✅ Confirmed | Phase 2 |
| F009 | **Push Notifications** | Local push notifications reminding users to water plants, check on growth, or update environmental ratings. Scheduled based on prediction data (e.g., "Your tomato should be entering Flowering stage soon!"). | 🟢 TBD | ⏳ Pending Client | Phase 4 |
| F010 | **About / How It Works** | Educational section explaining what Cellular Automata is, how the prediction model works, and the science behind the growth factors. Important for thesis context — demonstrates understanding of the algorithm. | 🟡 Nice-to-Have | ⏳ Pending Client | Phase 3 |
| F011 | **Daily Staging Logs** | Form-based input to record daily environmental factor ratings (Sunlight, Water, Soil Quality) on a 1-5 scale for any day since planting, persisted locally. | 🔴 Core | 📋 Planned | Phase 2 |
| F012 | **Unified Live Timeline** | Chronological scrolling list combining historical logged days (with dynamic crop illustrations indicating health and stage) and future days displaying the CA model's forecast. | 🔴 Core | 📋 Planned | Phase 2–3 |

---

## Priority Legend

| Priority | Meaning |
|----------|---------|
| 🔴 Core | Must-have for v1. App is incomplete without it. |
| 🟡 Nice-to-Have | Enhances the app significantly but not strictly required. |
| 🟢 TBD | Priority not yet determined — awaiting client input. |

## Status Legend

| Status | Meaning |
|--------|---------|
| 📋 Planned | Scoped and understood, not yet started |
| ⏳ Pending Client | Awaiting client confirmation on inclusion |
| 🚧 In Progress | Currently being developed |
| 🔍 In Review | Developed, under testing/review |
| ✅ Done | Completed and verified |
| ❌ Cut | Removed from scope |

---

## Feature Dependencies

```
F001 (User Input) ──► F002 (CA Engine) ──► F003 (Health Monitor)
                                       ──► F004 (Recommendations)
                                       ──► F005 (Timeline Viz)
F002 ──► F007 (CA Visualization) [optional]
F001 ──► F006 (Dashboard) [requires F008]
F008 (Data Persistence) ──► F006 (Dashboard)
                         ──► F009 (Notifications)
F010 (About) ── standalone, no dependencies
```

---

## Feature Notes

- **F001–F005** are the core feature set. The app is functional with just these five features.
- **F006–F010** are enhancements. Their inclusion depends on client priorities, timeline, and thesis panel requirements.
- **F007 (CA Visualization)** could be a strong differentiator for the thesis defense — it demonstrates the algorithm visually.
- **F008 (Data Persistence)** becomes essential if F006 (Dashboard) is included, since tracking multiple plants requires saving state.
- All "Pending Client" features are included in the questionnaire sent on June 27, 2026.
