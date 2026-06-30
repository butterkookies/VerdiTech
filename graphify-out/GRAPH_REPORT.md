# Graph Report - .  (2026-06-30)

## Corpus Check
- 152 files · ~56,770 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 555 nodes · 568 edges · 74 communities (37 shown, 37 thin omitted)
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 28 edges (avg confidence: 0.84)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_CA Prediction Engine|CA Prediction Engine]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_UI Presentation Layer|UI Presentation Layer]]
- [[_COMMUNITY_Daily Log|Daily Log]]
- [[_COMMUNITY_Database Persistence|Database Persistence]]
- [[_COMMUNITY_Main Features|Main Features]]
- [[_COMMUNITY_Riverpod Providers|Riverpod Providers]]
- [[_COMMUNITY_CA Prediction Engine|CA Prediction Engine]]
- [[_COMMUNITY_Daily Log|Daily Log]]
- [[_COMMUNITY_UI Presentation Layer|UI Presentation Layer]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_UI Presentation Layer|UI Presentation Layer]]
- [[_COMMUNITY_Database Persistence|Database Persistence]]
- [[_COMMUNITY_UI Presentation Layer|UI Presentation Layer]]
- [[_COMMUNITY_Skill Chooser Tool|Skill Chooser Tool]]
- [[_COMMUNITY_CA Prediction Engine|CA Prediction Engine]]
- [[_COMMUNITY_Web Manifest|Web Manifest]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_CA Prediction Engine|CA Prediction Engine]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_CA Prediction Engine|CA Prediction Engine]]
- [[_COMMUNITY_Test Suite|Test Suite]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_Database Persistence|Database Persistence]]
- [[_COMMUNITY_Appicon Appiconset|Appicon Appiconset]]
- [[_COMMUNITY_Launchimage Imageset|Launchimage Imageset]]
- [[_COMMUNITY_Appicon Appiconset|Appicon Appiconset]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Domain Models|Domain Models]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Database Persistence|Database Persistence]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Mainactivity Verditech|Mainactivity Verditech]]
- [[_COMMUNITY_Database Persistence|Database Persistence]]
- [[_COMMUNITY_Project Specifications|Project Specifications]]
- [[_COMMUNITY_Project Specifications|Project Specifications]]
- [[_COMMUNITY_Project Specifications|Project Specifications]]
- [[_COMMUNITY_Project Specifications|Project Specifications]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Project Memories|Project Memories]]
- [[_COMMUNITY_Database Persistence|Database Persistence]]
- [[_COMMUNITY_UI Presentation Layer|UI Presentation Layer]]
- [[_COMMUNITY_Windows Runner Host|Windows Runner Host]]
- [[_COMMUNITY_Web Manifest|Web Manifest]]

## God Nodes (most connected - your core abstractions)
1. `Plant` - 11 edges
2. `CaEngine` - 10 edges
3. `AppDatabase` - 9 edges
4. `WindowClassRegistrar` - 9 edges
5. `Destroy()` - 9 edges
6. `fromRow` - 8 edges
7. `Recommendation` - 8 edges
8. `Create()` - 8 edges
9. `DashboardScreen` - 7 edges
10. `_router` - 7 edges

## Surprising Connections (you probably didn't know these)
- `Tests README / Testing Strategy` --semantically_similar_to--> `Interactive Skill Discovery CLI`  [INFERRED] [semantically similar]
  tests/README.md → tool/choose_skill.dart
- `System Architecture & App Flow Visualization` --references--> `AppDatabase`  [EXTRACTED]
  docs/architecture_flow.html → src/lib/data/database/app_database.dart
- `D009: Drift Local Database` --rationale_for--> `AppDatabase`  [EXTRACTED]
  memory/decisions.md → src/lib/data/database/app_database.dart
- `System Architecture & App Flow Visualization` --references--> `CaEngine`  [EXTRACTED]
  docs/architecture_flow.html → src/lib/domain/engine/ca_engine.dart
- `D004: Using 1D Cellular Automata` --rationale_for--> `CaEngine`  [EXTRACTED]
  memory/decisions.md → src/lib/domain/engine/ca_engine.dart

