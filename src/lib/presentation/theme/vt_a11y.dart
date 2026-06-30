import 'package:flutter/material.dart';

/// Accessibility helpers — single source of truth for reduced-motion gating
/// and minimum touch-target enforcement.
class VTA11y {
  VTA11y._();

  /// True when the OS requests reduced motion
  /// (Settings → Accessibility → Remove animations).
  static bool reduceMotion(BuildContext context) =>
      MediaQuery.maybeOf(context)?.disableAnimations ?? false;

  /// Returns [full] duration normally; Duration.zero under reduced motion.
  /// Use this everywhere an animation duration is supplied so the entire
  /// app respects the OS preference from one call site.
  static Duration motion(BuildContext context, Duration full) =>
      reduceMotion(context) ? Duration.zero : full;

  /// Minimum touch-target dimension per Material / WCAG 2.5.5.
  static const double minTarget = 48.0;
}
