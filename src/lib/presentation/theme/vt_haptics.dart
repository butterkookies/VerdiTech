import 'package:flutter/services.dart';

/// Semantic haptic vocabulary for VerdiTech.
/// Call these, not the raw HapticFeedback API, so the feel stays consistent
/// and the entire vocabulary is tunable from one place.
class VTHaptics {
  VTHaptics._();

  /// Selecting a tab, chip, or species card.
  static void select() => HapticFeedback.selectionClick();

  /// Light acknowledgement: card tap, slider settle.
  static void tap() => HapticFeedback.lightImpact();

  /// Primary confirmations: add plant, save edit, refresh complete.
  static void confirm() => HapticFeedback.mediumImpact();

  /// Destructive / warning: delete confirm, error state.
  static void warn() => HapticFeedback.heavyImpact();
}
