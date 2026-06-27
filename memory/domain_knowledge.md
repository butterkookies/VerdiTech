# VerdiTech Domain Knowledge Guide

Welcome to the crash course on plant biology and computational modeling! Since you are building an app that predicts plant growth, it's crucial to understand the logic behind the scenes so you can build the code with confidence. 

Here is everything you need to know, broken down into simple concepts.

---

## 1. What is Cellular Automata (CA)?

The client specifically requested using **Cellular Automata** to predict growth. This sounds intimidating, but it's actually a very elegant way to simulate complex systems using simple rules.

### The Basics
In a traditional 2D Cellular Automata (like Conway's "Game of Life"), you have a grid of cells (like a chessboard). 
*   **Cells:** Each square on the board.
*   **State:** A cell can be "Alive" or "Dead".
*   **Time Steps:** The simulation moves forward one "tick" or "day" at a time.
*   **Rules:** What happens to a cell in the next tick depends on its neighbors. (e.g., If a dead cell is surrounded by 3 living cells, it comes to life).

### How We Apply CA to Plant Growth (1D CA)
For VerdiTech, we are using a **1D Time-Series Cellular Automata**. 
Instead of a 2D grid spreading out in space, think of a 1D line representing **Time (Days)**.

*   **The Cell:** The plant on a specific day (Day 1, Day 2, Day 3...).
*   **The State:** The growth stage the plant is currently in (e.g., Seedling, Flowering).
*   **The Rules:** Instead of looking at neighboring cells, the plant looks at its **Environment** (Sun, Water, Soil). 
    *   *Rule Example:* IF current state is `Seedling` AND `Water` is high AND `Sunlight` is high, THEN next state progresses towards `Young Plant`.
    *   *Rule Example:* IF `Water` is critically low, THEN next state is `Stressed` (growth pauses).

By running this rule loop day by day, the CA algorithm "predicts" exactly when the plant will reach the next stage.

---

## 2. The Plant Growth Stages (Phenology)

"Phenology" is just the scientific term for the stages of a plant's life cycle. For this app, we are tracking four main stages:

1.  **Seedling:** The baby plant has just sprouted from the seed. It's very fragile and needs consistent moisture.
2.  **Young Plant (Vegetative Stage):** The plant focuses on growing big leaves and strong stems. It's building the "solar panels" (leaves) it needs to produce energy.
3.  **Flowering:** The plant produces flowers. This is a critical stage—if conditions are bad (e.g., too hot, not enough water), the flowers will drop off, and there will be no fruit.
4.  **Fruiting:** The flowers are pollinated and turn into the vegetables we harvest. The plant needs a lot of energy and water here to plump up the fruit.

---

## 3. The 3 Vegetables

The app focuses on three specific plants. Each has unique needs, which our CA Engine will account for using "Weights" (e.g., one plant might care more about water, while another cares more about sun).

*   🍅 **Tomato (Kamatis):** Very sensitive to water consistency. If watered irregularly while fruiting, the tomatoes can split or rot at the bottom. Loves sunlight.
*   🍆 **Eggplant (Talong):** A heat-loving plant with a longer "Young Plant" vegetative phase before it starts fruiting. Very sturdy but needs rich soil.
*   🌶️ **Siling Labuyo (Native Chili):** A native Philippine plant. It is very hardy, drought-tolerant, and tough. Once established, it doesn't need as much water as the other two, but it absolutely demands full sunlight to produce spicy peppers.

---

## 4. The 3 Environmental Factors (Inputs)

The user will rate these three things from 1 (Very Low) to 5 (Excellent). These are the "rules" that feed our CA Engine.

1.  **Sunlight:** Plants use photosynthesis to eat. Low sunlight = slow growth. 
2.  **Water:** Necessary to move nutrients from the soil up into the leaves and fruit. Too little water = plant dries up. Too much water = roots drown and rot.
3.  **Soil Quality:** The "vitamins" the plant gets. Good soil has Nitrogen (for leaves), Phosphorus (for flowers/roots), and Potassium (for overall health).

---

## 5. The Philippine Seasons (Context)

Agriculture in the Philippines doesn't have Spring/Summer/Fall/Winter. We have three distinct agricultural seasons, which act as **Modifiers** in our CA algorithm:

1.  **Tag-init (Dry/Hot Season - March to May):** Great sunlight, but extremely high evaporation. Plants dry out fast. Tomatoes struggle here because it gets *too* hot.
2.  **Tag-ulan (Wet/Rainy Season - June to November):** Abundant water, but less sunlight due to clouds. The biggest danger here is "wet feet" (root rot) from flooding and fungal diseases.
3.  **Malamig (Cool/Dry Season - December to February):** The "Goldilocks" season. Moderate temperatures and moderate rain. This is the absolute best time to grow Tomatoes and Eggplants.

---

## 6. How the App Logic Ties it All Together

When you put on your programmer hat, here is how the app flows:

1.  **Input:** User says "I have a *Tomato*, it's a *Seedling*, we are in *Tag-init*, Sun is 4, Water is 2, Soil is 3."
2.  **CA Engine (The Math):** 
    *   The engine calculates an **Environmental Score**. It knows Tomatoes need a lot of water, so a Water score of 2 hurts it heavily.
    *   It applies a **Season Modifier**. It knows Tag-init is too hot for baby tomatoes, penalizing the score further.
    *   It runs a loop, day by day, applying these penalties to the plant's growth speed.
3.  **Output (UI):** 
    *   **Timeline:** Tells the user it will take *longer* than normal to reach the Flowering stage.
    *   **Health Status:** Flags the plant as "Stressed".
    *   **Recommendations:** The engine sees the low Water score and the Tag-init season, so it outputs the tip: *"Increase watering frequency. The Tag-init heat evaporates water quickly, and tomatoes need consistent moisture."*

> [!TIP]
> You don't need a PhD in botany to build this! You just need to translate these concepts into data models (classes) and transition rules (if/else statements and simple math formulas) in Dart.
