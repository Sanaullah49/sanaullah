import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../models/skill_model.dart';

class SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;

  const SkillCategoryCard({super.key, required this.category});

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final category = widget.category;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: null,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? category.color.withValues(alpha: 0.5)
                : colorScheme.outline.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? category.color.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: _isHovered ? 30 : 15,
              offset: Offset(0, _isHovered ? 10 : 5),
            ),
          ],
        ),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _isHovered ? -8.0 : 0.0, 0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: category.color.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(category.icon, size: 24, color: category.color),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: Icon(
                    Icons.arrow_outward_rounded,
                    size: 20,
                    color: category.color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              category.title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: _isHovered ? category.color : colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              category.description,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.skills.map((skill) {
                return _SkillChip(
                  label: skill,
                  color: category.color,
                  isHovered: _isHovered,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isHovered;

  const _SkillChip({
    required this.label,
    required this.color,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isHovered
            ? color.withValues(alpha: 0.15)
            : (isDark ? AppColors.darkBgTertiary : AppColors.lightBgSecondary),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isHovered
              ? color.withValues(alpha: 0.3)
              : context.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isHovered ? color : context.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
