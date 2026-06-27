# VerdiTech — Research Notes
> Project: VerdiTech | Last Updated: June 27, 2026

Compiled research supporting the VerdiTech prediction engine. This covers Cellular Automata theory, plant-specific growth data, environmental factor analysis, and Philippine agricultural context.

---

## 1. Cellular Automata Theory

### 1.1 What is Cellular Automata?

Cellular Automata (CA) is a computational model consisting of a grid of cells, each in one of a finite number of states. The state of each cell evolves over discrete time steps according to a set of rules based on the states of neighboring cells.

**Key Components:**
- **Cells** — Individual units in the grid, each holding a state
- **States** — Finite set of possible values for each cell (e.g., Seedling=1, Young=2, Flowering=3, Fruiting=4)
- **Neighborhood** — The cells that influence a given cell's next state
- **Transition Rules** — The logic that determines how cells evolve
- **Time Steps** — Discrete iterations of the simulation

### 1.2 1D vs 2D Cellular Automata

| Aspect | 1D CA | 2D CA |
|--------|-------|-------|
| **Structure** | Linear array of cells | Grid (matrix) of cells |
| **Neighborhood** | Left and right neighbors | 4 (von Neumann) or 8 (Moore) neighbors |
| **Visualization** | Time evolution shown as rows stacked vertically | Animated grid changing over time |
| **Complexity** | Lower — easier to implement and explain | Higher — more visually impressive |
| **Suitability for Growth** | Good for modeling linear progression through stages | Good for modeling spatial spread (e.g., plant canopy growth) |

### 1.3 How CA Applies to Plant Growth (VerdiTech Model)

**Recommended Approach: 1D CA (Hybrid)**

The plant's growth is modeled as a 1D array where:
- Each **cell position** represents a discrete time step (day)
- Each **cell state** represents the plant's condition at that time step
- **Transition rules** determine whether the plant progresses to the next growth stage, maintains current stage, or degrades

**State Encoding (Proposed):**
```
State 0: Not yet planted / Empty
State 1: Seedling
State 2: Young Plant
State 3: Flowering
State 4: Fruiting
State 5: Harvest-ready (terminal state)
State -1: Dead / Failed (environmental stress)
```

**Transition Rule Logic (Simplified):**
```
next_state = f(current_state, environmental_score, days_in_stage, season_modifier)

If environmental_score >= threshold AND days_in_stage >= min_days:
    next_state = current_state + 1  (progress to next stage)
Elif environmental_score < critical_threshold:
    next_state = current_state - 1  (regression / stress)
Else:
    next_state = current_state  (remain in current stage, growth delayed)
```

**Environmental Score Calculation:**
```
env_score = (sunlight_weight × sunlight_rating +
             water_weight × water_rating +
             soil_weight × soil_rating) × season_modifier
```

### 1.4 Optional 2D Visualization

A 2D grid could visualize the CA simulation for educational/thesis purposes:
- **Rows** = time steps (days progressing downward)
- **Columns** = different aspects of plant health or parallel simulations
- **Colors** = Green (healthy), Yellow (stressed), Red (critical), Dark Green (harvest-ready)

This is purely for visualization — the core prediction logic remains 1D.

---

## 2. Plant Growth Data

### 2.1 Tomato (*Solanum lycopersicum*)

| Growth Stage | Typical Duration | Key Needs | Notes |
|-------------|-----------------|-----------|-------|
| **Seedling** | 14–28 days | High sunlight (6–8 hrs), consistent moisture, well-drained soil | Germination takes 5–10 days; seedlings emerge after |
| **Young Plant** | 21–35 days | Full sun, regular watering, nutrient-rich soil | Vegetative growth phase; develops strong stem and leaves |
| **Flowering** | 14–21 days | Full sun, moderate water (avoid over-watering), balanced soil | Flowers appear; pollination needed for fruit set |
| **Fruiting** | 20–30 days | Full sun, consistent watering, phosphorus-rich soil | Fruits develop and ripen; color changes indicate maturity |
| **Total to Harvest** | ~70–115 days | — | Varies by variety; Philippine conditions may accelerate |

**Environmental Preferences:**
| Factor | Optimal | Tolerable | Critical (Stress) |
|--------|---------|-----------|-------------------|
| Sunlight | 6–8 hours direct | 4–6 hours | < 4 hours |
| Water | Regular, even moisture | Slightly dry/wet | Waterlogged or drought |
| Soil | Rich, well-drained, pH 6.0–6.8 | Moderate quality | Poor drainage, nutrient-deficient |

