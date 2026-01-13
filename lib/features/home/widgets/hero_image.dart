import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class HeroImage extends StatefulWidget {
  final bool isMobile;

  const HeroImage({super.key, this.isMobile = false});

  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final size = widget.isMobile ? 220.0 : 350.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: child,
          );
        },
        child: Center(
          child: SizedBox(
            width: size + 60,
            height: size + 60,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _buildGlowRing(size + 50, isDark),

                _RotatingRing(size: size + 30),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: size,
                  height: size,
                  transform: Matrix4.identity()
                    ..scaleByDouble(_isHovered ? 1.03 : 1.0, 0.0, 0.0, 0.0),
                  transformAlignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.accent.withValues(alpha: 0.2),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: _isHovered ? 0.4 : 0.2,
                        ),
                        blurRadius: _isHovered ? 60 : 40,
                        spreadRadius: _isHovered ? 10 : 0,
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.05),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(child: _buildProfileImage(isDark, size)),
                  ),
                ),

                Positioned(
                  right: widget.isMobile ? 15 : 25,
                  bottom: widget.isMobile ? 15 : 25,
                  child: const _StatusDot(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlowRing(double size, bool isDark) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.08),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(bool isDark, double size) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
      ),
      child: Image.asset(
        AppAssets.profileImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            child: Center(
              child: Text(
                'S',
                style: TextStyle(
                  fontSize: widget.isMobile ? 70 : 100,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = AppColors.primaryGradient.createShader(
                      const Rect.fromLTWH(0, 0, 150, 150),
                    ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RotatingRing extends StatefulWidget {
  final double size;

  const _RotatingRing({required this.size});

  @override
  State<_RotatingRing> createState() => _RotatingRingState();
}

class _RotatingRingState extends State<_RotatingRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _DottedRingPainter(),
          ),
        );
      },
    );
  }
}

class _DottedRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const dotCount = 60;
    const dotRadius = 2.0;

    for (int i = 0; i < dotCount; i++) {
      final angle = (i / dotCount) * 2 * 3.14159;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);

      final opacity = (i % 3 == 0) ? 0.4 : 0.15;

      final paint = Paint()
        ..color = AppColors.primary.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatusDot extends StatefulWidget {
  const _StatusDot();

  @override
  State<_StatusDot> createState() => _StatusDotState();
}

class _StatusDotState extends State<_StatusDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.isDarkMode ? AppColors.darkBg : AppColors.lightBg,
            boxShadow: [
              BoxShadow(
                color: AppColors.success.withValues(
                  alpha: _controller.value * 0.5,
                ),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success,
              ),
            ),
          ),
        );
      },
    );
  }
}