## Hyperedges (group relationships)
- **App Presentation Screens** — presentation_dashboard_screen_dashboardscreen, presentation_add_plant_screen_addplantscreen, presentation_plant_details_screen_plantdetailsscreen [EXTRACTED 1.00]
- **Core App Data Models** — specs_data_models_plant_model, specs_data_models_dailylog_model, specs_data_models_dayprediction_model, specs_data_models_environmentprofile_model, specs_data_models_recommendation_model [EXTRACTED 1.00]
- **CA Model Specification Concepts** — specs_ca_model_spec_1d_timeline_ca, specs_ca_model_spec_growth_stages, specs_ca_model_spec_health_overlays, specs_ca_model_spec_environmental_scoring_formula, specs_ca_model_spec_neighbor_influence [EXTRACTED 1.00]
- **Supported Philippine Crops** — memory_domain_knowledge_tomato, memory_domain_knowledge_eggplant, memory_domain_knowledge_siling_labuyo [EXTRACTED 1.00]
- **Core Growth Prediction Workflow** — memory_features_f001_user_input_system, memory_features_f002_growth_prediction_engine, memory_features_f003_plant_health_monitoring, memory_features_f004_recommendation_system, memory_features_f005_growth_timeline_visualization [EXTRACTED 1.00]
- **Core App Technology Stack** — memory_techstack_flutter, memory_techstack_riverpod, memory_techstack_gorouter, memory_techstack_drift [EXTRACTED 1.00]
- **Data Layer Persistence Stack** — database_app_database_appdatabase, tables_plant_table_planttable, tables_daily_log_table_dailylogtable, daos_plant_dao_plantdao, daos_daily_log_dao_dailylogdao, repositories_plant_repository_plantrepository [EXTRACTED 0.95]
- **CA Prediction Pipeline** — engine_ca_engine_computeenvscore, engine_ca_engine__transition, engine_ca_engine_forecast, engine_ca_engine_estimatedaystoharvest [EXTRACTED 0.95]
- **Shared Domain Enumerations** — models_enums_planttype, models_enums_growthstage, models_enums_season, models_enums_healthstatus, models_enums_recommendationpriority [EXTRACTED 0.95]
- **Riverpod Provider Layer** — providers_database_provider_databaseprovider, providers_database_provider_plantrepositoryprovider, providers_plant_providers_plantsstreamprovider, providers_prediction_providers_caengineprovider, providers_prediction_providers_forecastprovider, providers_prediction_providers_recommendationsprovider [EXTRACTED 0.95]
- **Add Plant Form Flow** — plant_form_add_plant_screen_addplantscreen, plant_form_add_plant_screen__addplantscreenstate, providers_plant_providers_plantformstate, providers_plant_providers_plantformnotifier, providers_plant_providers_plantformprovider [EXTRACTED 0.95]
- **Plant Detail Display Flow** — plant_detail_plant_details_screen_plantdetailsscreen, plant_detail_plant_details_screen__plantdetailscontent, providers_prediction_providers_envscoreprovider, providers_prediction_providers_forecastprovider, providers_prediction_providers_recommendationsprovider [INFERRED 0.85]
- **Windows Runner Startup Pipeline** — runner_main_winmain, runner_flutter_window_flutterwindow, runner_flutter_window_oncreate, flutter_generated_plugin_registrant_registerplugins, runner_win32_window_win32window [EXTRACTED 0.95]
- **Skill Discovery Tool Flow** — tool_choose_skill_loadskills, tool_choose_skill_parseskill, tool_choose_skill_searchandshow, tool_choose_skill_runinteractivemenu, tool_choose_skill_browseskills [EXTRACTED 0.95]

## Communities (74 total, 37 thin omitted)

### Community 0 - "CA Prediction Engine"
Cohesion: 0.06
Nodes (41): CaVisualizationScreen._buildGrid, Environmental Score Pipeline, PlantDao.getAllPlants, PlantDao.getPlantById, PlantDao.watchAllPlants, _PlantCard, CaEngine._transition, _Weights (Factor Weights Helper) (+33 more)

### Community 1 - "Windows Runner Host"
Cohesion: 0.08
Nodes (25): Win32 Flutter Hosting Pattern, RegisterPlugins(), FlutterWindow (Windows Runner), OnCreate(), OnDestroy(), Create(), Destroy(), EnableFullDpiSupportIfAvailable() (+17 more)

