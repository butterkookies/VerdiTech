# VerdiTech Agent Rules

## Automatic Skill Selection & Utilization

To ensure that all code modifications, styling choices, test suites, and project structures follow recommended Flutter and Dart best practices, the agent must act as an **Automatic Skill Chooser**:

1. **Scan Task Intent**: When a new task is received, analyze it against the list of available Flutter agent skills located in `.agents/skills/`.
2. **Mandatory Load**: Before executing any code changes or command lines associated with a skill's domain, you **MUST** run the `view_file` tool on the relevant skill's `SKILL.md` file to load its instructions.
3. **Follow Blueprints**: Follow the exact workflow steps, patterns, code structures, and commands listed in the matched skill.
4. **Coordinate Multiple Skills**: If a task requires changes across multiple domains (e.g. adding widget previews and writing widget tests), load and apply all relevant skill instructions in sequence.

## Available Skills Reference

| Skill Directory | Core Trigger Conditions |
|---|---|
| `flutter-add-integration-test` | Adding, configuring, or writing end-to-end integration tests. |
| `flutter-add-widget-preview` | Creating or modifying interactive widget previews (`previews.dart`). |
| `flutter-add-widget-test` | Adding or updating unit/widget component tests using `WidgetTester`. |
| `flutter-apply-architecture-best-practices` | Refactoring folders, creating data layers, repository structures, or state management files. |
| `flutter-build-responsive-layout` | Designing layouts using `LayoutBuilder`, `MediaQuery`, or flexible sizing widgets. |
| `flutter-fix-layout-issues` | Debugging viewport height issues, RenderFlex overflows, or alignment/spacing issues. |
| `flutter-implement-json-serialization` | Writing `fromJson` or `toJson` methods for data models. |
| `flutter-setup-declarative-routing` | Setting up routing paths, deep links, or configuring GoRouter. |
| `flutter-setup-localization` | Adding localization config, `l10n.yaml`, or updating translated resource keys. |
| `flutter-use-http-package` | Making REST API calls, fetching data, or integrating network payloads. |
