import 'package:flutter/material.dart';
import '../theme/verditech_theme.dart';

// ---------------------------------------------------------------------------
// Core shimmer primitive — no external dependency.
// Uses a ShaderMask with a travelling LinearGradient.
// ---------------------------------------------------------------------------

class VTShimmer extends StatefulWidget {
  final Widget child;
  const VTShimmer({super.key, required this.child});

  @override
  State<VTShimmer> createState() => _VTShimmerState();
}

class _VTShimmerState extends State<VTShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    final base = s.surfaceHigh;
    final highlight = s.brightness == Brightness.dark
        ? Colors.white.withOpacity(0.08)
        : Colors.white.withOpacity(0.65);

    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [base, highlight, base],
          stops: const [0.35, 0.5, 0.65],
          transform: _SlideTransform(_c.value * 2 - 1, bounds.width),
        ).createShader(bounds),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _SlideTransform extends GradientTransform {
  final double slide;
  final double width;
  const _SlideTransform(this.slide, this.width);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(slide * width, 0, 0);
}

// ---------------------------------------------------------------------------
// Skeleton building block
// ---------------------------------------------------------------------------

class SkeletonBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;

  const SkeletonBox({super.key, this.width, this.height, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: s.surfaceHigh,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Composed skeletons
// ---------------------------------------------------------------------------

/// Single card-shaped skeleton that matches PlantCard's proportions.
class PlantCardSkeleton extends StatelessWidget {
  const PlantCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return VTShimmer(
      child: Container(
        padding: const EdgeInsets.all(VTSpace.md),
        decoration: BoxDecoration(
          color: s.surface,
          borderRadius: BorderRadius.circular(VTSpace.radius),
          border: Border.all(color: s.glassStroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SkeletonBox(width: 44, height: 44, radius: 14),
            Spacer(),
            SkeletonBox(width: 90, height: 14),
            SizedBox(height: 8),
            SkeletonBox(width: 60, height: 10),
            SizedBox(height: 14),
            SkeletonBox(width: 70, height: 22, radius: 100),
            SizedBox(height: 12),
            SkeletonBox(height: 6, radius: 100),
          ],
        ),
      ),
    );
  }
}

/// Full dashboard grid placeholder while plants load from drift.
class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: VTSpace.md,
        crossAxisSpacing: VTSpace.md,
        childAspectRatio: 0.82,
      ),
      itemCount: 4,
      itemBuilder: (_, __) => const PlantCardSkeleton(),
    );
  }
}

/// Placeholder shown while the CA engine is computing a forecast.
class CAComputingSkeleton extends StatelessWidget {
  const CAComputingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return Column(
      children: [
        Expanded(
          child: VTShimmer(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: 96,
              itemBuilder: (_, __) => const SkeletonBox(radius: 3),
            ),
          ),
        ),
        const SizedBox(height: VTSpace.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: s.verdant),
            ),
            const SizedBox(width: VTSpace.sm),
            Text(
              'Running cellular automata…',
              style: TextStyle(color: s.textMuted, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
