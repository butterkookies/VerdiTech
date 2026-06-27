# VerdiTech — Risk Assessment
> Project: VerdiTech | Last Updated: June 27, 2026

Proactive risk identification and mitigation planning for the VerdiTech project. Risks are assessed by likelihood and impact, with concrete mitigation strategies for each.

---

## Risk Register

| ID | Risk | Likelihood | Impact | Risk Level | Mitigation Strategy | Owner | Status |
|----|------|-----------|--------|------------|---------------------|-------|--------|
| R001 | **Botanical accuracy** — Growth data may not match real-world conditions. Stage durations, environmental weights, and seasonal modifiers are estimates, not field-tested values. | 🟡 Medium | 🟡 Medium | 🟡 Medium | • Use published agricultural data from Philippine sources (DA, UPLB, FAO)<br>• Add disclaimer in-app: "Predictions are estimates based on general agricultural data"<br>• Design parameters as configurable constants for easy tuning<br>• If time permits, compare predictions against known growth timelines | Developer | 🔵 Open |
| R002 | **CA tuning difficulty** — Transition rules may produce unrealistic timelines (too fast, too slow, or erratic growth patterns). Getting the math right is non-trivial. | 🟡 Medium | 🔴 High | 🔴 High | • Start with simple, conservative rules and iterate<br>• Create test cases with known expected outcomes (e.g., "Tomato in ideal conditions should reach harvest in ~85 days")<br>• Build a calibration/debug mode for rapid parameter adjustment<br>• Log all prediction outputs during testing for pattern analysis | Developer | 🔵 Open |
| R003 | **Scope creep** — Client may request additional features mid-development (more plants, weather API, camera features, etc.), expanding beyond the agreed scope. | 🟡 Medium | 🟡 Medium | 🟡 Medium | • Establish clear scope document (`scope.md`) and get client sign-off<br>• Implement a change request process: new features are logged, estimated, and prioritized<br>• Offer "v2" as a container for non-essential requests<br>• Communicate impact of scope changes on timeline | Developer | 🔵 Open |
| R004 | **Thesis panel requirements** — Unknown requirements from the thesis/capstone panel may surface mid-development (specific documentation format, required features, live demo requirements, specific technical criteria). | 🟡 Medium | 🔴 High | 🔴 High | • Ask client about panel expectations early (included in questionnaire)<br>• Request any rubric, evaluation criteria, or technical requirements the panel has published<br>• Build app with demo-friendly features (clear flow, educational content, visual appeal)<br>• Prepare documentation in a format that can be adapted to academic requirements | Developer + Client | 🔵 Open |
| R005 | **Timeline pressure** — Unknown deadline may result in insufficient time for full feature development, testing, and polish. | 🔴 High | 🔴 High | 🔴 Critical | • Prioritize core features (F001–F005) over nice-to-have features (F006–F010)<br>• Use phased delivery: always have a working "minimum viable" version ready<br>• Ask for deadline immediately (included in questionnaire)<br>• Plan for a "good enough" v1 that covers thesis requirements, then polish if time allows<br>• Maintain a clean, always-buildable codebase | Developer | 🔵 Open |

---

## Risk Matrix

|  | 🟢 Low Impact | 🟡 Medium Impact | 🔴 High Impact |
|--|--------------|------------------|----------------|
| 🔴 **High Likelihood** | | | **R005** (Timeline) |
| 🟡 **Medium Likelihood** | | **R001** (Accuracy), **R003** (Scope Creep) | **R002** (CA Tuning), **R004** (Panel Reqs) |
| 🟢 **Low Likelihood** | | | |

---

## Risk Response Strategies

| Strategy | When to Use | Example |
|----------|------------|---------|
| **Avoid** | Eliminate the risk entirely by changing approach | Don't integrate weather API (avoids API dependency risk) |
| **Mitigate** | Reduce likelihood or impact through proactive action | Build configurable parameters to reduce CA tuning risk |
| **Transfer** | Shift risk ownership to another party | Ask client to confirm panel requirements (transfers knowledge gap) |
| **Accept** | Acknowledge the risk and prepare to handle consequences | Accept that botanical data is approximate; add disclaimer |

---

## Contingency Plans

### If R002 (CA Tuning) becomes critical:
1. Simplify the CA model to a basic lookup table with environmental modifiers
2. Use fixed stage durations with percentage adjustments based on environmental score
3. Frame the CA as a "prototype model" in the thesis, acknowledging future calibration needs

### If R005 (Timeline) becomes critical:
1. **Week 1 Cutoff**: If less than 2 weeks remain, focus exclusively on F001–F004 (Input + Engine + Health + Recommendations)
2. **3-Day Cutoff**: If less than 3 days remain, deliver a functional prototype with hardcoded sample data for demo purposes
3. **Emergency**: Pre-build a demo mode that showcases the app flow with predetermined data

### If R004 (Panel Requirements) surfaces new requirements:
1. Assess whether the requirement is achievable within remaining timeline
2. If yes, add to scope and adjust priorities
3. If no, discuss with client and propose alternatives or documentation-only solutions

---

## Risk Review Schedule

| Review Point | Trigger | Action |
|-------------|---------|--------|
| After questionnaire responses | Client responds | Re-assess R003, R004, R005 with new information |
| After Phase 1 (Design) | Design complete | Re-assess R002 (CA tuning) based on rule specification |
| After Phase 2 (Core Dev) | CA engine working | Re-assess R001 (accuracy) and R002 (tuning) based on test results |
| Mid-Phase 3 (UI Dev) | 50% UI complete | Re-assess R005 (timeline) — are we on track? |
| Before Phase 5 (Polish) | Integration complete | Final risk review before delivery |

---

## Notes

- Review risks at each phase transition and after any significant client communication.
- New risks should be added as they're identified — this is a living document.
- Closed risks should be marked as "🟢 Closed" with a note on the outcome, not deleted.
- Risk R005 (Timeline) is the highest priority concern until the client provides a deadline.
