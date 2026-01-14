import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/utils/url_launcher_utils.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/section_title.dart';
import '../../core/widgets/social_button.dart';
import '../../router/route_names.dart';
import '../home/widgets/about_image.dart';
import '../home/widgets/info_card.dart';
import '../home/widgets/stats_row.dart';
import '../home/widgets/timeline_item.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildStorySection(context),
          _buildEducationSection(context),
          _buildValuesSection(context),
          _buildFunFactsSection(context),
          _buildCTASection(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final horizontalPadding = context.horizontalPadding;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 60 : 100,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            const SectionTitle(
              tag: 'ABOUT ME',
              title: 'The Story Behind the Code',
              subtitle:
                  'Get to know the developer behind the apps you use every day',
            ),
            SizedBox(height: isMobile ? 48 : 80),
            isMobile || isTablet
                ? Column(
                    children: [
                      const AboutImage(isMobile: true),
                      const SizedBox(height: 48),
                      _buildQuickInfo(context, centerAlign: true),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(flex: 5, child: AboutImage()),
                      const SizedBox(width: 80),
                      Expanded(
                        flex: 6,
                        child: _buildQuickInfo(context, centerAlign: false),
                      ),
                    ],
                  ),
            SizedBox(height: isMobile ? 48 : 80),
            const StatsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfo(BuildContext context, {required bool centerAlign}) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final align = centerAlign
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          "Hello, I'm",
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            AppConstants.name,
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "A passionate Flutter developer with a mission to create impactful "
          "mobile experiences. Based in Lahore, Pakistan, I work with clients "
          "worldwide to turn their ideas into reality.",
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.8,
          ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
          children: [
            InfoCard(
              icon: Icons.location_on_rounded,
              label: 'Location',
              value: 'Lahore, Pakistan',
              color: AppColors.primary,
            ),
            InfoCard(
              icon: Icons.cake_rounded,
              label: 'Born',
              value: 'January 1999',
              color: AppColors.secondary,
            ),
            InfoCard(
              icon: Icons.school_rounded,
              label: 'Degree',
              value: 'BS IT',
              color: AppColors.accent,
            ),
            InfoCard(
              icon: Icons.verified_rounded,
              label: 'IELTS',
              value: 'Band 6.5',
              color: AppColors.success,
            ),
          ],
        ),
        const SizedBox(height: 32),
        const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
      ],
    );
  }

  Widget _buildStorySection(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return Container(
      width: double.infinity,
      color: context.isDarkMode
          ? AppColors.darkBgSecondary
          : AppColors.lightBgSecondary,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'MY JOURNEY',
            title: 'From Curiosity to Career',
          ),
          const SizedBox(height: 48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                _buildStoryParagraph(
                  context,
                  "My journey into software development began during my university "
                  "years when I first discovered the power of creating something "
                  "from nothing but code. What started as curiosity quickly became "
                  "a passion.",
                ),
                const SizedBox(height: 24),
                _buildStoryParagraph(
                  context,
                  "I discovered Flutter in 2021, and it was love at first sight. "
                  "The ability to build beautiful, native-quality apps for multiple "
                  "platforms with a single codebase was exactly what I was looking for.",
                ),
                const SizedBox(height: 24),
                _buildStoryParagraph(
                  context,
                  "Since then, I've had the privilege of working on diverse projects "
                  "— from healthcare apps that interface with medical devices to "
                  "fintech solutions handling secure transactions. Each project has "
                  "taught me something new and fueled my passion for clean, "
                  "maintainable code.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurfaceVariant,
        height: 1.9,
        fontSize: 17,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const SectionTitle(tag: 'EDUCATION', title: 'Academic Background'),
          const SizedBox(height: 48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: const TimelineItem(
              title: 'Bachelor of Science in Information Technology',
              subtitle: 'University of Education, Lahore',
              period: '2018 - 2022',
              location: 'Lahore, Pakistan',
              points: [
                'Graduated with CGPA 3.54/4.00',
                'Focused on software development and mobile technologies',
                'Final year project: Cross-platform mobile application',
                'Active member of the programming society',
              ],
              isFirst: true,
              isLast: true,
              accentColor: AppColors.accent,
              icon: Icons.school_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    final values = [
      _ValueItem(
        icon: Icons.code_rounded,
        title: 'Clean Code',
        description:
            'I believe in writing code that is readable, maintainable, and scalable.',
        color: AppColors.primary,
      ),
      _ValueItem(
        icon: Icons.groups_rounded,
        title: 'Collaboration',
        description:
            'Great products are built by great teams. I value open communication.',
        color: AppColors.accent,
      ),
      _ValueItem(
        icon: Icons.trending_up_rounded,
        title: 'Continuous Learning',
        description:
            'Technology evolves rapidly. I stay current with the latest trends.',
        color: AppColors.success,
      ),
      _ValueItem(
        icon: Icons.favorite_rounded,
        title: 'User-Centric',
        description:
            'Every decision should ultimately benefit the end user experience.',
        color: AppColors.error,
      ),
    ];

    return Container(
      color: context.isDarkMode
          ? AppColors.darkBgSecondary
          : AppColors.lightBgSecondary,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const SectionTitle(tag: 'CORE VALUES', title: 'What I Stand For'),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: values
                .map(
                  (value) => SizedBox(
                    width: isMobile ? double.infinity : 280,
                    child: FeatureInfoCard(
                      icon: value.icon,
                      title: value.title,
                      description: value.description,
                      color: value.color,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFunFactsSection(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;
    final colorScheme = context.colorScheme;

    final facts = [
      '☕ Coffee is my fuel for late-night coding sessions',
      '🎮 I enjoy gaming when I need a mental break',
      '📚 Currently reading: Clean Architecture by Uncle Bob',
      '🌍 Dream destination: Silicon Valley, USA',
      '🎵 I code better with Lo-Fi music in the background',
      '🐱 Cat person (they understand the debugging struggle)',
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const SectionTitle(tag: 'FUN FACTS', title: 'Beyond the Code'),
          const SizedBox(height: 48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: facts.map((fact) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? AppColors.darkCard
                        : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    fact,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return Container(
      width: double.infinity,
      color: context.isDarkMode
          ? AppColors.darkBgSecondary
          : AppColors.lightBgSecondary,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 60 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Text(
                "Let's Create Something Amazing",
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Whether you have a project in mind or just want to chat about "
                "Flutter development, I'd love to hear from you!",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  PrimaryButton(
                    text: 'Hire Me',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: () => context.go(RouteNames.hireMe),
                  ),
                  SecondaryButton(
                    text: 'Download Resume',
                    icon: Icons.download_rounded,
                    onPressed: () => UrlLauncherUtils.downloadResume(),
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

class _ValueItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _ValueItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
