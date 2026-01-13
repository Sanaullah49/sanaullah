import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class SkillOrbit extends StatefulWidget {
  final double size;

  const SkillOrbit({super.key, this.size = 400});

  @override
  State<SkillOrbit> createState() => _SkillOrbitState();
}

class _SkillOrbitState extends State<SkillOrbit>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<_OrbitItem> _orbitItems = [
    _OrbitItem(
      name: 'Flutter',
      color: AppColors.flutter,
      orbitRadius: 0.9,
      speed: 1.0,
    ),
    _OrbitItem(
      name: 'Dart',
      color: AppColors.dart,
      orbitRadius: 0.9,
      speed: 1.0,
      startAngle: 2.0,
    ),
    _OrbitItem(
      name: 'Firebase',
      color: AppColors.firebase,
      orbitRadius: 0.7,
      speed: 1.5,
    ),
    _OrbitItem(
      name: 'Bloc',
      color: AppColors.accent,
      orbitRadius: 0.7,
      speed: 1.5,
      startAngle: 3.14,
    ),
    _OrbitItem(name: 'Git', color: AppColors.git, orbitRadius: 0.5, speed: 2.0),
    _OrbitItem(
      name: 'Figma',
      color: AppColors.figma,
      orbitRadius: 0.5,
      speed: 2.0,
      startAngle: 3.14,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
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
    final isDark = context.isDarkMode;
    final size = widget.size;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ..._buildOrbitRings(size, isDark),

          _buildCenterLogo(size * 0.25),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: _orbitItems.map((item) {
                  return _buildOrbitingItem(item, size, _controller.value);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOrbitRings(double size, bool isDark) {
    return [0.5, 0.7, 0.9].map((radiusFactor) {
      return Container(
        width: size * radiusFactor,
        height: size * radiusFactor,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      );
    }).toList();
  }

  Widget _buildCenterLogo(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 30,
          ),
        ],
      ),
      child: const Center(
        child: FlutterLogo(size: 40, style: FlutterLogoStyle.markOnly),
      ),
    );
  }

  Widget _buildOrbitingItem(
    _OrbitItem item,
    double containerSize,
    double animationValue,
  ) {
    final orbitRadius = (containerSize / 2) * item.orbitRadius;
    final angle = (animationValue * item.speed * 2 * math.pi) + item.startAngle;

    final x = orbitRadius * math.cos(angle);
    final y = orbitRadius * math.sin(angle);

    return Positioned(
      left: (containerSize / 2) + x - 20,
      top: (containerSize / 2) + y - 20,
      child: _OrbitingBadge(name: item.name, color: item.color),
    );
  }
}

class _OrbitItem {
  final String name;
  final Color color;
  final double orbitRadius;
  final double speed;
  final double startAngle;

  const _OrbitItem({
    required this.name,
    required this.color,
    required this.orbitRadius,
    required this.speed,
    this.startAngle = 0,
  });
}

class _OrbitingBadge extends StatefulWidget {
  final String name;
  final Color color;

  const _OrbitingBadge({required this.name, required this.color});

  @override
  State<_OrbitingBadge> createState() => _OrbitingBadgeState();
}

class _OrbitingBadgeState extends State<_OrbitingBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.name,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.color.withValues(alpha: 0.2)
                : (isDark ? AppColors.darkCard : AppColors.lightCard),
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.color.withValues(alpha: _isHovered ? 0.8 : 0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: _isHovered ? 0.4 : 0.2),
                blurRadius: _isHovered ? 15 : 8,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.name[0],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
