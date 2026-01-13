import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class FloatingTechBadges extends StatelessWidget {
  final double size;
  final bool isMobile;

  const FloatingTechBadges({super.key, this.size = 500, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final badges = _createBadges();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: badges.asMap().entries.map((entry) {
          final index = entry.key;
          final badge = entry.value;

          final angleInDegrees = (index * 60.0) - 90.0;
          final angleInRadians = angleInDegrees * (math.pi / 180.0);

          final distance = size * (isMobile ? 0.48 : 0.46);

          final x = (size / 2) + (distance * math.cos(angleInRadians));
          final y = (size / 2) + (distance * math.sin(angleInRadians));

          return Positioned(
            left: x,
            top: y,
            child: Transform.translate(
              offset: const Offset(-50, -20),
              child: badge,
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Widget> _createBadges() {
    return [
      _FloatingBadge(
        icon: Icons.flutter_dash,
        label: 'Flutter',
        color: AppColors.flutter,
        delay: Duration.zero,
        isMobile: isMobile,
      ),

      _FloatingBadge(
        icon: FontAwesomeIcons.code,
        label: 'Dart',
        color: AppColors.dart,
        delay: const Duration(milliseconds: 150),
        isMobile: isMobile,
      ),

      _FloatingBadge(
        icon: Icons.local_fire_department_rounded,
        label: 'Firebase',
        color: AppColors.firebase,
        delay: const Duration(milliseconds: 300),
        isMobile: isMobile,
      ),

      _FloatingBadge(
        icon: Icons.water_drop_rounded,
        label: isMobile ? 'Bloc' : 'Riverpod',
        color: AppColors.accent,
        delay: const Duration(milliseconds: 450),
        isMobile: isMobile,
      ),

      _FloatingBadge(
        icon: FontAwesomeIcons.codeBranch,
        label: 'Git',
        color: AppColors.git,
        delay: const Duration(milliseconds: 600),
        isMobile: isMobile,
      ),

      _FloatingBadge(
        icon: FontAwesomeIcons.figma,
        label: 'Figma',
        color: AppColors.figma,
        delay: const Duration(milliseconds: 750),
        isMobile: isMobile,
      ),
    ];
  }
}

class _FloatingBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Duration delay;
  final bool isMobile;

  const _FloatingBadge({
    required this.icon,
    required this.label,
    required this.color,
    required this.delay,
    required this.isMobile,
  });

  @override
  State<_FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<_FloatingBadge>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _appearController;
  late Animation<double> _floatAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _appearController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _appearController, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _appearController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _appearController.forward();
        _floatController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _appearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return AnimatedBuilder(
      animation: Listenable.merge([_floatController, _appearController]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(scale: _scaleAnimation.value, child: child),
          ),
        );
      },
      child: Tooltip(
        message: widget.label,
        child: Container(
          padding: widget.isMobile
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 6)
              : const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.color.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: widget.isMobile ? 20 : 24,
                height: widget.isMobile ? 20 : 24,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(child: _buildIcon(widget.isMobile ? 11 : 13)),
              ),
              SizedBox(width: widget.isMobile ? 6 : 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: widget.isMobile ? 10 : 12,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0A0A0A),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(double size) {
    final isFontAwesome =
        widget.icon.fontFamily?.contains('FontAwesome') ?? false;

    if (isFontAwesome) {
      return FaIcon(widget.icon, size: size, color: widget.color);
    }
    return Icon(widget.icon, size: size, color: widget.color);
  }
}