### Community 2 - "UI Presentation Layer"
Cohesion: 0.07
Nodes (34): System Architecture & App Flow Visualization, _router, D008: Riverpod State Management, D011: Unified Live Timeline, GoRouter Navigation, AboutScreen, build, _buildSectionTitle (+26 more)

### Community 3 - "Daily Log"
Cohesion: 0.06
Nodes (32): DailyLogDao.deleteLog, DailyLogDao.getLogsForPlant, DailyLogDao.insertLog, DailyLogDao.updateLog, DailyLogDao.upsertLog, DailyLogDao.watchLogsForPlant, PlantDao.deletePlant, PlantDao.insertPlant (+24 more)

### Community 4 - "Database Persistence"
Cohesion: 0.06
Nodes (29): Drift Local SQLite Persistence, daos/daily_log_dao.dart, daos/plant_dao.dart, into, PlantDao, update, _openConnection, AppDatabase (+21 more)

### Community 5 - "Main Features"
Cohesion: 0.08
Nodes (24): Feature-First Architecture Pattern, features/about/presentation/about_screen.dart, features/ca_visualization/presentation/ca_visualization_screen.dart, features/dashboard/presentation/dashboard_screen.dart, features/plant_detail/presentation/plant_details_screen.dart, features/plant_form/presentation/add_plant_screen.dart, AboutScreen, AddPlantScreen (+16 more)

### Community 6 - "Riverpod Providers"
Cohesion: 0.09
Nodes (22): database_provider.dart, _AddPlantScreenState, AddPlantScreen, copyWith, Plant, PlantFormNotifier, plantFormProvider, PlantFormState (+14 more)

### Community 7 - "CA Prediction Engine"
Cohesion: 0.09
Nodes (20): CaVisualizationScreen, 1D Cellular Automata Growth Model, CaEngine, estimateDaysToHarvest, _transition, _Weights, RecommendationEngine, D004: Using 1D Cellular Automata (+12 more)

### Community 8 - "Daily Log"
Cohesion: 0.10
Nodes (19): Riverpod State Management Pattern, DailyLogDao, into, update, DashboardScreen, ../../mappers/daily_log_mapper.dart, databaseProvider, plantRepositoryProvider (+11 more)

### Community 9 - "UI Presentation Layer"
Cohesion: 0.10
Nodes (20): build, _buildRecommendationCard, _buildTimelineItem, Card, _colorForHealth, Expanded, _iconForCategory, Padding (+12 more)

### Community 10 - "Windows Runner Host"
Cohesion: 0.11
Nodes (7): fl_register_plugins(), main(), my_application_activate(), my_application_new(), _MyApplication, dart_entrypoint_arguments, parent_instance

### Community 11 - "UI Presentation Layer"
Cohesion: 0.11
Nodes (17): dart:math, build, _CaVisualizationScreenState, Color, _colorForStage, Container, _reset, Row (+9 more)

### Community 12 - "Database Persistence"
Cohesion: 0.11
Nodes (17): _, copyWith, copyWithCompanion, DailyLogTableCompanion, DailyLogTableData, f, Function, map (+9 more)

### Community 13 - "UI Presentation Layer"
Cohesion: 0.12
Nodes (15): _AddPlantScreenState, build, _buildSectionHeader, _buildSlider, Column, dispose, Scaffold, SizedBox (+7 more)

### Community 14 - "Skill Chooser Tool"
Cohesion: 0.17
Nodes (15): Interactive Skill Discovery CLI, Tests README / Testing Strategy, browseSkills, dart:io, listAllSkills, loadSkills, main, parseSkill (+7 more)

### Community 15 - "CA Prediction Engine"
Cohesion: 0.24
Nodes (12): _PlantDetailsContent, PlantDetailsScreen, plantByIdProvider, caEngineProvider, daysToHarvestProvider, environmentProfileProvider, envScoreProvider, forecastProvider (+4 more)

### Community 16 - "Web Manifest"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 17 - "Windows Runner Host"
Cohesion: 0.20
Nodes (4): FlutterAppDelegate, FlutterImplicitEngineDelegate, AppDelegate, AppDelegate

