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
    final isTablet = context.isTablet;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;
    final screenWidth = MediaQuery.of(context).size.width;

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

    if (isSmallMobile) {
      return Column(
        children: stats
            .map(
              (stat) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ExperienceStatCard(stat: stat),
              ),
            )
            .toList(),
      );
    }

    if (isMobile) {
      final cardWidth = (screenWidth - 64) / 2;
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: stats
            .map(
              (stat) => SizedBox(
                width: cardWidth,
                child: _ExperienceStatCard(stat: stat),
              ),
            )
            .toList(),
      );
    }

    if (isTablet) {
      return Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: stats
            .map(
              (stat) => SizedBox(
                width: (screenWidth * 0.8 - 60) / 2,
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
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          vertical: context.responsive(
            mobile: isSmallMobile ? 16 : 20,
            tablet: 22,
            desktop: 24,
          ),
          horizontal: context.responsive(
            mobile: isSmallMobile ? 12 : 16,
            tablet: 18,
            desktop: 20,
          ),
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(
            context.responsive(mobile: 16, tablet: 18, desktop: 20),
          ),
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
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -5.0 : 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: context.responsive(
                mobile: isSmallMobile ? 48 : 52,
                tablet: 54,
                desktop: 56,
              ),
              height: context.responsive(
                mobile: isSmallMobile ? 48 : 52,
                tablet: 54,
                desktop: 56,
              ),
              decoration: BoxDecoration(
                color: stat.color.withValues(alpha: _isHovered ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(
                  context.responsive(mobile: 14, tablet: 15, desktop: 16),
                ),
                border: Border.all(
                  color: stat.color.withValues(alpha: _isHovered ? 0.5 : 0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(
                  stat.icon,
                  size: context.responsive(
                    mobile: isSmallMobile ? 22 : 24,
                    tablet: 25,
                    desktop: 26,
                  ),
                  color: stat.color,
                ),
              ),
            ),

            SizedBox(
              height: context.responsive(mobile: 12, tablet: 14, desktop: 16),
            ),

            Text(
              stat.value,
              style: textTheme.headlineSmall?.copyWith(
                fontSize: context.responsive(
                  mobile: isSmallMobile ? 20.0 : 22.0,
                  tablet: 23.0,
                  desktop: 24.0,
                ),
                fontWeight: FontWeight.w700,
                color: _isHovered ? stat.color : colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              stat.label,
              style: textTheme.labelMedium?.copyWith(
                fontSize: context.responsive(
                  mobile: isSmallMobile ? 11.0 : 12.0,
                  tablet: 12.5,
                  desktop: 13.0,
                ),
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
