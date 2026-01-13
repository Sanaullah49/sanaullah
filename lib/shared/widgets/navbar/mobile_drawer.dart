import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/social_button.dart';
import '../../../router/route_names.dart';

class MobileDrawer extends StatelessWidget {
  final String currentPath;

  const MobileDrawer({super.key, required this.currentPath});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBgSecondary : AppColors.lightCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Menu', style: context.textTheme.headlineSmall),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildNavItem(
                  context,
                  'Home',
                  RouteNames.home,
                  Icons.home_rounded,
                ),
                _buildNavItem(
                  context,
                  'About',
                  RouteNames.about,
                  Icons.person_rounded,
                ),
                _buildNavItem(
                  context,
                  'Projects',
                  RouteNames.projects,
                  Icons.work_rounded,
                ),
                _buildNavItem(
                  context,
                  'Blog',
                  RouteNames.blog,
                  Icons.article_rounded,
                ),

                const SizedBox(height: 32),

                PrimaryButton(
                  text: 'Hire Me',
                  icon: Icons.rocket_launch_rounded,
                  fullWidth: true,
                  onPressed: () {
                    Navigator.pop(context);
                    context.go(RouteNames.hireMe);
                  },
                ),

                const SizedBox(height: 32),

                Text(
                  'Connect with me',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton.github(),
                    const SizedBox(width: 16),
                    SocialButton.linkedin(),
                    const SizedBox(width: 16),
                    SocialButton.twitter(),
                    const SizedBox(width: 16),
                    SocialButton.buyMeACoffee(),
                  ],
                ),

                const SizedBox(height: 32),

                _buildContactItem(
                  context,
                  Icons.email_rounded,
                  AppConstants.email,
                  () => UrlLauncherUtils.launchEmail(),
                ),
                _buildContactItem(
                  context,
                  Icons.location_on_rounded,
                  AppConstants.location,
                  null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    String path,
    IconData icon,
  ) {
    final colorScheme = context.colorScheme;
    final isActive =
        currentPath == path ||
        (path != RouteNames.home && currentPath.startsWith(path));

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isActive
            ? colorScheme.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            context.go(path);
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isActive
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  size: 22,
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                if (isActive)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback? onTap,
  ) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 18, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
