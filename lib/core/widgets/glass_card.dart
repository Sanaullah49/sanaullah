import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/theme_provider.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blur;
  final Color? backgroundColor;
  final double opacity;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.blur = 10,
    this.backgroundColor,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor = backgroundColor ?? (isDark ? Colors.white : Colors.black);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: bgColor.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: bgColor.withValues(alpha: opacity * 2),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
