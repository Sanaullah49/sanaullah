import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/tech_badge.dart';
import '../../../router/route_names.dart';
import '../data/projects_data.dart';
import '../models/project_model.dart';
import '../widgets/phone_mockup.dart';

class ProjectDetailPage extends StatelessWidget {
  final String slug;

  const ProjectDetailPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final project = ProjectsData.getBySlug(slug);

    if (project == null) {
      return _buildNotFound(context);
    }

    return _ProjectDetailContent(project: project);
  }

  Widget _buildNotFound(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(48),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_off_rounded,
                size: 80,
                color: context.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.5,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Project Not Found',
                style: context.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Text(
                  'The project you\'re looking for doesn\'t exist or has been removed.',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'View All Projects',
                icon: Icons.arrow_back_rounded,
                onPressed: () => context.go(RouteNames.projects),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectDetailContent extends StatelessWidget {
  final Project project;

  const _ProjectDetailContent({required this.project});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1100;
    final horizontalPadding = context.horizontalPadding;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context, isMobile: isMobile, isTablet: isTablet),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40 : (isTablet ? 60 : 80),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: isMobile
                  ? _buildMobileContent(context)
                  : (isTablet
                        ? _buildTabletContent(context)
                        : _buildDesktopContent(context)),
            ),
          ),

          _buildOtherProjects(context, isMobile: isMobile, isTablet: isTablet),
        ],
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final horizontalPadding = context.horizontalPadding;
    final verticalPadding = isMobile ? 40.0 : (isTablet ? 60.0 : 80.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            project.accentColor.withValues(alpha: isDark ? 0.15 : 0.1),
            project.accentColor.withValues(alpha: isDark ? 0.05 : 0.02),
          ],
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BackButton(
              onPressed: () => context.go(RouteNames.projects),
              isMobile: isMobile,
            ),

            SizedBox(height: isMobile ? 24 : (isTablet ? 32 : 40)),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildCategoryBadge(
                  context,
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
                _buildStatusBadge(
                  context,
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
              ],
            ),

            SizedBox(height: isMobile ? 16 : (isTablet ? 20 : 24)),

            Text(
              project.title,
              style:
                  (isMobile
                          ? context.textTheme.headlineMedium
                          : (isTablet
                                ? context.textTheme.headlineLarge
                                : context.textTheme.displaySmall))
                      ?.copyWith(fontWeight: FontWeight.w800),
              textAlign: isMobile ? TextAlign.start : TextAlign.start,
            ),

            SizedBox(height: isMobile ? 12 : (isTablet ? 14 : 16)),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                project.shortDescription,
                style:
                    (isMobile
                            ? context.textTheme.bodyLarge
                            : context.textTheme.bodyLarge)
                        ?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.7,
                          fontSize: isMobile ? 16 : (isTablet ? 17 : 18),
                        ),
                textAlign: isMobile ? TextAlign.start : TextAlign.start,
              ),
            ),

            SizedBox(height: isMobile ? 24 : (isTablet ? 28 : 32)),

            _buildActionButtons(
              context,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final hPadding = isMobile ? 12.0 : (isTablet ? 14.0 : 16.0);
    final vPadding = isMobile ? 6.0 : (isTablet ? 7.0 : 8.0);
    final iconSize = isMobile ? 16.0 : (isTablet ? 18.0 : 18.0);
    final fontSize = isMobile ? 12.0 : (isTablet ? 13.0 : 14.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      decoration: BoxDecoration(
        color: project.category.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: project.category.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            project.category.icon,
            size: iconSize,
            color: project.category.color,
          ),
          const SizedBox(width: 8),
          Text(
            project.category.label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: project.category.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final hPadding = isMobile ? 10.0 : (isTablet ? 12.0 : 14.0);
    final vPadding = isMobile ? 6.0 : (isTablet ? 7.0 : 8.0);
    final fontSize = isMobile ? 12.0 : (isTablet ? 13.0 : 14.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      decoration: BoxDecoration(
        color: project.status.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: project.status.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isMobile ? 6 : 8,
            height: isMobile ? 6 : 8,
            decoration: BoxDecoration(
              color: project.status.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            project.status.label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: project.status.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    return Wrap(
      spacing: isMobile ? 12 : 16,
      runSpacing: 12,
      alignment: isMobile ? WrapAlignment.start : WrapAlignment.start,
      children: [
        if (project.liveUrl != null || project.playStoreUrl != null)
          PrimaryButton(
            text: project.primaryLinkLabel,
            icon: Icons.open_in_new_rounded,
            onPressed: () => UrlLauncherUtils.launchURL(project.primaryLink!),
            width: isMobile ? double.infinity : null,
          ),
        if (project.githubUrl != null)
          SecondaryButton(
            text: 'View on GitHub',
            icon: FontAwesomeIcons.github,
            onPressed: () => UrlLauncherUtils.launchURL(project.githubUrl!),
            width: isMobile ? double.infinity : null,
          ),
        if (project.pubDevUrl != null)
          SecondaryButton(
            text: 'View on pub.dev',
            icon: Icons.inventory_2_rounded,
            onPressed: () => UrlLauncherUtils.launchURL(project.pubDevUrl!),
            width: isMobile ? double.infinity : null,
          ),
      ],
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: _buildMockupColumn(context, isMobile: false, isTablet: false),
        ),

        const SizedBox(width: 80),

        Expanded(
          flex: 6,
          child: _buildDetailsColumn(context, isMobile: false, isTablet: false),
        ),
      ],
    );
  }

  Widget _buildTabletContent(BuildContext context) {
    return Column(
      children: [
        _buildMockupColumn(context, isMobile: false, isTablet: true),

        const SizedBox(height: 60),

        _buildDetailsColumn(context, isMobile: false, isTablet: true),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      children: [
        _buildMockupColumn(context, isMobile: true, isTablet: false),

        const SizedBox(height: 48),

        _buildDetailsColumn(context, isMobile: true, isTablet: false),
      ],
    );
  }

  Widget _buildMockupColumn(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    return Center(
      child: PhoneMockupLarge(
        imagePath: project.mockupImage,
        accentColor: project.accentColor,
        screenshots: project.screenshots,
      ),
    );
  }

  Widget _buildDetailsColumn(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          context,
          title: 'Technologies Used',
          icon: Icons.code_rounded,
          isMobile: isMobile,
          isTablet: isTablet,
          child: Wrap(
            spacing: isMobile ? 8 : (isTablet ? 10 : 12),
            runSpacing: isMobile ? 8 : (isTablet ? 10 : 12),
            children: project.technologies
                .map((tech) => TechBadge.custom(tech))
                .toList(),
          ),
        ),

        SizedBox(height: isMobile ? 32 : (isTablet ? 36 : 40)),

        _buildSection(
          context,
          title: 'About This Project',
          icon: Icons.info_rounded,
          isMobile: isMobile,
          isTablet: isTablet,
          child: Text(
            project.fullDescription,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.8,
              fontSize: isMobile ? 15 : (isTablet ? 16 : 17),
            ),
          ),
        ),

        if (project.features.isNotEmpty) ...[
          SizedBox(height: isMobile ? 32 : (isTablet ? 36 : 40)),
          _buildSection(
            context,
            title: 'Key Features',
            icon: Icons.star_rounded,
            isMobile: isMobile,
            isTablet: isTablet,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: project.features
                  .map(
                    (feature) => _buildBulletPoint(
                      context,
                      feature,
                      isMobile: isMobile,
                      isTablet: isTablet,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        if (project.challenges.isNotEmpty) ...[
          SizedBox(height: isMobile ? 32 : (isTablet ? 36 : 40)),
          _buildSection(
            context,
            title: 'Challenges Overcome',
            icon: Icons.psychology_rounded,
            isMobile: isMobile,
            isTablet: isTablet,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: project.challenges
                  .map(
                    (challenge) => _buildBulletPoint(
                      context,
                      challenge,
                      isMobile: isMobile,
                      isTablet: isTablet,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],

        if (project.impact != null) ...[
          SizedBox(height: isMobile ? 32 : (isTablet ? 36 : 40)),
          _buildSection(
            context,
            title: 'Impact',
            icon: Icons.trending_up_rounded,
            isMobile: isMobile,
            isTablet: isTablet,
            child: _buildImpactCard(
              context,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
    required bool isMobile,
    required bool isTablet,
  }) {
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: isMobile ? 20 : (isTablet ? 22 : 24),
              color: project.accentColor,
            ),
            SizedBox(width: isMobile ? 8 : (isTablet ? 10 : 12)),
            Text(
              title,
              style:
                  (isMobile
                          ? textTheme.titleMedium
                          : (isTablet
                                ? textTheme.titleLarge
                                : textTheme.titleLarge))
                      ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 14 : (isTablet ? 16 : 18)),
        child,
      ],
    );
  }

  Widget _buildBulletPoint(
    BuildContext context,
    String text, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 10 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: isMobile ? 6 : 8),
            width: isMobile ? 5 : 6,
            height: isMobile ? 5 : 6,
            decoration: BoxDecoration(
              color: project.accentColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
                fontSize: isMobile ? 14 : (isTablet ? 15 : 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactCard(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : (isTablet ? 18 : 20)),
      decoration: BoxDecoration(
        color: project.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(isMobile ? 14 : 16),
        border: Border.all(
          color: project.accentColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.emoji_events_rounded,
            color: project.accentColor,
            size: isMobile ? 24 : (isTablet ? 26 : 28),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Text(
              project.impact!,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                fontSize: isMobile ? 15 : (isTablet ? 16 : 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherProjects(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final otherProjects = ProjectsData.allProjects
        .where((p) => p.id != project.id)
        .take(isMobile ? 2 : 3)
        .toList();

    if (otherProjects.isEmpty) return const SizedBox.shrink();

    final isDark = context.isDarkMode;
    final horizontalPadding = context.horizontalPadding;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 40 : (isTablet ? 50 : 60),
      ),
      color: isDark ? AppColors.darkBgSecondary : AppColors.lightBgSecondary,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Column(
          children: [
            Text(
              'Other Projects',
              style:
                  (isMobile
                          ? context.textTheme.titleLarge
                          : context.textTheme.headlineSmall)
                      ?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: isMobile ? 24 : 32),
            Wrap(
              spacing: isMobile ? 12 : 16,
              runSpacing: isMobile ? 12 : 16,
              alignment: WrapAlignment.center,
              children: otherProjects.map((p) {
                return _OtherProjectChip(
                  project: p,
                  isMobile: isMobile,
                  isTablet: isTablet,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isMobile;

  const _BackButton({required this.onPressed, required this.isMobile});

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 14 : 16,
            vertical: widget.isMobile ? 8 : 10,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? colorScheme.primary.withValues(alpha: 0.1)
                : (isDark ? AppColors.darkCard : AppColors.lightCard),
            borderRadius: BorderRadius.circular(30),
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
                Icons.arrow_back_rounded,
                size: widget.isMobile ? 16 : 18,
                color: _isHovered
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Back to Projects',
                style: TextStyle(
                  fontSize: widget.isMobile ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtherProjectChip extends StatefulWidget {
  final Project project;
  final bool isMobile;
  final bool isTablet;

  const _OtherProjectChip({
    required this.project,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  State<_OtherProjectChip> createState() => _OtherProjectChipState();
}

class _OtherProjectChipState extends State<_OtherProjectChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(RouteNames.projectDetail(project.slug)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 16 : (widget.isTablet ? 18 : 20),
            vertical: widget.isMobile ? 12 : 14,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? project.accentColor.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: project.accentColor.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                project.category.icon,
                size: widget.isMobile ? 16 : 18,
                color: _isHovered
                    ? project.accentColor
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: widget.isMobile
                      ? 150
                      : (widget.isTablet ? 180 : 220),
                ),
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontSize: widget.isMobile ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: _isHovered
                        ? project.accentColor
                        : colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: widget.isMobile ? 14 : 16,
                color: _isHovered
                    ? project.accentColor
                    : colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
