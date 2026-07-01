# Design System Strategy: Pinterest Botanical UI

## 1. Overview & Creative North Star: "Botanical Pop"
Our Creative North Star is **"Botanical Pop."** The interface emphasizes a striking contrast between clean, off-white negative space and vibrant, solid emerald green cards. The hallmark of this aesthetic is the **3D Pop-Out Effect**, where isolated plant images break the boundaries of their heavily rounded containers.

---

## 2. Colors & Surface Architecture
The palette is highly contrasted, moving away from soft pastels to a bold, saturated green against a stark canvas.

### The Palette
*   **Primary (The Emerald):** `#2A9D5C` (vibrant emerald green, used as `primary_container`). This is the dominant color for plant cards and primary action buttons.
*   **Neutral (The Canvas):** Off-white `surface` (`#F2F1E8` or `#F7F6F0`) to create an earthy but very clean backdrop.
*   **Text:** `on_surface` is pure black (`#000000`) for high contrast on the canvas, while text inside the green cards is pure white (`#FFFFFF`).

### Surface Hierarchy
*   **Level 0 (Base):** `surface` (#F2F1E8) for the main viewport.
*   **Level 1 (Cards):** The primary cards use the solid emerald `#2A9D5C`. They are flat, without heavy shadows, relying on the vibrant color and unique image placement for depth.

---

## 3. Typography: Bold & Geometric
*   **Primary Font (Outfit or Poppins):** Used for a bold, geometric, and very round look.
*   **Scale Intent:** 
    *   **Headlines:** Very large, bold, and geometric (e.g., "My plants").
    *   **Body:** Clean and highly legible. Text inside cards (like plant names) is bold and white.

---

## 4. Elevation & Depth: The Pop-Out Image
*   **Corner Radius:** Cards and buttons use an extreme border-radius, typically a **Pill shape** or a highly rounded rectangle (`24px` to `32px` radius).
*   **The 3D Breakout (Crucial):** Plant images MUST have a transparent background and be positioned so they overlap the top edge of the green container card. This creates a dimensional, "pop-out" aesthetic.

---

## 5. Components & Primitive Styling

### Plant Cards (My Plants)
*   **Layout:** A solid emerald green rounded rectangle.
*   **Images:** A large, transparent-background plant image that is aligned to the top, breaking out of the card's top boundary.
*   **Typography:** Plant name (e.g., "Tomato") in bold white text at the bottom of the card, with a smaller subtitle (e.g., "SEEDLING") below it.
*   **Status Badges:** Small, circular white icons (e.g., a checkmark or warning sign) positioned in the top-left corner of the card, floating above the green background.

### Secondary Circular Cards (Explore)
*   **Layout:** Instead of a rectangle, use a perfect circle in the emerald green color behind the plant. The plant image again breaks out of the top of the circle. Text sits below the circle in black.

### Bottom Action Bar
*   **Layout:** A white, highly rounded floating card containing text like "Adjust the watering of plants", paired with a solid green, pill-shaped button on the right containing an icon.
