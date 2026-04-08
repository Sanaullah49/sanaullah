import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class HeroBackground extends StatelessWidget {
  const HeroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          AppColors.darkBg,
                          const Color(0xFF17153A),
                          AppColors.darkBgSecondary,
                        ]
                      : [
                          AppColors.lightBg,
                          const Color(0xFFF1EEFF),
                          AppColors.lightBgSecondary,
                        ],
                ),
              ),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPatternPainter(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.035)
                      : Colors.black.withValues(alpha: 0.035),
                ),
              ),
            ),
            Positioned(
              top: -120,
              right: -60,
              child: _GlowBlob(
                color: AppColors.primary.withValues(
                  alpha: isDark ? 0.22 : 0.14,
                ),
                size: 360,
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: _GlowBlob(
                color: AppColors.secondary.withValues(
                  alpha: isDark ? 0.18 : 0.12,
                ),
                size: 320,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: constraints.maxWidth * 0.34,
                margin: EdgeInsets.only(
                  right: constraints.maxWidth > 900 ? 48 : 16,
                  top: 80,
                  bottom: 80,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.06),
                  ),
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: isDark ? 0.02 : 0.35),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.35,
                    colors: [
                      Colors.transparent,
                      (isDark ? AppColors.darkBg : AppColors.lightBg)
                          .withValues(alpha: 0.86),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 220,
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

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  final Color color;

  _GridPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 56.0;
    final minor = Paint()
      ..color = color
      ..strokeWidth = 0.8;
    final major = Paint()
      ..color = color.withValues(alpha: 1.65)
      ..strokeWidth = 1.1;

    for (double x = 0; x < size.width; x += spacing) {
      final isMajor = ((x / spacing).round()) % 4 == 0;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        isMajor ? major : minor,
      );
    }

    for (double y = 0; y < size.height; y += spacing) {
      final isMajor = ((y / spacing).round()) % 4 == 0;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        isMajor ? major : minor,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
