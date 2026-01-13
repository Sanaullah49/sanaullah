import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class HeroBackground extends StatefulWidget {
  const HeroBackground({super.key});

  @override
  State<HeroBackground> createState() => _HeroBackgroundState();
}

class _HeroBackgroundState extends State<HeroBackground>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();

    _gradientController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _gradientController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              AppColors.darkBg,
                              Color.lerp(
                                AppColors.darkBg,
                                AppColors.primary.withValues(alpha: 0.05),
                                _gradientController.value,
                              )!,
                              AppColors.darkBgSecondary,
                            ]
                          : [
                              AppColors.lightBg,
                              Color.lerp(
                                AppColors.lightBg,
                                AppColors.primary.withValues(alpha: 0.03),
                                _gradientController.value,
                              )!,
                              AppColors.lightBgSecondary,
                            ],
                    ),
                  ),
                );
              },
            ),

            Positioned.fill(
              child: CustomPaint(
                painter: GridPatternPainter(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.02)
                      : Colors.black.withValues(alpha: 0.02),
                ),
              ),
            ),

            Positioned(
              top: -100,
              right: -100,
              child: _GlowSpot(
                color: AppColors.primary.withValues(
                  alpha: isDark ? 0.15 : 0.08,
                ),
                size: 400,
                controller: _gradientController,
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: _GlowSpot(
                color: AppColors.accent.withValues(alpha: isDark ? 0.1 : 0.05),
                size: 300,
                controller: _gradientController,
                reverse: true,
              ),
            ),

            Positioned.fill(
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ParticlesPainter(
                      progress: _particleController.value,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.3)
                          : AppColors.primary.withValues(alpha: 0.2),
                      size: constraints.biggest,
                    ),
                  );
                },
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.5,
                    colors: [
                      Colors.transparent,
                      (isDark ? AppColors.darkBg : AppColors.lightBg)
                          .withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      isDark ? AppColors.darkBg : AppColors.lightBg,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GlowSpot extends StatelessWidget {
  final Color color;
  final double size;
  final AnimationController controller;
  final bool reverse;

  const _GlowSpot({
    required this.color,
    required this.size,
    required this.controller,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = reverse ? 1 - controller.value : controller.value;
        final scale = 0.8 + (value * 0.4);

        return Transform.scale(
          scale: scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [color, color.withValues(alpha: 0)],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GridPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  GridPatternPainter({required this.color, this.spacing = 50});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ParticlesPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int particleCount;
  final Size size;

  ParticlesPainter({
    required this.progress,
    required this.color,
    this.particleCount = 30,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final effectiveSize = size.isEmpty ? canvasSize : size;

    if (effectiveSize.isEmpty) return;

    final random = math.Random(42);

    for (int i = 0; i < particleCount; i++) {
      final startX = random.nextDouble() * effectiveSize.width;
      final startY = random.nextDouble() * effectiveSize.height;

      final speed = 0.5 + random.nextDouble() * 0.5;
      final offset = progress * speed * effectiveSize.height * 0.3;

      final x = startX + math.sin(progress * math.pi * 2 + i) * 20;
      final y = (startY - offset) % effectiveSize.height;

      final particleSize = 1.5 + random.nextDouble() * 2.5;

      final opacity = (1 - (y / effectiveSize.height)) * 0.8;

      final paint = Paint()
        ..color = color.withValues(alpha: opacity.clamp(0.1, 0.6))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
