import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../models/skill_model.dart';

class TechStackGrid extends StatelessWidget {
  final bool animate;

  const TechStackGrid({super.key, this.animate = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final technologies = TechStackData.allTechnologies;

    return Wrap(
      spacing: isMobile ? 12 : 20,
      runSpacing: isMobile ? 12 : 20,
      alignment: WrapAlignment.center,
      children: List.generate(technologies.length, (index) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 400 + (index * 50)),
          opacity: animate ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: Duration(milliseconds: 400 + (index * 50)),
            offset: animate ? Offset.zero : const Offset(0, 0.3),
            curve: Curves.easeOutCubic,
            child: TechStackItem(tech: technologies[index]),
          ),
        );
      }),
    );
  }
}

class TechStackItem extends StatefulWidget {
  final TechItem tech;

  const TechStackItem({super.key, required this.tech});

  @override
  State<TechStackItem> createState() => _TechStackItemState();
}

class _TechStackItemState extends State<TechStackItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final tech = widget.tech;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: tech.name,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _scaleAnimation.value, child: child);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _isHovered
                  ? tech.color.withValues(alpha: 0.15)
                  : (isDark ? AppColors.darkCard : AppColors.lightCard),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? tech.color.withValues(alpha: 0.5)
                    : context.colorScheme.outline.withValues(alpha: 0.1),
                width: 1.5,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: tech.color.withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.15 : 0.05,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(tech),

                const SizedBox(height: 6),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: Text(
                    tech.name,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: tech.color,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(TechItem tech) {
    IconData iconData = tech.icon ?? Icons.code;
    Color iconColor = _isHovered
        ? tech.color
        : context.colorScheme.onSurfaceVariant;

    if (tech.name == 'Flutter') {
      return FlutterLogo(size: 28, style: FlutterLogoStyle.markOnly);
    }

    return Icon(iconData, size: 28, color: iconColor);
  }
}

class TechBadgeLarge extends StatefulWidget {
  final TechItem tech;

  const TechBadgeLarge({super.key, required this.tech});

  @override
  State<TechBadgeLarge> createState() => _TechBadgeLargeState();
}

class _TechBadgeLargeState extends State<TechBadgeLarge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final tech = widget.tech;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered
              ? tech.color.withValues(alpha: 0.15)
              : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? tech.color.withValues(alpha: 0.5)
                : context.colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: tech.color.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: tech.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: tech.name == 'Flutter'
                    ? const FlutterLogo(size: 20)
                    : Icon(
                        tech.icon ?? Icons.code,
                        size: 18,
                        color: tech.color,
                      ),
              ),
            ),

            const SizedBox(width: 12),

            Text(
              tech.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _isHovered ? tech.color : context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
