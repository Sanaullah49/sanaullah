import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/theme_provider.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool enableGlow;
  final Color? glowColor;
  final Color? backgroundColor;
  final Gradient? gradient;

  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.borderRadius = 16,
    this.enableGlow = true,
    this.glowColor,
    this.backgroundColor,
    this.gradient,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
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
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;

    final bgColor =
        widget.backgroundColor ??
        (isDark ? AppColors.darkCard : AppColors.lightCard);
    final hoverBgColor = isDark
        ? AppColors.darkCardHover
        : AppColors.lightCardHover;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final hoverBorderColor =
        widget.glowColor?.withValues(alpha: 0.5) ??
        colorScheme.primary.withValues(alpha: 0.5);

    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.gradient == null
                ? (_isHovered ? hoverBgColor : bgColor)
                : null,
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isHovered ? hoverBorderColor : borderColor,
              width: 1,
            ),
            boxShadow: widget.enableGlow && _isHovered
                ? (isDark
                      ? AppShadows.cardHoverShadowDark
                      : AppShadows.cardHoverShadowLight)
                : (isDark
                      ? AppShadows.cardShadowDark
                      : AppShadows.cardShadowLight),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Padding(
                padding: widget.padding ?? const EdgeInsets.all(24),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
