import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/verditech_theme.dart';

/// Frosted-glass surface used across all screens.
/// Reads fill + stroke from the active VTScheme so it adapts to light/dark.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double blur;
  final Color? tint;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(VTSpace.md),
    this.radius = VTSpace.radius,
    this.blur = 18,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    final s = VTTheme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: tint ?? s.glassFill,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: s.glassStroke, width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}
