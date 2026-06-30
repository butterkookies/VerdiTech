import 'package:flutter/material.dart';
import '../theme/verditech_theme.dart';
import '../../domain/models/enums.dart';

/// Gradient pill that communicates a growth stage via its identity color.
/// Used in cards, the timeline, the CA legend, and the Add Plant confirm step.
class StageChip extends StatelessWidget {
  final GrowthStage stage;

  /// When true, renders smaller (suitable for card overlays).
  final bool compact;

  const StageChip({super.key, required this.stage, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        gradient: VTGradients.forStage(stage),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(stage.icon, size: compact ? 12 : 14, color: Colors.black87),
          const SizedBox(width: 6),
          Text(
            stage.label,
            style: TextStyle(
              color: Colors.black87,
              fontSize: compact ? 11 : 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
