# VerdiTech — Requirements Document
> Project: VerdiTech | Last Updated: June 27, 2026

Comprehensive requirements specification for the VerdiTech plant growth prediction mobile app. This document captures all functional and non-functional requirements, constraints, and acceptance criteria.

> **⚠️ STATUS: AWAITING CLIENT QUESTIONNAIRE RESPONSES**
> Requirements marked "Pending" are based on developer analysis and recommendations. They require client confirmation before implementation begins.

---

## 1. Functional Requirements

### 1.1 User Input (FR-001 through FR-007)

| ID | Requirement | Priority | Status | Acceptance Criteria |
|----|-------------|----------|--------|---------------------|
| FR-001 | User can select plant type from three options: Tomato, Eggplant, Siling Labuyo | Core | ✅ Confirmed | Dropdown/selector shows exactly 3 plant options; selection persists |
| FR-002 | User can enter or select planting date | Core | ⏳ Pending | Date picker allows past and current dates; default is today |
| FR-003 | User can select current growth stage: Seedling, Young Plant, Flowering, Fruiting | Core | ⏳ Pending | Four stage options displayed clearly; stages are plant-relevant |
| FR-004 | User can select current season or season is auto-detected from date | Core | ⏳ Pending | Three Philippine seasons available: Tag-init, Tag-ulan, Malamig; auto-detect preferred |
| FR-005 | User can rate Sunlight level (Low/Medium/High or 1–5 scale) | Core | ⏳ Pending | Input is intuitive; includes helper text explaining what each level means |
| FR-006 | User can rate Water availability (Low/Medium/High or 1–5 scale) | Core | ⏳ Pending | Same UX pattern as FR-005 |
| FR-007 | User can rate Soil Quality (Low/Medium/High or 1–5 scale) | Core | ⏳ Pending | Same UX pattern as FR-005; includes brief guidance on soil assessment |

### 1.2 Prediction Engine (FR-008 through FR-012)

| ID | Requirement | Priority | Status | Acceptance Criteria |
|----|-------------|----------|--------|---------------------|
| FR-008 | App uses Cellular Automata algorithm to predict plant growth | Core | ✅ Confirmed | CA engine produces deterministic results for identical inputs |
| FR-009 | Prediction calculates estimated days to next growth stage | Core | ⏳ Pending | Output shows a number of days with reasonable accuracy (±20% of agricultural norms) |
| FR-010 | Prediction accounts for all three environmental factors | Core | ⏳ Pending | Changing any single factor visibly affects the prediction output |
| FR-011 | Prediction accounts for Philippine seasonal conditions | Core | ⏳ Pending | Same inputs with different seasons produce different predictions |
| FR-012 | Prediction generates an overall health score | Core | ⏳ Pending | Health score is displayed as a percentage, category, or visual indicator |

### 1.3 Health Monitoring & Recommendations (FR-013 through FR-016)

| ID | Requirement | Priority | Status | Acceptance Criteria |
|----|-------------|----------|--------|---------------------|
| FR-013 | App displays plant health status based on environmental factors | Core | ⏳ Pending | Health status updates in real-time as user changes inputs |
| FR-014 | App identifies which environmental factors are suboptimal | Core | ⏳ Pending | Deficient factors are visually highlighted (color, icon, label) |
| FR-015 | App provides actionable recommendations for each deficiency | Core | ⏳ Pending | Recommendations are plant-specific and season-aware; text is clear and actionable |
| FR-016 | Recommendations are contextual (different tips for different plants/seasons) | Core | ⏳ Pending | At least 3 unique tips per plant per factor per severity level |

### 1.4 Visualization (FR-017 through FR-019)

| ID | Requirement | Priority | Status | Acceptance Criteria |
|----|-------------|----------|--------|---------------------|
| FR-017 | App displays a visual growth timeline from current stage to harvest | Core | ⏳ Pending | Timeline shows all remaining stages with estimated durations |
| FR-018 | Growth timeline updates dynamically based on input changes | Core | ⏳ Pending | Changing inputs immediately reflects in timeline visualization |
| FR-019 | Optional: Animated CA grid visualization showing algorithm in action | Nice-to-Have | ⏳ Pending Client | Grid animates cell state transitions; includes play/pause controls |

