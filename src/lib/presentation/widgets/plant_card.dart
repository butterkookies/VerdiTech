import 'package:flutter/material.dart';
import '../theme/verditech_theme.dart';
import 'stage_chip.dart';
import '../../domain/models/enums.dart';

/// Tappable plant card for the dashboard grid.
/// Emits a stage-tinted glow shadow and includes a progress bar toward
/// the next predicted growth stage.
class PlantCard extends StatelessWidget {
  final String name;
  final String species;
  final GrowthStage stage;

  /// Progress toward the next stage, 0.0–1.0.
  final double progressToNext;

  final int dayInCycle;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.name,
    required this.species,
    required this.stage,
    required this.progressToNext,
    required this.dayInCycle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Semantics(
      button: true,
      label: '$name, $species. Stage: ${stage.label}. '
          'Day $dayInCycle. '
          '${(progressToNext * 100).round()} percent to next stage.',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(VTSpace.radius),
            color: s.surface,
            border: Border.all(color: s.glassStroke),
            boxShadow: [
              BoxShadow(
                color: stage.color.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(VTSpace.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: VTGradients.forStage(stage),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(stage.icon, color: Colors.black87, size: 22),
                  ),
                  Text(
                    'Day $dayInCycle',
                    style: TextStyle(color: s.textMuted, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: s.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                species,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: s.textMuted, fontSize: 12),
              ),
              const SizedBox(height: VTSpace.sm),
              StageChip(stage: stage, compact: true),
              const SizedBox(height: VTSpace.sm),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: progressToNext),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  builder: (_, v, __) => LinearProgressIndicator(
                    value: v,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.06),
                    valueColor: AlwaysStoppedAnimation(stage.color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
