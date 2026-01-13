import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/theme_provider.dart';

class ThemeToggle extends ConsumerStatefulWidget {
  final double size;

  const ThemeToggle({super.key, this.size = 44});

  @override
  ConsumerState<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends ConsumerState<ThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );

    final isDark = ref.read(themeModeProvider) == ThemeMode.dark;
    _controller.value = isDark ? 1.0 : 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    final notifier = ref.read(themeModeProvider.notifier);
    final isDark = ref.read(themeModeProvider) == ThemeMode.dark;

    if (isDark) {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    notifier.toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: 'Toggle theme',
        child: GestureDetector(
          onTap: _toggleTheme,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _isHovered
                  ? colorScheme.primary.withValues(alpha: 0.1)
                  : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? colorScheme.primary.withValues(alpha: 0.5)
                    : colorScheme.outline.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159,
                  child: Icon(
                    _rotationAnimation.value > 0.5
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    size: 20,
                    color: _isHovered
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
