import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../router/route_names.dart';
import '../widgets/about_image.dart';
import '../widgets/info_card.dart';
import '../widgets/stats_row.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    return SectionWrapper(
      sectionId: 'about',
      child: Column(
        children: [
          const SectionTitle(
            tag: 'ABOUT ME',
            title: 'Turning Ideas Into Reality',
            subtitle:
                'A passionate Flutter developer dedicated to creating exceptional mobile experiences',
          ),

          SizedBox(height: isMobile ? 48 : 80),

          isMobile || isTablet
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),

          SizedBox(height: isMobile ? 48 : 80),

          const StatsRow(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 5, child: AboutImage()),

        const SizedBox(width: 80),

        Expanded(flex: 6, child: _buildAboutContent(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        const AboutImage(isMobile: true),

        const SizedBox(height: 48),

        _buildAboutContent(context, centerAlign: true),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context, {bool centerAlign = false}) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: centerAlign
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "Hello! I'm Sana Ullah, a passionate Flutter developer based in Lahore, Pakistan. "
          "With over 3 years of hands-on experience, I specialize in building beautiful, "
          "performant mobile applications that solve real-world problems.",
          style: textTheme.bodyLarge?.copyWith(
            height: 1.8,
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
        ),

        const SizedBox(height: 24),

        Text(
          "My journey has taken me through diverse domains including healthcare apps that "
          "interface with medical devices, fintech solutions handling secure transactions, "
          "and consumer products used by thousands of users daily.",
          style: textTheme.bodyLarge?.copyWith(
            height: 1.8,
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
        ),

        const SizedBox(height: 32),

        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
          children: [
            InfoCard(
              icon: Icons.location_on_rounded,
              label: 'Location',
              value: 'Lahore, Pakistan',
              color: AppColors.primary,
            ),
            InfoCard(
              icon: Icons.work_rounded,
              label: 'Experience',
              value: '3+ Years',
              color: AppColors.accent,
            ),
            InfoCard(
              icon: Icons.language_rounded,
              label: 'Languages',
              value: 'English, Urdu',
              color: AppColors.success,
            ),
            InfoCard(
              icon: Icons.verified_rounded,
              label: 'Status',
              value: 'Available',
              color: AppColors.warning,
            ),
          ],
        ),

        const SizedBox(height: 40),

        _buildWhatIDo(context, centerAlign),

        const SizedBox(height: 40),

        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PrimaryButton(
              text: 'Download Resume',
              icon: Icons.download_rounded,
              onPressed: () => UrlLauncherUtils.downloadResume(),
            ),
            SecondaryButton(
              text: 'Let\'s Talk',
              icon: Icons.chat_rounded,
              onPressed: () => context.go(RouteNames.hireMe),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWhatIDo(BuildContext context, bool centerAlign) {
    final textTheme = context.textTheme;

    final items = [
      _WhatIDoItem(
        icon: Icons.phone_android_rounded,
        title: 'Mobile Development',
        description: 'Native-quality apps for iOS & Android',
      ),
      _WhatIDoItem(
        icon: Icons.architecture_rounded,
        title: 'Clean Architecture',
        description: 'Scalable & maintainable code structure',
      ),
      _WhatIDoItem(
        icon: Icons.speed_rounded,
        title: 'Performance',
        description: 'Optimized for speed & efficiency',
      ),
      _WhatIDoItem(
        icon: Icons.palette_rounded,
        title: 'UI/UX Design',
        description: 'Beautiful & intuitive interfaces',
      ),
    ];

    return Column(
      crossAxisAlignment: centerAlign
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'What I Do',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
          children: items.map((item) => _WhatIDoChip(item: item)).toList(),
        ),
      ],
    );
  }
}

class _WhatIDoItem {
  final IconData icon;
  final String title;
  final String description;

  const _WhatIDoItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _WhatIDoChip extends StatefulWidget {
  final _WhatIDoItem item;

  const _WhatIDoChip({required this.item});

  @override
  State<_WhatIDoChip> createState() => _WhatIDoChipState();
}

class _WhatIDoChipState extends State<_WhatIDoChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: widget.item.description,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? colorScheme.primary.withValues(alpha: 0.1)
                : (isDark ? AppColors.darkCard : AppColors.lightBgSecondary),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? colorScheme.primary.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.item.icon,
                size: 18,
                color: _isHovered
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
