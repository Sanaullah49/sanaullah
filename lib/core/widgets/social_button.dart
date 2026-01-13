import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_urls.dart';
import '../theme/app_colors.dart';
import '../theme/theme_provider.dart';
import '../utils/url_launcher_utils.dart';

class SocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  final Color? hoverColor;
  final double size;

  const SocialButton({
    super.key,
    required this.icon,
    required this.url,
    required this.tooltip,
    this.hoverColor,
    this.size = 44,
  });

  factory SocialButton.github() => SocialButton(
    icon: FontAwesomeIcons.github,
    url: AppUrls.github,
    tooltip: 'GitHub',
    hoverColor: AppColors.github,
  );

  factory SocialButton.linkedin() => SocialButton(
    icon: FontAwesomeIcons.linkedin,
    url: AppUrls.linkedin,
    tooltip: 'LinkedIn',
    hoverColor: AppColors.linkedin,
  );

  factory SocialButton.twitter() => SocialButton(
    icon: FontAwesomeIcons.twitter,
    url: AppUrls.twitter,
    tooltip: 'Twitter',
    hoverColor: AppColors.twitter,
  );

  factory SocialButton.buyMeACoffee() => SocialButton(
    icon: FontAwesomeIcons.mugHot,
    url: AppUrls.buyMeACoffee,
    tooltip: 'Buy Me a Coffee',
    hoverColor: AppColors.buyMeACoffee,
  );

  factory SocialButton.email() => const SocialButton(
    icon: FontAwesomeIcons.envelope,
    url: AppUrls.email,
    tooltip: 'Email',
    hoverColor: AppColors.primary,
  );

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final hoverColor = widget.hoverColor ?? colorScheme.primary;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => UrlLauncherUtils.launchURL(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _isHovered
                  ? hoverColor.withValues(alpha: 0.15)
                  : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? hoverColor.withValues(alpha: 0.5)
                    : colorScheme.outline.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 18,
                color: _isHovered ? hoverColor : colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialButtonRow extends StatelessWidget {
  final double spacing;
  final bool showEmail;
  final bool showBuyMeACoffee;

  const SocialButtonRow({
    super.key,
    this.spacing = 12,
    this.showEmail = false,
    this.showBuyMeACoffee = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [
        SocialButton.github(),
        SocialButton.linkedin(),
        SocialButton.twitter(),
        if (showEmail) SocialButton.email(),
        if (showBuyMeACoffee) SocialButton.buyMeACoffee(),
      ],
    );
  }
}
