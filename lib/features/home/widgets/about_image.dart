import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class AboutImage extends StatefulWidget {
  final bool isMobile;

  const AboutImage({super.key, this.isMobile = false});

  @override
  State<AboutImage> createState() => _AboutImageState();
}

class _AboutImageState extends State<AboutImage> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late Animation<double> _floatAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final size = widget.isMobile ? 300.0 : 450.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        height: size + 60,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            _buildBackgroundShapes(size, isDark),

            AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: child,
                );
              },
              child: _buildMainImage(context, size),
            ),

            Positioned(
              top: widget.isMobile ? 0 : 20,
              right: widget.isMobile ? 10 : -20,
              child: _ExperienceBadge(isHovered: _isHovered),
            ),

            Positioned(
              bottom: widget.isMobile ? 10 : 40,
              left: widget.isMobile ? 10 : -30,
              child: _CodeBadge(isHovered: _isHovered),
            ),

            ...List.generate(5, (index) {
              return Positioned(
                left: (index * 80.0) + 20,
                top: (index.isEven ? 20 : size - 40).toDouble(),
                child: _FloatingDot(
                  delay: Duration(milliseconds: index * 200),
                  size: 8.0 + (index * 2),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundShapes(double size, bool isDark) {
    return Stack(
      children: [
        Positioned(
          right: -20,
          bottom: -20,
          child: Container(
            width: size * 0.8,
            height: size * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: isDark ? 0.15 : 0.1),
                  AppColors.primary.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: -30,
          top: 30,
          child: Container(
            width: size * 0.5,
            height: size * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withValues(alpha: isDark ? 0.1 : 0.05),
                  AppColors.accent.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),

        Center(
          child: AnimatedBuilder(
            animation: _rotateController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateController.value * 2 * math.pi,
                child: child,
              );
            },
            child: CustomPaint(
              size: Size(size + 40, size + 40),
              painter: _DecorativeRingPainter(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainImage(BuildContext context, double size) {
    final isDark = context.isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      transform: Matrix4.identity()
        ..scaleByDouble(_isHovered ? 1.02 : 1.0, 0.0, 0.0, 0.0),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: _isHovered ? 0.3 : 0.15),
            blurRadius: _isHovered ? 40 : 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.profileImageAlt,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.8),
                        AppColors.accent.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.code_rounded,
                          size: size * 0.3,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sana Ullah',
                          style: TextStyle(
                            fontSize: size * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    _isHovered
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : Colors.transparent,
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceBadge extends StatelessWidget {
  final bool isHovered;

  const _ExperienceBadge({required this.isHovered});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      transform: Matrix4.identity()
        ..scaleByDouble(isHovered ? 1.05 : 1.0, 0.0, 0.0, 0.0),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: isHovered ? 0.2 : 0.1),
            blurRadius: isHovered ? 25 : 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              '3+',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Years\nExperience',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CodeBadge extends StatefulWidget {
  final bool isHovered;

  const _CodeBadge({required this.isHovered});

  @override
  State<_CodeBadge> createState() => _CodeBadgeState();
}

class _CodeBadgeState extends State<_CodeBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
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
        return Transform.translate(
          offset: Offset(0, _controller.value * 8 - 4),
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        transform: Matrix4.identity()
          ..scaleByDouble(widget.isHovered ? 1.05 : 1.0, 0.0, 0.0, 0.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(Icons.code_rounded, color: Colors.white, size: 28),
      ),
    );
  }
}

class _FloatingDot extends StatefulWidget {
  final Duration delay;
  final double size;

  const _FloatingDot({required this.delay, required this.size});

  @override
  State<_FloatingDot> createState() => _FloatingDotState();
}

class _FloatingDotState extends State<_FloatingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
        ),
      ),
    );
  }
}

class _DecorativeRingPainter extends CustomPainter {
  final Color color;

  _DecorativeRingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const dashCount = 40;
    const dashLength = 0.05;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i / dashCount) * 2 * math.pi;
      final sweepAngle = dashLength * 2 * math.pi;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
