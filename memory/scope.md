# VerdiTech — Scope Definition
> Project: VerdiTech | Last Updated: June 27, 2026

Clear definition of what is included, excluded, and pending for VerdiTech v1. This document prevents scope creep and sets expectations with the client.

> **✅ STATUS: CORE SCOPE CONFIRMED**
> The core features (F001-F005) are confirmed. Nice-to-have features remain pending client response.

---

## ✅ IN SCOPE (v1 — Confirmed)

These features and deliverables are confirmed for the first version of the app.

### Features
| Feature | Description | Reference |
|---------|-------------|-----------|
| **Plant Selection** | Support for exactly 3 plants: Tomato, Eggplant, Siling Labuyo | F001 |
| **User Input Form** | Collect plant type, planting date, growth stage, season, and 3 environmental factor ratings | F001 |
| **CA Prediction Engine** | 1D Cellular Automata model that calculates growth predictions based on inputs | F002 |
| **Health Monitoring** | Display plant health status (Excellent/Good/Fair/Poor/Critical) based on environmental scores | F003 |
| **Recommendation System** | Generate actionable, plant-specific tips for improving suboptimal conditions | F004 |
| **Growth Timeline** | Visual representation of predicted growth from current stage to harvest | F005 |

### Technical
| Item | Description |
|------|-------------|
| **Framework** | Flutter (Dart) |
| **Platform** | Android (APK build) |
| **Architecture** | Clean, maintainable codebase suitable for thesis context |
| **Environmental Factors** | Sunlight, Water, Soil Quality (3 factors, rated by user) |
| **Growth Stages** | Seedling → Young Plant → Flowering → Fruiting (4 stages) |
| **Seasons** | Tag-init (Dry), Tag-ulan (Wet), Malamig (Cool) — Philippine seasons |

### Deliverables
| Deliverable | Format |
|-------------|--------|
| Working Android app | Release APK |
| Source code | Flutter project (full source) |
| Basic documentation | In-code comments + README |

---

## ❌ OUT OF SCOPE (v1 — Excluded)

These items are explicitly not included in the first version. They may be considered for a future version.

| Item | Reason for Exclusion | Future Possibility |
|------|---------------------|-------------------|
| **iOS build** | Client confirmed Android focus; iOS adds testing complexity | Easy to add — Flutter supports both platforms |
| **Cloud sync / backend** | No server needed; adds cost and complexity | Could add Firebase/Supabase later |
| **Camera integration** | Plant photo analysis requires ML models beyond project scope | Would need TFLite/ML Kit — significant effort |
| **Weather API integration** | Adds external dependency; requires internet; API costs possible | Could use OpenWeatherMap free tier |
| **Pest/disease detection** | Requires computer vision or extensive database; beyond scope | Major feature for v2+ |
| **Real-time sensor data** | Requires IoT hardware (moisture sensors, light meters) | Different project category entirely |
| **User accounts / login** | No cloud backend; unnecessary for single-device use | Only needed if cloud sync is added |
| **Social features** | Sharing, community, forums — beyond thesis scope | Not relevant for thesis |
| **Machine learning model** | CA is the specified algorithm; ML is a different approach | Could replace or augment CA in future |
| **Web version** | Mobile app only for thesis | Flutter Web is possible but not needed |
| **Monetization** | No ads, in-app purchases, or premium features | Not appropriate for thesis project |
| **Additional plants beyond 3** | Scope limited to Tomato, Eggplant, Siling Labuyo | Data models designed to be extensible |

---

## ⏳ PENDING (Awaiting Client Input)

These items are proposed but require client confirmation before being placed In Scope or Out of Scope. All are included in the questionnaire sent June 27, 2026.

| Item | Description | Recommendation | Reference | Questionnaire Item |
|------|-------------|----------------|-----------|-------------------|
| **Multiple Plant Tracking** | Dashboard to manage several plants simultaneously | 🟡 Nice-to-Have — adds value but not essential for thesis | F006 | Q10 |
| **CA Visualization** | Animated grid showing the CA algorithm in action | 🟡 Recommended for thesis — demonstrates algorithm visually | F007 | Q3 |
| **Data Persistence** | Save plant profiles and prediction history locally | 🟡 Nice-to-Have — improves UX significantly; essential if F006 is included | F008 | Q4 |
| **Push Notifications** | Local reminders for plant care activities | 🟢 Optional — adds engagement but not core to thesis | F009 | Q5 |
| **About/How It Works** | Educational section explaining the CA algorithm and plant science | 🟡 Recommended for thesis — shows understanding of the algorithm | F010 | — |
| **Language Support** | Filipino/Tagalog in addition to English | 🟢 Optional — adds local relevance but increases content workload | — | Q9 |
| **Dark Mode** | Alternative color scheme for low-light use | 🟢 Optional — easy to implement with Flutter themes | — | Q8 |

---

## Scope Change Process

If the client requests changes to scope during development:

1. **Log the request** in `client_communication.md`
2. **Assess impact** on timeline, complexity, and existing features
3. **Classify** the change:
   - 🟢 **Minor** — Can be absorbed without timeline impact (< 2 hours work)
   - 🟡 **Moderate** — Requires timeline adjustment or reprioritization (2–8 hours)
   - 🔴 **Major** — Significant scope expansion; may require dropping other features (> 8 hours)
4. **Communicate** impact to client with options
5. **Document decision** in `decisions.md`
6. **Update this file** with the scope change

---

## Scope Verification Checklist

Before considering the project complete, verify all In Scope items are delivered:

- [ ] Plant selection works for all 3 plants
- [ ] User input form captures all required data
- [ ] CA engine produces predictions for all 3 plants × 4 stages × 3 seasons
- [ ] Health monitoring displays accurate status
- [ ] Recommendations are contextual and actionable
- [ ] Growth timeline visualization is functional
- [ ] Release APK builds and runs on Android
- [ ] Source code is clean and documented

---

## Notes

- This document is the single source of truth for what the project includes and excludes.
- "Out of Scope" does not mean "never" — it means "not in this version."
- When in doubt about whether something is in scope, check this document first.
- Client must acknowledge the scope before development begins (Phase 1 exit criterion).