### 1.5 Data Management (FR-020 through FR-023)

| ID | Requirement | Priority | Status | Acceptance Criteria |
|----|-------------|----------|--------|---------------------|
| FR-020 | App saves plant profiles locally on device | Nice-to-Have | ⏳ Pending Client | Data persists across app restarts; no data loss on normal close |
| FR-021 | User can track multiple plants simultaneously | Nice-to-Have | ⏳ Pending Client | Dashboard shows all plants; user can add/edit/delete plants |
| FR-022 | User can view prediction history for each plant | Nice-to-Have | ⏳ Pending Client | History shows past predictions with timestamps |
| FR-023 | Optional: Local push notifications for care reminders | TBD | ⏳ Pending Client | Notifications appear at scheduled times; user can disable them |

### 1.6 Educational Content (FR-024)

| ID | Requirement | Priority | Status | Acceptance Criteria |
|----|-------------|----------|--------|---------------------|
| FR-024 | App includes an "About" or "How It Works" section explaining the CA algorithm | Nice-to-Have | ⏳ Pending Client | Content is accurate, understandable for SHS level, includes diagrams |

---

## 2. Non-Functional Requirements

| ID | Requirement | Category | Status | Acceptance Criteria |
|----|-------------|----------|--------|---------------------|
| NFR-001 | App must work offline (no internet required for core features) | Availability | ⏳ Pending | All core features (F001–F005) function without network connection |
| NFR-002 | Prediction engine must return results within 2 seconds | Performance | ⏳ Pending | Measured on mid-range Android device |
| NFR-003 | App size should not exceed 50MB (APK) | Performance | ⏳ Pending | Measured after release build |
| NFR-004 | App should support Android 6.0 (API 23) and above | Compatibility | ⏳ Pending | Tested on minimum supported API level |
| NFR-005 | UI text should be in English | Localization | ⏳ Pending | Filipino/Tagalog support TBD |
| NFR-006 | App should handle edge cases gracefully (no crashes) | Reliability | ⏳ Pending | No unhandled exceptions in core user flows |
| NFR-007 | App should follow Material Design guidelines | Usability | ⏳ Pending | Consistent with Flutter Material 3 standards |

---

## 3. Constraints

| Constraint | Description | Impact |
|------------|-------------|--------|
| **Client Level** | Client is a Senior High School student (likely thesis/capstone project) | App complexity must be reasonable; documentation should be thesis-friendly |
| **Budget** | Likely limited or zero budget | No paid APIs, services, or assets; all resources must be free/open-source |
| **Timeline** | Unknown — awaiting client response on deadline | Phased delivery approach recommended; core features first |
| **Plant Types** | Limited to three specific vegetables | Data models and UI must support exactly 3 plants for v1 |
| **Environmental Factors** | Limited to three factors (Sunlight, Water, Soil) | Simplified CA model; more factors could improve accuracy but add complexity |
| **Botanical Accuracy** | Growth data based on general agricultural references, not field-tested | App must include disclaimer; predictions are estimates, not guarantees |
| **Platform** | Android only for v1 | iOS support possible via Flutter but not required initially |
| **Data** | No real-time data sources (weather API, sensors) | All environmental data is user-reported; accuracy depends on user input |

---

## 4. Assumptions

1. The client has a basic understanding of Flutter/Dart or will not need to modify the code directly.
2. The thesis panel will evaluate the app's concept, algorithm implementation, and presentation — not production-readiness.
3. Growth stage durations can be approximated from publicly available agricultural data.
4. The CA algorithm does not need to be scientifically validated — it needs to be a reasonable, demonstrable model.
5. The app will be demonstrated on a physical Android device or emulator during the thesis defense.

---

## Notes

- This document will be updated after receiving client questionnaire responses.
- Each requirement should be traceable to a feature in `features.md` and a test case (when testing begins).
- Changes to requirements after confirmation should go through the decision log (`decisions.md`).
