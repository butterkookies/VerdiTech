# VerdiTech — Constraints & Limitations
> Project: VerdiTech | Last Updated: June 27, 2026

This file documents all known constraints, limitations, and boundaries that affect project decisions, scope, and implementation. Constraints are facts we must work within — not problems to solve, but realities to acknowledge and plan around.

---

## Client Constraints

| ID | Constraint | Details | Impact on Project | Mitigation |
|----|-----------|---------|-------------------|------------|
| C001 | **Client is a Senior High School student** | Likely a thesis or capstone project for SHS (Grade 11–12). Academic context means the app must demonstrate understanding of the algorithm, not just be a polished product. | Documentation and "How It Works" section may be weighted heavily by thesis panel. Code complexity should be reasonable. | Include educational content in-app (F010). Prepare thesis-friendly documentation. Keep architecture clean but not over-engineered. |
| C002 | **Budget: Likely limited or zero** | SHS students typically have minimal budget for software development commissions. No budget for paid APIs, assets, hosting, or services. | All resources must be free/open-source. No cloud services, no premium packages, no paid design assets. | Use open-source packages, Material Design (free), free icon sets, self-hosted fonts via Google Fonts. |
| C003 | **Timeline: Unknown** | Client has not yet provided a project deadline or thesis defense date. Timeline could be anywhere from weeks to months. | Cannot create a reliable schedule until deadline is known. Risk of time pressure if deadline is near. | Asked in questionnaire. Use phased delivery so core features are ready first. Always have a "minimum viable" version ready. |
| C004 | **Thesis panel requirements: Unknown** | Different schools and panels have varying expectations for thesis apps. Some require specific documentation, specific features, or live demonstrations. | Unknown requirements may surface mid-development, causing scope changes. | Asked in questionnaire. Request any rubric, evaluation criteria, or panel guidelines the client has. |

---

## Technical Constraints

| ID | Constraint | Details | Impact on Project | Mitigation |
|----|-----------|---------|-------------------|------------|
| C005 | **Three plant types only (v1)** | App supports exactly three plants: Tomato, Eggplant, Siling Labuyo. No mechanism for users to add custom plants. | Limited variety may feel restrictive to users. Data models must be comprehensive for these three but don't need to be extensible for v1. | Design data models to be easily extensible for future plants. Focus on depth (accuracy) over breadth (variety). |
| C006 | **Three environmental factors only** | Sunlight, Water, and Soil Quality are the only inputs to the CA model. Temperature, humidity, pH, fertilizer, and pests are excluded. | Simplified model may produce less accurate predictions. Fewer inputs means simpler UX but less nuanced results. | Acknowledge simplification in the "How It Works" section. Ensure the three chosen factors have meaningful impact on predictions. |
| C007 | **Android only for v1** | Primary and possibly only target platform is Android. iOS support is not confirmed. | No need to test on iOS. Can use Android-specific features if beneficial. | Flutter inherently supports iOS — minimal additional effort if client later requests it. |
| C008 | **No real-time data sources** | No weather API integration, no soil sensors, no camera-based analysis. All environmental data is user-reported. | Prediction accuracy depends entirely on user's ability to assess their environment. Subjective ratings may vary. | Provide clear guidance for each rating level (e.g., "Low sunlight = less than 4 hours direct sun per day"). |
| C009 | **Offline-first requirement (TBD)** | App should likely work without internet since it targets home gardeners who may not always have connectivity. | No cloud features, no real-time data fetching, no analytics. | All computation is local. All data stored on-device. No network dependencies in core features. |

---

## Data & Accuracy Constraints

| ID | Constraint | Details | Impact on Project | Mitigation |
|----|-----------|---------|-------------------|------------|
| C010 | **Botanical data is approximated** | Growth stage durations, environmental preferences, and seasonal modifiers are based on general agricultural references — not field-tested research specific to the app's CA model. | Predictions may not match real-world outcomes precisely. Results are estimates, not scientific guarantees. | Include a disclaimer in the app. Cite data sources. Use conservative ranges rather than exact numbers. Allow for calibration if real-world feedback is available. |
| C011 | **Philippine-specific context** | Seasonal data (Tag-init, Tag-ulan, Malamig) and plant selections are specific to the Philippines. App may not be directly applicable to other climates/regions. | Limits international applicability. Seasons and plant behavior are tailored to tropical climate. | Clearly scope the app as Philippine-focused. This is actually a strength for thesis presentation — shows local relevance. |
| C012 | **CA model is a simplification** | Cellular Automata is being used as a demonstrable algorithm for a thesis, not as the most scientifically accurate growth prediction method. Real agricultural models are far more complex. | The CA model may be questioned by panel members on accuracy. | Frame the CA as a "computational model demonstrating algorithmic prediction" rather than a "scientifically validated growth predictor." Emphasize the educational value of the algorithm. |

---

## Resource Constraints

| ID | Constraint | Details | Impact on Project |
|----|-----------|---------|-------------------|
| C013 | **Single developer** | Project is being developed by one person. | No peer review, no parallel workstreams. Quality depends on self-review and testing. |
| C014 | **No dedicated tester** | No QA team or dedicated tester. Testing is developer-responsibility. | May miss edge cases. Rely on automated tests and systematic manual testing. |
| C015 | **No designer** | No dedicated UI/UX designer. Design decisions made by developer. | UI may be functional but not professionally designed. Use Material Design guidelines as a framework. |

---

## Constraint Status Legend

| Status | Meaning |
|--------|---------|
| 🔒 Fixed | Cannot be changed — fundamental constraint |
| ⏳ TBD | May change based on client response |
| 🔄 Flexible | Can be adjusted if needed |

---

## Notes

- Constraints are not problems — they're boundaries. Design within them, don't fight them.
- When a constraint changes (e.g., client confirms deadline), update this file and log the change in `decisions.md`.
- Some constraints may become features (e.g., Philippine-specific focus is a selling point for the thesis).
