import 'package:flutter/material.dart';

import '../../domain/models/enums.dart';

extension GrowthStageX on GrowthStage {
  String get label => switch (this) {
        GrowthStage.seedling => 'Seedling',
        GrowthStage.youngPlant => 'Young Plant',
        GrowthStage.flowering => 'Flowering',
        GrowthStage.fruiting => 'Fruiting',
        GrowthStage.harvestReady => 'Harvest Ready',
      };

  IconData get icon => switch (this) {
        GrowthStage.seedling => Icons.spa_outlined,
        GrowthStage.youngPlant => Icons.eco_outlined,
        GrowthStage.flowering => Icons.local_florist_outlined,
        GrowthStage.fruiting => Icons.restaurant_outlined,
        GrowthStage.harvestReady => Icons.agriculture_outlined,
      };

  Color get color => switch (this) {
        GrowthStage.seedling => VTColors.seedling,
        GrowthStage.youngPlant => VTColors.young,
        GrowthStage.flowering => VTColors.flowering,
        GrowthStage.fruiting => VTColors.fruiting,
        GrowthStage.harvestReady => VTColors.harvest,
      };
}

// ---------------------------------------------------------------------------
// Static brand constants — mode-invariant.
// Stage colors are intentionally the same in both themes so the chromatic
// identity language never shifts under the user.
// ---------------------------------------------------------------------------

class VTColors {
  VTColors._();

  // Per-stage identity (constant across light + dark).
  static const Color seedling = Color(0xFF38BDF8);
  static const Color young = Color(0xFF4ADE80);
  static const Color flowering = Color(0xFFF472B6);
  static const Color fruiting = Color(0xFFFB923C);
  static const Color harvest = Color(0xFFFBBF24);

  // Brand greens (also exposed on VTScheme for convenience).
  static const Color verdant = Color(0xFF4ADE80);
  static const Color verdantDeep = Color(0xFF16A34A);
  static const Color moss = Color(0xFF86EFAC);
}

// ---------------------------------------------------------------------------
// Adaptive color scheme — read via VTTheme.of(context).
// ---------------------------------------------------------------------------

@immutable
class VTScheme {
  final Color bg;
  final Color surface;
  final Color surfaceHigh;
  final Color textPrimary;
  final Color textMuted;
  final Color glassFill;
  final Color glassStroke;
  final Brightness brightness;
  final Color verdant;
  final Color verdantDeep;
  final Color moss;

  const VTScheme({
    required this.bg,
    required this.surface,
    required this.surfaceHigh,
    required this.textPrimary,
    required this.textMuted,
    required this.glassFill,
    required this.glassStroke,
    required this.brightness,
    this.verdant = const Color(0xFF4ADE80),
    this.verdantDeep = const Color(0xFF16A34A),
    this.moss = const Color(0xFF86EFAC),
  });

  static const VTScheme dark = VTScheme(
    bg: Color(0xFF0E1512),
    surface: Color(0xFF18221D),
    surfaceHigh: Color(0xFF22302A),
    textPrimary: Color(0xFFF1F5F2),
    textMuted: Color(0xFF8FA399),
    glassFill: Color(0x0AFFFFFF),
    glassStroke: Color(0x14FFFFFF),
    brightness: Brightness.dark,
  );

  static const VTScheme light = VTScheme(
    bg: Color(0xFFF3F7F4),
    surface: Color(0xFFFFFFFF),
    surfaceHigh: Color(0xFFEAF1EC),
    textPrimary: Color(0xFF15241C),
    textMuted: Color(0xFF5E726A),
    glassFill: Color(0x99FFFFFF),
    glassStroke: Color(0x14123320),
    brightness: Brightness.light,
    verdantDeep: Color(0xFF15803D),
  );
}

// ---------------------------------------------------------------------------
// InheritedWidget that propagates VTScheme + a toggle callback.
// ---------------------------------------------------------------------------

class VTTheme extends InheritedWidget {
  final VTScheme scheme;
  final VoidCallback? toggle;

  const VTTheme({
    super.key,
    required this.scheme,
    this.toggle,
    required super.child,
  });

  static VTScheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VTTheme>()!.scheme;

  static VoidCallback? toggleOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VTTheme>()?.toggle;

  @override
  bool updateShouldNotify(VTTheme old) => old.scheme != scheme;
}

// ---------------------------------------------------------------------------
// Gradients
// ---------------------------------------------------------------------------

class VTGradients {
  VTGradients._();

  static const LinearGradient hero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B3A2B), Color(0xFF0E1512)],
  );

  static const LinearGradient heroLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD6EFDD), Color(0xFFF3F7F4)],
  );

  static LinearGradient heroFor(Brightness b) =>
      b == Brightness.dark ? hero : heroLight;

  static const LinearGradient verdant = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4ADE80), Color(0xFF16A34A)],
  );

  static LinearGradient forStage(GrowthStage s) => switch (s) {
        GrowthStage.seedling => const LinearGradient(
            colors: [Color(0xFF7DD3FC), Color(0xFF38BDF8)]),
        GrowthStage.youngPlant => const LinearGradient(
            colors: [Color(0xFF86EFAC), Color(0xFF4ADE80)]),
        GrowthStage.flowering => const LinearGradient(
            colors: [Color(0xFFF9A8D4), Color(0xFFF472B6)]),
        GrowthStage.fruiting => const LinearGradient(
            colors: [Color(0xFFFDBA74), Color(0xFFFB923C)]),
        GrowthStage.harvestReady => const LinearGradient(
            colors: [Color(0xFFFDE68A), Color(0xFFFBBF24)]),
      };
}

// ---------------------------------------------------------------------------
// Spacing constants
// ---------------------------------------------------------------------------

class VTSpace {
  VTSpace._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double radius = 24;
}