### 2.2 Eggplant (*Solanum melongena*)

| Growth Stage | Typical Duration | Key Needs | Notes |
|-------------|-----------------|-----------|-------|
| **Seedling** | 14–21 days | Warm conditions, moderate sunlight, moist soil | Sensitive to cold; thrives in Philippine tropical climate |
| **Young Plant** | 28–42 days | Full sun (6–8 hrs), consistent moisture, rich soil | Longer vegetative phase than tomato; develops broad leaves |
| **Flowering** | 14–21 days | Full sun, moderate water, well-fertilized soil | Multiple flowering cycles possible |
| **Fruiting** | 14–21 days | Full sun, regular watering, potassium-rich soil | Harvest when skin is glossy; overripe fruits become bitter |
| **Total to Harvest** | ~70–105 days | — | Can produce fruits for extended periods |

**Environmental Preferences:**
| Factor | Optimal | Tolerable | Critical (Stress) |
|--------|---------|-----------|-------------------|
| Sunlight | 6–8 hours direct | 5–6 hours | < 4 hours |
| Water | Consistent, deep watering | Slightly variable | Drought or waterlogged |
| Soil | Fertile, well-drained, pH 5.5–6.5 | Average quality | Heavy clay, poor drainage |

### 2.3 Siling Labuyo (*Capsicum frutescens*)

| Growth Stage | Typical Duration | Key Needs | Notes |
|-------------|-----------------|-----------|-------|
| **Seedling** | 14–21 days | Warm temperatures, partial to full sun, moist soil | Native Philippine chili; well-adapted to local conditions |
| **Young Plant** | 21–35 days | Full sun, moderate water, well-drained soil | Compact bushy growth; hardy and drought-tolerant once established |
| **Flowering** | 14–21 days | Full sun, moderate water, avoid over-fertilization | Small white flowers; self-pollinating |
| **Fruiting** | 21–30 days | Full sun, moderate water, well-drained soil | Small, very hot peppers; turn from green to red when ripe |
| **Total to Harvest** | ~70–107 days | — | Continuous producer once fruiting begins |

**Environmental Preferences:**
| Factor | Optimal | Tolerable | Critical (Stress) |
|--------|---------|-----------|-------------------|
| Sunlight | 6–8 hours direct | 4–6 hours | < 3 hours |
| Water | Moderate, allow slight drying | Variable (drought-tolerant) | Prolonged waterlogging |
| Soil | Well-drained, moderate fertility, pH 6.0–6.8 | Most soil types | Very heavy, waterlogged soil |

---

## 3. Environmental Factor Scoring

### 3.1 Proposed Rating Scale

Each environmental factor is rated on a 1–5 scale by the user:

| Rating | Label | General Description |
|--------|-------|---------------------|
| 1 | Very Low | Severely deficient; plant is at risk |
| 2 | Low | Below optimal; growth will be noticeably slower |
| 3 | Moderate | Adequate; plant can grow but not at full potential |
| 4 | Good | Near-optimal conditions |
| 5 | Excellent | Ideal conditions for this plant |

### 3.2 Factor Weights per Plant (Proposed)

Weights determine how much each factor influences the overall environmental score. Weights should sum to 1.0 for each plant.

| Plant | Sunlight Weight | Water Weight | Soil Weight | Reasoning |
|-------|----------------|--------------|-------------|-----------|
| **Tomato** | 0.35 | 0.40 | 0.25 | Tomatoes are very sensitive to water consistency; sunlight is crucial for fruit sweetness |
| **Eggplant** | 0.30 | 0.35 | 0.35 | Eggplant needs rich soil and consistent moisture; balanced needs |
| **Siling Labuyo** | 0.40 | 0.25 | 0.35 | Native and drought-tolerant; sunlight is the primary driver; less water-dependent |

### 3.3 Environmental Score Formula

```
env_score = (sunlight_weight × sunlight_rating +
             water_weight × water_rating +
             soil_weight × soil_rating) / 5.0

Result: 0.0 to 1.0 (normalized)
```

**Score Interpretation:**
| Score Range | Health Status | Effect on Growth |
|-------------|---------------|------------------|
| 0.8–1.0 | 🟢 Excellent | Progresses at normal/accelerated rate |
| 0.6–0.79 | 🟡 Good | Progresses normally; minor delays possible |
| 0.4–0.59 | 🟠 Fair | Growth significantly delayed; stress signs |
| 0.2–0.39 | 🔴 Poor | Growth stalled; risk of regression |
| 0.0–0.19 | ⚫ Critical | Plant at risk of death; immediate intervention needed |

