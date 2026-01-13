import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../models/skill_model.dart';

class SkillBar extends StatefulWidget {
  final SkillProficiency proficiency;
  final bool animate;
  final Duration delay;

  const SkillBar({
    super.key,
    required this.proficiency,
    this.animate = false,
    this.delay = Duration.zero,
  });

  @override
  State<SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void didUpdateWidget(covariant SkillBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_hasStarted) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _hasStarted = true;
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
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
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final proficiency = widget.proficiency;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? proficiency.color.withValues(alpha: 0.4)
                : colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: proficiency.color.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    proficiency.name,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _isHovered
                          ? proficiency.color
                          : colorScheme.onSurface,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final value = (_animation.value * proficiency.percentage)
                        .round();
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: proficiency.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$value%',
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: proficiency.color,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkBgTertiary
                        : AppColors.lightBgSecondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),

                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      widthFactor:
                          _animation.value * (proficiency.percentage / 100),
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              proficiency.color,
                              proficiency.color.withValues(alpha: 0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: proficiency.color.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      widthFactor:
                          _animation.value * (proficiency.percentage / 100),
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withValues(alpha: 0.2),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CompactSkillBar extends StatelessWidget {
  final String name;
  final int percentage;
  final Color color;

  const CompactSkillBar({
    super.key,
    required this.name,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkBgTertiary
                    : AppColors.lightBgSecondary,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
