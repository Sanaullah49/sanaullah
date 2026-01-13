import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';

class ScrollToTopButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ScrollToTopButton({super.key, required this.onPressed});

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: _isHovered ? AppColors.ctaGradient : null,
            color: _isHovered
                ? null
                : (isDark ? AppColors.darkCard : AppColors.lightCard),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? Colors.transparent
                  : colorScheme.outline.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.1),
                blurRadius: _isHovered ? 20 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: _isHovered ? Colors.white : colorScheme.onSurfaceVariant,
            size: 24,
          ),
        ),
      ),
    );
  }
}
