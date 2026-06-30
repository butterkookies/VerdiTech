import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/models/enums.dart';
import '../theme/verditech_theme.dart';
import '../theme/vt_haptics.dart';

/// Full-screen celebratory overlay shown when a plant advances a growth stage.
/// Fires a particle burst + elastic icon reveal + live-region announcement.
/// Respects reduced-motion: skips confetti and fades in instantly instead.
///
/// Usage:
///   StageCelebration.show(context, stage: GrowthStage.fruiting, plantName: 'Sun Cherry');
class StageCelebration extends StatefulWidget {
  final GrowthStage stage;
  final String plantName;

  const StageCelebration({
    super.key,
    required this.stage,
    required this.plantName,
  });

  static Future<void> show(
    BuildContext context, {
    required GrowthStage stage,
    required String plantName,
  }) {
    VTHaptics.confirm();
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        pageBuilder: (_, __, ___) =>
            StageCelebration(stage: stage, plantName: plantName),
      ),
    );
  }

  @override
  State<StageCelebration> createState() => _StageCelebrationState();
}

class _StageCelebrationState extends State<StageCelebration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(seconds: 2));
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    final rnd = math.Random();
    _particles = List.generate(60, (_) => _Particle.random(rnd));
    final reduced = WidgetsBinding
        .instance.platformDispatcher.accessibilityFeatures.disableAnimations;
    if (reduced) {
      _c.value = 1.0;
    } else {
      _c.forward();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    final color = widget.stage.color;

    return Semantics(
      liveRegion: true,
      label: '${widget.plantName} reached ${widget.stage.label}. '
          'Tap anywhere to dismiss.',
      child: GestureDetector(
        onTap: () => Navigator.of(context).maybePop(),
        child: Stack(
          children: [
            // Confetti burst.
            AnimatedBuilder(
              animation: _c,
              builder: (_, __) => CustomPaint(
                size: Size.infinite,
                painter: _ConfettiPainter(
                  progress: _c.value,
                  particles: _particles,
                  color: color,
                ),
              ),
            ),
            // Center card with elastic scale-in.
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (_, v, child) =>
                    Transform.scale(scale: v.clamp(0.0, 1.0), child: child),
                child: Container(
                  margin: const EdgeInsets.all(40),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: s.surface,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: color, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: color.withOpacity(0.4), blurRadius: 40)
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: VTGradients.forStage(widget.stage),
                        ),
                        child: Icon(widget.stage.icon,
                            size: 48, color: Colors.black87),
                      ),
                      const SizedBox(height: VTSpace.lg),
                      Text(
                        'New stage reached!',
                        style: TextStyle(
                            color: s.textMuted, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.stage.label,
                        style: TextStyle(
                          color: s.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: VTSpace.sm),
                      Text(
                        widget.plantName,
                        style: TextStyle(
                            color: color, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Particle {
  final double angle, speed, size, spin;
  _Particle(this.angle, this.speed, this.size, this.spin);

  factory _Particle.random(math.Random r) => _Particle(
        r.nextDouble() * 2 * math.pi,
        0.4 + r.nextDouble() * 0.6,
        4 + r.nextDouble() * 6,
        r.nextDouble() * 4 - 2,
      );
}

class _ConfettiPainter extends CustomPainter {
  final double progress;
  final List<_Particle> particles;
  final Color color;

  _ConfettiPainter(
      {required this.progress,
      required this.particles,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.42);
    final maxDist = size.height * 0.6;
    final paint = Paint();

    for (final p in particles) {
      final dist =
          p.speed * maxDist * Curves.easeOut.transform(progress);
      final pos = center +
          Offset(
            math.cos(p.angle) * dist,
            math.sin(p.angle) * dist + progress * progress * 200,
          );
      paint.color = color.withOpacity((1 - progress).clamp(0, 1));
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(p.spin * progress * math.pi);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: Offset.zero, width: p.size, height: p.size * 0.6),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
