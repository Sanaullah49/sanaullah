import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../data/experience_data.dart';

class ExperienceStats extends StatelessWidget {
  const ExperienceStats({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    final stats = [
      _StatItem(
        icon: Icons.calendar_today_rounded,
        value: ExperienceData.totalExperience,
        label: 'Experience',
        color: AppColors.primary,
      ),
      _StatItem(
        icon: Icons.business_rounded,
        value: '${ExperienceData.experiences.length}',
        label: 'Companies',
        color: AppColors.accent,
      ),
      _StatItem(
        icon: Icons.apps_rounded,
        value: '10+',
        label: 'Apps Shipped',
        color: AppColors.success,
      ),
      _StatItem(
        icon: Icons.people_rounded,
        value: '5+',
        label: 'Happy Clients',
        color: AppColors.warning,
      ),
    ];

    if (isMobile) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: stats
            .map(
              (stat) => SizedBox(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                child: _ExperienceStatCard(stat: stat),
              ),
            )
            .toList(),
      );
    }

    return Row(
      children: stats
          .map(
            (stat) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _ExperienceStatCard(stat: stat),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _StatItem {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
}

class _ExperienceStatCard extends StatefulWidget {
  final _StatItem stat;

  const _ExperienceStatCard({required this.stat});

  @override
  State<_ExperienceStatCard> createState() => _ExperienceStatCardState();
}

class _ExperienceStatCardState extends State<_ExperienceStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final stat = widget.stat;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? stat.color.withValues(alpha: 0.5)
                : colorScheme.outline.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: stat.color.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _isHovered ? -5.0 : 0.0, 0.0, 0.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: stat.color.withValues(alpha: _isHovered ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: stat.color.withValues(alpha: _isHovered ? 0.5 : 0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(stat.icon, size: 26, color: stat.color),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              stat.value,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: _isHovered ? stat.color : colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              stat.label,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
