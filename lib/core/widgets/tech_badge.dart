import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/theme_provider.dart';

class TechBadge extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;

  const TechBadge({super.key, required this.label, this.color, this.icon});

  factory TechBadge.flutter() =>
      TechBadge(label: 'Flutter', color: AppColors.flutterBlue);

  factory TechBadge.dart() =>
      TechBadge(label: 'Dart', color: AppColors.dartBlue);

  factory TechBadge.firebase() =>
      TechBadge(label: 'Firebase', color: AppColors.firebaseOrange);

  factory TechBadge.custom(String label, {Color? color}) =>
      TechBadge(label: label, color: color);

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? context.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: badgeColor),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: badgeColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class TechBadgeRow extends StatelessWidget {
  final List<String> technologies;
  final double spacing;
  final double runSpacing;

  const TechBadgeRow({
    super.key,
    required this.technologies,
    this.spacing = 8,
    this.runSpacing = 8,
  });

  Color _getTechColor(String tech) {
    switch (tech.toLowerCase()) {
      case 'flutter':
        return AppColors.flutterBlue;
      case 'dart':
        return AppColors.dartBlue;
      case 'firebase':
        return AppColors.firebaseOrange;
      case 'figma':
        return AppColors.figmaPurple;
      case 'git':
      case 'github':
        return AppColors.gitOrange;
      case 'bloc':
        return AppColors.primary;
      case 'provider':
        return AppColors.accent;
      case 'getx':
        return AppColors.success;
      case 'hive':
      case 'sqlite':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: technologies
          .map((tech) => TechBadge(label: tech, color: _getTechColor(tech)))
          .toList(),
    );
  }
}
