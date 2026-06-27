# VerdiTech — CA Model Spec
> Project: VerdiTech | Last Updated: June 27, 2026

- **Model type**: 1D Timeline CA (recommended) with optional 2D spatial visualization
- **States**: SEED, SEEDLING, YOUNG_PLANT, FLOWERING, FRUITING
- **Health overlays**: HEALTHY, STRESSED, CRITICAL
- **Environmental scoring formula**: E_score = w_sun * S_sun + w_water * S_water + w_soil * S_soil
- **Plant-specific weights table**: (Tomato: 0.40/0.35/0.25, Eggplant: 0.35/0.35/0.30, Siling Labuyo: 0.35/0.25/0.40)
- **Season modifiers table**: (Tag-init, Tag-ulan, Malamig with per-plant multipliers)
- **Stage duration parameters table**: (min/max days per transition per plant)
- **Transition rule pseudocode**: [See Analysis]
- **Neighbor influence mechanics**: (momentum, consistency penalty, cascade effect)
- **State transition diagram description**: [See Analysis]
