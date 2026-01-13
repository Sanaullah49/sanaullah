import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/social_button.dart';
import '../../../router/route_names.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return Container(
      color: isDark ? AppColors.darkBgSecondary : AppColors.lightBgSecondary,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              if (width > 900) {
                return _buildDesktopLayout(context);
              } else if (width > 600) {
                return _buildTabletLayout(context);
              } else {
                return _buildMobileLayout(context);
              }
            },
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: _buildBottomBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 64),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildBrandColumn(context)),
          const SizedBox(width: 40),
          Expanded(
            flex: 2,
            child: _buildLinksColumn(context, 'Quick Links', _quickLinks),
          ),
          Expanded(
            flex: 2,
            child: _buildLinksColumn(context, 'Resources', _resourceLinks),
          ),
          Expanded(flex: 3, child: _buildContactColumn(context)),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildBrandColumn(context)),
              const SizedBox(width: 24),
              Expanded(child: _buildContactColumn(context)),
            ],
          ),
          const SizedBox(height: 48),
          Divider(color: context.colorScheme.outline.withValues(alpha: 0.1)),
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildLinksColumn(context, 'Quick Links', _quickLinks),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildLinksColumn(context, 'Resources', _resourceLinks),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandColumn(context),
          const SizedBox(height: 40),
          _buildContactColumn(context),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            children: [
              _buildLinksColumn(context, 'Quick Links', _quickLinks),
              _buildLinksColumn(context, 'Resources', _resourceLinks),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.go(RouteNames.home),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'S',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppConstants.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppConstants.tagline,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
      ],
    );
  }

  Widget _buildLinksColumn(
    BuildContext context,
    String title,
    List<_FooterLink> links,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FooterLinkWidget(link: link),
          ),
        ),
      ],
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          context,
          Icons.email_outlined,
          AppConstants.email,
          () => UrlLauncherUtils.launchEmail(),
        ),
        const SizedBox(height: 12),
        _buildContactItem(
          context,
          Icons.location_on_outlined,
          AppConstants.location,
          null,
        ),
        const SizedBox(height: 12),
        _buildContactItem(
          context,
          Icons.schedule_outlined,
          'Available for Remote Work',
          null,
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback? onTap,
  ) {
    return MouseRegion(
      cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: context.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  decoration: onTap != null ? TextDecoration.underline : null,
                  decorationColor: context.colorScheme.primary.withValues(
                    alpha: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final year = DateTime.now().year;
    final isMobile = context.isMobile;

    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      runSpacing: 10,
      children: [
        Text(
          '© $year ${AppConstants.name}. All rights reserved.',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Built with ',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const FaIcon(
              FontAwesomeIcons.solidHeart,
              size: 12,
              color: AppColors.error,
            ),
            Text(
              ' using ',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const FlutterLogo(size: 16),
            Text(
              ' Flutter',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static const _quickLinks = [
    _FooterLink('Home', RouteNames.home),
    _FooterLink('About', RouteNames.about),
    _FooterLink('Projects', RouteNames.projects),
    _FooterLink('Blog', RouteNames.blog),
  ];

  static const _resourceLinks = [
    _FooterLink('Resume', AppUrls.resumeUrl, isExternal: true),
    _FooterLink('GitHub', AppUrls.github, isExternal: true),
    _FooterLink('Pub.dev', AppUrls.pubDevProfile, isExternal: true),
    _FooterLink('Buy Me a Coffee', AppUrls.buyMeACoffee, isExternal: true),
  ];
}

class _FooterLink {
  final String label;
  final String path;
  final bool isExternal;

  const _FooterLink(this.label, this.path, {this.isExternal = false});
}

class _FooterLinkWidget extends StatefulWidget {
  final _FooterLink link;

  const _FooterLinkWidget({required this.link});

  @override
  State<_FooterLinkWidget> createState() => _FooterLinkWidgetState();
}

class _FooterLinkWidgetState extends State<_FooterLinkWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.link.isExternal) {
            UrlLauncherUtils.launchURL(widget.link.path);
          } else {
            context.go(widget.link.path);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 14,
                color: _isHovered
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                fontWeight: _isHovered ? FontWeight.w500 : FontWeight.normal,
              ),
              child: Text(widget.link.label),
            ),
            if (widget.link.isExternal) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.open_in_new_rounded,
                size: 12,
                color: _isHovered
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
