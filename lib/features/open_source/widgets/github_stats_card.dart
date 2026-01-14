import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../data/open_source_data.dart';

class GitHubStatsCard extends StatelessWidget {
  const GitHubStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final stats = OpenSourceData.githubStats;

    final statItems = [
      _StatItem(
        icon: Icons.folder_rounded,
        value: stats.publicRepos.toString(),
        label: 'Repositories',
        color: AppColors.primary,
      ),
      _StatItem(
        icon: Icons.star_rounded,
        value: stats.totalStars.toString(),
        label: 'Stars Earned',
        color: AppColors.warning,
      ),
      _StatItem(
        icon: FontAwesomeIcons.codeFork,
        value: stats.totalForks.toString(),
        label: 'Forks',
        color: AppColors.accent,
      ),
      _StatItem(
        icon: Icons.people_rounded,
        value: stats.followers.toString(),
        label: 'Followers',
        color: AppColors.success,
      ),
      _StatItem(
        icon: Icons.local_fire_department_rounded,
        value: '${stats.contributions}+',
        label: 'Contributions',
        color: AppColors.error,
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: statItems
                .map(
                  (item) => SizedBox(
                    width: (MediaQuery.of(context).size.width - 80) / 2,
                    child: _GitHubStatItem(stat: item),
                  ),
                )
                .toList(),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(flex: 2, child: _buildProfileHeader(context)),
        const SizedBox(width: 32),
        Expanded(
          flex: 5,
          child: Row(
            children: statItems
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _GitHubStatItem(stat: item),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return _HoverContainer(
      onTap: () => UrlLauncherUtils.openGitHub(),
      builder: (isHovered) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered
                  ? colorScheme.primary.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.github,
                    size: 32,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '@sanaullah49',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isHovered
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'View Profile',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        );
      },
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

class _GitHubStatItem extends StatefulWidget {
  final _StatItem stat;

  const _GitHubStatItem({required this.stat});

  @override
  State<_GitHubStatItem> createState() => _GitHubStatItemState();
}

class _GitHubStatItemState extends State<_GitHubStatItem> {
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
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
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: stat.color.withValues(alpha: _isHovered ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: stat.icon == FontAwesomeIcons.codeFork
                    ? FaIcon(stat.icon, size: 18, color: stat.color)
                    : Icon(stat.icon, size: 22, color: stat.color),
              ),
            ),
            const SizedBox(height: 12),
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
              style: textTheme.labelSmall?.copyWith(
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

class _HoverContainer extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final VoidCallback? onTap;

  const _HoverContainer({required this.builder, this.onTap});

  @override
  State<_HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<_HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: widget.builder(_isHovered),
      ),
    );
  }
}
