# VerdiTech — Technology Stack
> Project: VerdiTech | Last Updated: June 27, 2026

Complete technology stack documentation for the VerdiTech plant growth prediction app. Items marked TBD will be finalized during Phase 1 (Design) or early Phase 2 (Core Development).

---

## Core Stack

| Category | Technology | Version | Status | Notes |
|----------|-----------|---------|--------|-------|
| **Framework** | Flutter | Latest stable (TBD) | ✅ Confirmed | Client-specified requirement |
| **Language** | Dart | Bundled with Flutter | ✅ Confirmed | — |
| **Target Platform** | Android | API 21+ (TBD) | ✅ Confirmed | Minimum SDK level to be determined |
| **Target Platform** | iOS | — | ⏳ TBD | Not confirmed; Flutter supports it natively if needed |

## Architecture & State Management

| Category | Technology | Status | Candidates | Notes |
|----------|-----------|--------|------------|-------|
| **Architecture Pattern** | Feature-First (Domain-Driven) | ✅ Confirmed | Clean Architecture, MVVM, MVC | Easier to explain for thesis defense; cohesive folder structure |
| **State Management** | Riverpod (v3.x) | ✅ Confirmed | Provider, Riverpod, BLoC, GetX | Modern standard, safe, less boilerplate than BLoC |
| **Navigation** | GoRouter | ✅ Confirmed | GoRouter, Navigator 2.0, auto_route | Declarative routing, deep-linking support |

## Data & Storage

| Category | Technology | Status | Candidates | Notes |
|----------|-----------|--------|------------|-------|
| **Local Database** | Drift (formerly Moor) | ✅ Confirmed | sqflite, Hive, drift, shared_preferences | Robust ORM for SQLite, perfect for relational offline-first data |
| **Data Models** | TBD | ⏳ Pending | freezed + json_serializable, manual | freezed recommended for immutable models with JSON support |
| **Cloud/Backend** | None planned | ✅ Confirmed | — | Offline-first app, no server required for v1 |

## UI & Design

| Category | Technology | Status | Notes |
|----------|-----------|--------|-------|
| **Design System** | Material Design 3 | ✅ Confirmed | Custom theme with vibrant green accents and soft shadows |
| **Icons** | Material Icons | ✅ Confirmed | Default flutter icon pack |
| **Fonts** | Google Fonts | ✅ Confirmed | Custom clean typography package (Google Fonts: Outfit/Inter) |
| **Charts/Graphs** | Custom Painter / Canvas | ⏳ Pending | Custom timeline visualization |
| **Animations** | Flutter Animation Controller | ⏳ Pending | Micro-animations for page transitions and grid steps |

## Development Tools

| Category | Technology | Status | Notes |
|----------|-----------|--------|-------|
| **IDE** | VS Code / Android Studio | ✅ Confirmed | Main developer environments |
| **Version Control** | Git | ✅ Confirmed | Git repository initialized locally |
| **CI/CD** | TBD | ⏳ TBD | Not needed for thesis project |
| **Testing** | Flutter test framework | ⏳ Planned | Unit tests for CA engine, widget tests for UI |
| **Code Generation** | build_runner | ✅ Confirmed | Required for Drift and Riverpod generator |
| **Linting** | flutter_lints | ✅ Confirmed | Configured `flutter_lints` package v3.0.0 |

---

## Candidate Package List

These packages are being considered for the project. Final selection happens during Phase 2.

### Likely to Use
| Package | Purpose | pub.dev |
|---------|---------|---------|
| `provider` or `riverpod` | State management | — |
| `hive` + `hive_flutter` | Local NoSQL storage | — |
| `fl_chart` | Growth timeline charts | — |
| `google_fonts` | Typography | — |
| `intl` | Date formatting, localization | — |
| `flutter_local_notifications` | Push notifications (if F009 confirmed) | — |

### Under Consideration
| Package | Purpose | pub.dev |
|---------|---------|---------|
| `freezed` + `json_serializable` | Immutable data classes | — |
| `go_router` | Declarative navigation | — |
| `lottie` | Animated illustrations | — |
| `flutter_animate` | UI animations | — |
| `sqflite` | SQL local database (alternative to Hive) | — |

---

## Environment Setup Checklist

- [x] Install Flutter SDK (latest stable)
- [x] Install Dart SDK (bundled)
- [x] Install Android Studio + Android SDK
- [x] Configure Android emulator or physical device
- [x] Set up VS Code with Flutter/Dart extensions
- [x] Initialize Git repository
- [x] Create Flutter project with `flutter create`
- [x] Configure `pubspec.yaml` with initial dependencies
- [x] Set up project folder structure (Feature-First)
- [ ] Run `flutter doctor` — all green checks

---

## Notes

- Technology choices should prioritize **simplicity** given the client's SHS-level context. The app should be maintainable.
- Avoid over-engineering — this is a thesis project, not a production SaaS app.
- All packages should be well-maintained and have high pub.dev scores.
- Final stack decisions will be logged in `decisions.md` when confirmed.
