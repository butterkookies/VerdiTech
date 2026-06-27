# 🧪 Tests

Unit tests, widget tests, and integration tests will go here.

---

## Planned Structure

The test structure will mirror the `src/` directory:

```
tests/
├── unit/                 # Unit tests for business logic
│   ├── models/           #   Model tests
│   ├── services/         #   Service tests
│   └── utils/            #   Utility function tests
├── widget/               # Widget tests for UI components
│   ├── screens/          #   Screen-level widget tests
│   └── widgets/          #   Individual widget tests
└── integration/          # Integration / end-to-end tests
    └── flows/            #   User flow tests
```

---

## Testing Strategy

| Test Type       | Purpose                                    | Tool             |
|-----------------|--------------------------------------------|------------------|
| **Unit**        | Verify individual functions & classes       | `flutter_test`   |
| **Widget**      | Verify UI components render correctly       | `flutter_test`   |
| **Integration** | Verify complete user flows & interactions   | `integration_test` |

---

## Notes

- Tests will be created alongside features during Phase 3 (Core Development)
- Aim for meaningful test coverage on core logic (Cellular Automata engine, prediction models)
- Widget tests should cover all primary screens

---

*This folder is currently empty. Tests will be added during Phase 3.*
