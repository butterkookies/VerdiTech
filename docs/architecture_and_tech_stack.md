# VerdiTech — Architecture & Tech Stack Guide
> Project: VerdiTech | Last Updated: June 27, 2026

This guide explains the architectural patterns, state management, and database choices selected for the VerdiTech mobile application. It is written in plain terms to serve as both a developer reference and a resource for the capstone/thesis documentation.

---

## 1. Architectural Pattern: Feature-First (Domain-Driven)

VerdiTech uses a **Feature-First** directory structure. This means the codebase is organized around concrete features (such as `plants` and `predictions`) rather than generic technical layers (like `screens`, `models`, and `controllers`).

### Why Feature-First?
- **Readability**: Anyone looking at the project can immediately see what the app *does* (its features) rather than just how it is built.
- **Maintainability**: If you need to modify the Cellular Automata logic, all related code (the formula, the state management, and the result screen) is grouped together.
- **Thesis Defense Friendly**: Makes it simple to explain the boundaries of the code to a panel.

### The Three Layers of a Feature
Inside each feature folder, code is separated into three distinct layers to enforce separation of concerns:

```
lib/features/predictions/
├── domain/       # 1. Pure Rules & Models (e.g. CA algorithm, Stage durations)
├── data/         # 2. Database interaction (e.g. Saving prediction history)
└── presentation/ # 3. Flutter UI (e.g. Input Form, Timeline widgets)
```

1. **Domain (Business Logic)**: The heart of the feature. Contains the pure mathematical rules of the Cellular Automata engine and the data shapes (Entities). It does not know about databases or Flutter UI widgets.
2. **Data (Infrastructure)**: Handles communications with local databases (SQLite/Drift).
3. **Presentation (User Interface)**: Holds the Flutter widgets, buttons, input fields, and layouts that the user interacts with.

---

## 2. Tech Stack Choices & Explanation

The libraries and packages used are defined in the project's [pubspec.yaml](file:///c:/Andrei.dev/Projects/VerdiTech/src/pubspec.yaml).

### Local Relational Database: Drift & SQLite
- **SQLite**: The industry standard for local data storage on mobile devices. It saves data as tables (rows and columns) inside a secure file on the device.
- **Drift**: A Dart-friendly ORM (Object-Relational Mapper) wrapper around SQLite.
  - *Why it's used*: Instead of writing raw SQL database queries (which are easy to mistype and break), Drift allows developers to write query logic using pure Dart. It translates Dart queries to SQLite commands automatically and provides compile-time safety (meaning errors are caught before the app runs).
  - *Relation to VerdiTech*: Critical for storing multiple plant profiles, tracking individual plant parameters, and maintaining a log of growth predictions.

### File Storage Access: Path & Path Provider
- **Path Provider**: A Flutter package that safely requests folder paths from Android/iOS.
  - *Why it's used*: Modern mobile operating systems restrict where apps can write files. Path Provider asks Android for the specific app-directory where it is legally allowed to store the database file.
- **Path**: A small helper library.
  - *Why it's used*: Ensures file addresses are constructed correctly regardless of the platform (since Windows addresses use `\` and Android uses `/`).

### State Management: Riverpod (with Riverpod Generator)
- **What is State Management?**: State is any data that changes dynamically in the app (e.g., changing sunlight from Low to High, adding a plant, or displaying prediction results). A state manager coordinates updating the UI when these values change.
- **Riverpod**: The modern brain of the application.
  - *Why it's used*: It is compile-safe, testable, and highly reactive. When a user updates sunlight, Riverpod detects the change, triggers the Cellular Automata engine, and instantly updates the Timeline screen without reloading the entire app.
- **Riverpod Generator**: An automation package.
  - *Why it's used*: It automatically writes the boilerplate code for Riverpod providers, letting developers focus on writing the actual logic.

---

## 3. Automation: Build Runner

Several of our chosen tools (Drift and Riverpod Generator) require code generation.

- **What is Build Runner?**: A standard tool provided by the Dart team that scans the source code, reads developer annotations (like `@drift` or `@riverpod`), and automatically writes the secondary, complex setup code.
- **Why we use it**: It automates the creation of database tables and state wiring, keeping the manually written codebase clean and easy to understand.
