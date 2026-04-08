import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../models/github_models.dart';

class PubDevPackageCard extends StatefulWidget {
  final PubDevPackage package;

  const PubDevPackageCard({super.key, required this.package});

  @override
  State<PubDevPackageCard> createState() => _PubDevPackageCardState();
}

class _PubDevPackageCardState extends State<PubDevPackageCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final package = widget.package;
    final isMobile = context.isMobile;
    final isSmallMobile = MediaQuery.of(context).size.width < 360;

    final visiblePlatforms = isMobile
        ? package.platforms.take(4).toList(growable: false)
        : package.platforms;
    final hiddenPlatformsCount =
        package.platforms.length - visiblePlatforms.length;

    return MouseRegion(
      onEnter: isMobile ? null : (_) => setState(() => _isHovered = true),
      onExit: isMobile ? null : (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlLauncherUtils.launchURL(package.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: EdgeInsets.all(isSmallMobile ? 14 : (isMobile ? 16 : 22)),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(isMobile ? 18 : 20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accent.withValues(alpha: 0.42)
                  : colorScheme.outline.withValues(alpha: 0.1),
              width: 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.accent.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: isDark ? 0.14 : 0.03),
                blurRadius: _isHovered ? 24 : 14,
                offset: Offset(0, _isHovered ? 10 : 5),
              ),
            ],
          ),
          transform: Matrix4.identity()
            ..translateByDouble(
              0.0,
              isMobile ? 0.0 : (_isHovered ? -4.0 : 0.0),
              0.0,
              1.0,
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PackageLeadingIcon(isMobile: isMobile),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      package.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: isMobile ? 16 : 17,
                        fontWeight: FontWeight.w800,
                        color: _isHovered
                            ? AppColors.accent
                            : colorScheme.onSurface,
                      ),
                      maxLines: isMobile ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (package.isVerified)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.24),
                        ),
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        size: 14,
                        color: AppColors.accent,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MetaChip(
                    label: 'v${package.version}',
                    icon: Icons.sell_rounded,
                    color: AppColors.success,
                  ),
                  const _MetaChip(
                    label: 'pub.dev',
                    icon: Icons.open_in_new_rounded,
                    color: AppColors.primary,
                  ),
                  if (package.isVerified)
                    const _MetaChip(
                      label: 'Verified',
                      icon: Icons.verified_rounded,
                      color: AppColors.accent,
                    ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                package.description,
                style: textTheme.bodySmall?.copyWith(
                  fontSize: isMobile ? 12.8 : 13.2,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.7,
                ),
                maxLines: isMobile ? 4 : 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 14),

              LayoutBuilder(
                builder: (context, constraints) {
                  final statWidth = isMobile
                      ? (constraints.maxWidth < 330
                            ? (constraints.maxWidth - 8) / 2
                            : (constraints.maxWidth - 20) / 3)
                      : (constraints.maxWidth - 20) / 3;

                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SizedBox(
                        width: statWidth,
                        child: _StatBadge(
                          icon: Icons.favorite_rounded,
                          value: package.likes.toString(),
                          label: 'Likes',
                          color: AppColors.error,
                        ),
                      ),
                      SizedBox(
                        width: statWidth,
                        child: _StatBadge(
                          icon: Icons.star_rounded,
                          value: package.pubPoints.toString(),
                          label: 'Pub Points',
                          color: AppColors.warning,
                        ),
                      ),
                      SizedBox(
                        width: statWidth,
                        child: _StatBadge(
                          icon: Icons.trending_up_rounded,
                          value: package.downloadsLabel,
                          label: 'Downloads',
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...visiblePlatforms.map(
                    (platform) => _PlatformChip(
                      label: platform,
                      isMobile: isMobile,
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),
                  ),
                  if (hiddenPlatformsCount > 0)
                    _PlatformChip(
                      label: '+$hiddenPlatformsCount more',
                      isMobile: isMobile,
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                      highlighted: true,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PackageLeadingIcon extends StatelessWidget {
  final bool isMobile;

  const _PackageLeadingIcon({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? 44 : 52,
      height: isMobile ? 44 : 52,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accent.withValues(alpha: 0.2),
            AppColors.primary.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(isMobile ? 12 : 14),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.28),
          width: 1,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.inventory_2_rounded,
          size: 22,
          color: AppColors.accent,
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _MetaChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 13, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlatformChip extends StatelessWidget {
  final String label;
  final bool isMobile;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  final bool highlighted;

  const _PlatformChip({
    required this.label,
    required this.isMobile,
    required this.textTheme,
    required this.colorScheme,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = highlighted
        ? AppColors.primary.withValues(alpha: 0.12)
        : colorScheme.surfaceContainerHighest;
    final borderColor = highlighted
        ? AppColors.primary.withValues(alpha: 0.24)
        : colorScheme.outline.withValues(alpha: 0.08);
    final textColor = highlighted
        ? AppColors.primary
        : colorScheme.onSurfaceVariant;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 9 : 10,
        vertical: isMobile ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          fontSize: isMobile ? 10.5 : 11,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
