import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/verditech_theme.dart';

// ---------------------------------------------------------------------------
// Custom-painted vector illustrations — no raster assets required.
// All shapes tint from the active VTScheme so they adapt to light/dark.
// ---------------------------------------------------------------------------

/// Sprouting seedling in a pot — empty garden state.
class EmptyGardenArt extends StatelessWidget {
  final double size;
  const EmptyGardenArt({super.key, this.size = 160});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return CustomPaint(
      size: Size.square(size),
      painter: _SeedlingPainter(
        pot: s.surfaceHigh,
        soil: s.brightness == Brightness.dark
            ? const Color(0xFF3A2E25)
            : const Color(0xFF6B4E3A),
        leaf: s.verdant,
        leafDeep: s.verdantDeep,
      ),
    );
  }
}

class _SeedlingPainter extends CustomPainter {
  final Color pot, soil, leaf, leafDeep;
  _SeedlingPainter(
      {required this.pot,
      required this.soil,
      required this.leaf,
      required this.leafDeep});

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final p = Paint()..style = PaintingStyle.fill;

    // Pot (trapezoid).
    p.color = pot;
    final potPath = Path()
      ..moveTo(w * 0.30, h * 0.62)
      ..lineTo(w * 0.70, h * 0.62)
      ..lineTo(w * 0.64, h * 0.92)
      ..lineTo(w * 0.36, h * 0.92)
      ..close();
    canvas.drawPath(potPath, p);

    // Soil mound.
    p.color = soil;
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.63),
          width: w * 0.40,
          height: h * 0.10),
      p,
    );

    // Stem.
    p.color = leafDeep;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(w * 0.5, h * 0.50),
            width: w * 0.025,
            height: h * 0.28),
        const Radius.circular(4),
      ),
      p,
    );

    // Two leaves (mirrored bezier shapes).
    p.color = leaf;
    _drawLeaf(canvas, p, Offset(w * 0.5, h * 0.44), w * 0.16, -0.6);
    _drawLeaf(canvas, p, Offset(w * 0.5, h * 0.40), w * 0.16, 0.6);
  }

  void _drawLeaf(
      Canvas c, Paint p, Offset base, double len, double angle) {
    c.save();
    c.translate(base.dx, base.dy);
    c.rotate(angle);
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(len * 0.5, -len * 0.5, len, 0)
      ..quadraticBezierTo(len * 0.5, len * 0.3, 0, 0)
      ..close();
    c.drawPath(path, p);
    c.restore();
  }

  @override
  bool shouldRepaint(_SeedlingPainter o) =>
      o.leaf != leaf || o.pot != pot || o.soil != soil;
}

/// Wilted leaf — error state.
class ErrorLeafArt extends StatelessWidget {
  final double size;
  const ErrorLeafArt({super.key, this.size = 140});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _WiltPainter(VTColors.fruiting),
    );
  }
}

class _WiltPainter extends CustomPainter {
  final Color color;
  _WiltPainter(this.color);

  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()..color = color;
    canvas.save();
    canvas.translate(s.width * 0.5, s.height * 0.5);
    canvas.rotate(math.pi * 0.85);

    final leaf = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(
          s.width * 0.35, -s.height * 0.35, s.width * 0.55, 0)
      ..quadraticBezierTo(s.width * 0.35, s.height * 0.2, 0, 0)
      ..close();
    canvas.drawPath(leaf, p);

    canvas.drawLine(
      Offset.zero,
      Offset(s.width * 0.5, 0),
      Paint()
        ..color = Colors.black.withOpacity(0.15)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_WiltPainter o) => o.color != color;
}

// ---------------------------------------------------------------------------
// Reusable full-screen state widgets
// ---------------------------------------------------------------------------

class EmptyState extends StatelessWidget {
  final VoidCallback? onAdd;
  const EmptyState({super.key, this.onAdd});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EmptyGardenArt(),
            const SizedBox(height: VTSpace.lg),
            Text(
              'Plant your first seed',
              style: TextStyle(
                color: s.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: VTSpace.sm),
            Text(
              'Add a plant and VerdiTech will forecast its\n'
              'growth journey using cellular automata.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: s.textMuted, fontSize: 14, height: 1.5),
            ),
            if (onAdd != null) ...[
              const SizedBox(height: VTSpace.lg),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                    backgroundColor: s.verdantDeep,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14)),
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add your first plant'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const ErrorState({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ErrorLeafArt(),
            const SizedBox(height: VTSpace.lg),
            Text(
              'Something wilted',
              style: TextStyle(
                color: s.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: VTSpace.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: s.textMuted, fontSize: 13, height: 1.5),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: VTSpace.lg),
              OutlinedButton.icon(
                onPressed: onRetry,
                style: OutlinedButton.styleFrom(
                  foregroundColor: s.verdant,
                  side: BorderSide(color: s.verdant),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