---

## 4. Philippine Agricultural Seasons

### 4.1 Season Definitions

The Philippines has three recognized seasons that significantly affect agriculture:

| Season | Filipino Name | Months | Temperature Range | Rainfall | Agricultural Character |
|--------|--------------|--------|-------------------|----------|----------------------|
| **Dry/Hot Season** | Tag-init (Tag-araw) | March – May | 28–36°C | Very low | High evaporation; irrigation critical; good sunlight |
| **Wet/Rainy Season** | Tag-ulan | June – November | 24–32°C | High (typhoon season) | Abundant water; flood risk; reduced sunlight on cloudy days |
| **Cool/Dry Season** | Malamig (Amihan) | December – February | 22–28°C | Low to moderate | Moderate temperatures; good growing conditions for most vegetables |

### 4.2 Seasonal Modifiers for CA Model (Proposed)

Season modifiers adjust the growth rate based on how favorable the season is for each plant:

| Plant | Tag-init (Dry) | Tag-ulan (Wet) | Malamig (Cool) | Notes |
|-------|---------------|-----------------|----------------|-------|
| **Tomato** | 0.85 | 0.70 | 1.00 | Best in cool-dry season; wet season increases disease risk |
| **Eggplant** | 0.90 | 0.80 | 0.95 | Tolerates heat well; wet season is manageable |
| **Siling Labuyo** | 0.95 | 0.85 | 0.90 | Hardy and adaptable; performs well in most conditions |

**Modifier Application:**
```
adjusted_env_score = env_score × season_modifier

If adjusted_env_score >= 0.7: normal progression
If adjusted_env_score >= 0.4: delayed progression (days × 1.5)
If adjusted_env_score < 0.4: stalled (no progression; risk of regression)
```

### 4.3 Auto-Detection Logic

Season can be auto-detected from the planting date:

```dart
String detectSeason(DateTime date) {
  int month = date.month;
  if (month >= 3 && month <= 5) return 'Tag-init';   // Dry/Hot
  if (month >= 6 && month <= 11) return 'Tag-ulan';  // Wet/Rainy
  return 'Malamig';                                    // Cool/Dry (Dec-Feb)
}
```

---

## 5. References to Investigate

### Academic / Agricultural Sources
- [ ] Philippine Department of Agriculture (DA) — crop production guides
- [ ] UPLB (University of the Philippines Los Baños) — vegetable production manuals
- [ ] PhilRice / PCAARRD — agricultural research publications
- [ ] Bureau of Plant Industry (BPI) — crop data and best practices
- [ ] PAGASA — detailed seasonal/climate data for the Philippines
- [ ] FAO (Food and Agriculture Organization) — tropical vegetable cultivation guides

### Cellular Automata References
- [ ] Stephen Wolfram, "A New Kind of Science" (2002) — foundational CA reference
- [ ] Wolfram MathWorld — CA classification and rule documentation
- [ ] Research papers on CA applications in biological modeling
- [ ] Research papers on CA for agricultural/plant growth simulation

### Technical References
- [ ] Flutter documentation — official docs for framework
- [ ] Dart language tour — language reference
- [ ] pub.dev — package repository for dependency research

---

## Research Status

| Topic | Status | Confidence | Notes |
|-------|--------|------------|-------|
| CA Theory | ✅ Documented | High | Core concepts well understood |
| Plant Growth Stages | ✅ Documented | Medium | Based on general agricultural data; needs Philippine-specific validation |
| Environmental Weights | 📝 Proposed | Low | Educated estimates; needs calibration through testing |
| Season Modifiers | 📝 Proposed | Low | Approximations; should be refined with agricultural data |
| Philippine Seasons | ✅ Documented | High | Well-established seasonal definitions |
| Transition Rules | 📝 Proposed | Medium | Framework defined; specifics need implementation and testing |

---

## Notes

- All numerical values (weights, modifiers, durations) are initial estimates and should be treated as tunable parameters.
- The CA model should be designed with configurable constants so that calibration is easy.
- Philippine-specific data should be prioritized over generic tropical agriculture data where available.
- Growth durations represent typical ranges — actual results vary by microclimate, variety, and care quality.
