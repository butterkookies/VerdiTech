import 'package:flutter/material.dart';
import '../theme/verditech_theme.dart';

/// Overarching garden health summary shown at the top of the Dashboard.
/// The animated ring sweeps from 0 → healthScore on first render.
class HealthSummaryHeader extends StatelessWidget {
  final int plantCount;
  final int needAttention;

  /// Overall garden health score, 0.0–1.0.
  final double healthScore;

  const HealthSummaryHeader({
    super.key,
    required this.plantCount,
    required this.needAttention,
    required this.healthScore,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      decoration: BoxDecoration(gradient: VTGradients.heroFor(s.brightness)),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            _AnimatedHealthRing(value: healthScore),
            const SizedBox(width: VTSpace.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning 🌱',
                    style: TextStyle(color: s.textMuted, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your garden is thriving',
                    style: TextStyle(
                      color: s.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: VTSpace.md),
                  Row(
                    children: [
                      _MiniStat(
                        value: '$plantCount',
                        label: 'Tracked',
                        accent: s.verdant,
                      ),
                      const SizedBox(width: VTSpace.lg),
                      _MiniStat(
                        value: '$needAttention',
                        label: 'Need care',
                        accent: needAttention > 0
                            ? VTColors.fruiting
                            : s.verdant,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;
  final Color accent;

  const _MiniStat({
    required this.value,
    required this.label,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
              color: accent, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Text(label,
            style: TextStyle(color: s.textMuted, fontSize: 12)),
      ],
    );
  }
}

class _AnimatedHealthRing extends StatelessWidget {
  final double value;
  const _AnimatedHealthRing({required this.value});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutCubic,
      builder: (_, v, __) => SizedBox(
        width: 92,
        height: 92,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(92, 92),
              painter: _RingPainter(v, s.textMuted.withOpacity(0.18)),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(v * 100).round()}',
                  style: TextStyle(
                    color: s.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'health',
                  style: TextStyle(color: s.textMuted, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double value;
  final Color track;
  _RingPainter(this.value, this.track);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 6;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..color = track,
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -1.5708, // start at 12 o'clock
      6.283 * value,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round
        ..shader = const SweepGradient(
          colors: [VTColors.verdantDeep, VTColors.moss, VTColors.verdant],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value || old.track != track;
}