### Community 18 - "CA Prediction Engine"
Cohesion: 0.22
Nodes (8): ../domain/engine/recommendation_engine.dart, ../domain/models/day_prediction.dart, ../domain/models/recommendation.dart, EnvironmentProfile, ../domain/engine/ca_engine.dart, ../domain/models/environment_profile.dart, ../domain/models/plant.dart, package:flutter_riverpod/flutter_riverpod.dart

### Community 19 - "Windows Runner Host"
Cohesion: 0.39
Nodes (5): wWinMain (Windows Runner Entry), wWinMain(), CreateAndAttachConsole(), GetCommandLineArguments(), Utf8FromUtf16()

### Community 20 - "Windows Runner Host"
Cohesion: 0.29
Nodes (3): RunnerTests, RunnerTests, XCTestCase

### Community 21 - "CA Prediction Engine"
Cohesion: 0.29
Nodes (6): package:verditech/domain/engine/ca_engine.dart, package:verditech/domain/models/enums.dart, package:verditech/domain/models/environment_profile.dart, package:verditech/domain/models/plant.dart, package:flutter_test/flutter_test.dart, main

### Community 22 - "Test Suite"
Cohesion: 0.29
Nodes (6): package:verditech/features/dashboard/presentation/dashboard_screen.dart, package:flutter/material.dart, package:flutter_riverpod/flutter_riverpod.dart, package:flutter_test/flutter_test.dart, package:go_router/go_router.dart, main

### Community 23 - "Windows Runner Host"
Cohesion: 0.33
Nodes (3): RegisterGeneratedPlugins(), NSWindow, MainFlutterWindow

### Community 24 - "Database Persistence"
Cohesion: 0.40
Nodes (4): ../data/database/app_database.dart, ../data/repositories/plant_repository.dart, PlantRepository, package:flutter_riverpod/flutter_riverpod.dart

### Community 25 - "Appicon Appiconset"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 26 - "Launchimage Imageset"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 27 - "Appicon Appiconset"
Cohesion: 0.40
Nodes (4): images, info, author, version

### Community 28 - "Windows Runner Host"
Cohesion: 0.50
Nodes (4): Multi-Platform Flutter Deployment, MyApplication (Linux GTK Runner), RegisterGeneratedPlugins (macOS), MainFlutterWindow (macOS)

### Community 29 - "Project Memories"
Cohesion: 0.67
Nodes (4): Cellular Automata, F002 Growth Prediction Engine, 1D Cellular Automata model, 2D Cellular Automata model

### Community 30 - "Project Memories"
Cohesion: 0.50
Nodes (4): Entry 1: Initial Spec Received, Entry 2: Technical Analysis Completed, Entry 3: Detailed Core Spec Confirmation, VerdiTech App Project Overview

### Community 31 - "Domain Models"
Cohesion: 0.50
Nodes (3): fromDate, fromIndex, fromScore

### Community 33 - "Project Memories"
Cohesion: 0.67
Nodes (3): Error E001: Undefined class 'PlantTableData', F008 Data Persistence, Drift ORM

## Knowledge Gaps
- **316 isolated node(s):** `MainActivity`, `images`, `version`, `author`, `images` (+311 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **37 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `System Architecture & App Flow Visualization` connect `UI Presentation Layer` to `Database Persistence`, `CA Prediction Engine`?**
  _High betweenness centrality (0.104) - this node is a cross-community bridge._
- **Why does `CaEngine` connect `CA Prediction Engine` to `UI Presentation Layer`, `Database Persistence`?**
  _High betweenness centrality (0.102) - this node is a cross-community bridge._
- **Why does `_router` connect `UI Presentation Layer` to `Main Features`?**
  _High betweenness centrality (0.087) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `CaEngine` (e.g. with `1D Cellular Automata Growth Model` and `RecommendationEngine`) actually correct?**
  _`CaEngine` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `MainActivity`, `images`, `version` to the rest of the system?**
  _337 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `CA Prediction Engine` be split into smaller, more focused modules?**
  _Cohesion score 0.06060606060606061 - nodes in this community are weakly interconnected._
- **Should `Windows Runner Host` be split into smaller, more focused modules?**
  _Cohesion score 0.07948717948717948 - nodes in this community are weakly interconnected._