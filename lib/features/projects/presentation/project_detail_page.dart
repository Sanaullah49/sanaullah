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
    return Container(
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
            Text('Project Not Found', style: context.textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text(
              'The project you\'re looking for doesn\'t exist or has been removed.',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
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
    );
  }
}

class _ProjectDetailContent extends StatelessWidget {
  final Project project;

  const _ProjectDetailContent({required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40 : 80,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isMobile
                  ? _buildMobileContent(context)
                  : _buildDesktopContent(context),
            ),
          ),

          _buildOtherProjects(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 40 : 80,
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _BackButton(
              onPressed: () => context.go(RouteNames.projects),
            ),
          ),

          SizedBox(height: isMobile ? 24 : 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryBadge(context),
              const SizedBox(width: 12),
              _buildStatusBadge(context),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            project.title,
            style: context.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              project.shortDescription,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.7,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 32),

          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
          Icon(project.category.icon, size: 16, color: project.category.color),
          const SizedBox(width: 8),
          Text(
            project.category.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: project.category.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: project.status.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            project.status.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: project.status.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        if (project.liveUrl != null || project.playStoreUrl != null)
          PrimaryButton(
            text: project.primaryLinkLabel,
            icon: Icons.open_in_new_rounded,
            onPressed: () => UrlLauncherUtils.launchURL(project.primaryLink!),
          ),
        if (project.githubUrl != null)
          SecondaryButton(
            text: 'View on GitHub',
            icon: FontAwesomeIcons.github,
            onPressed: () => UrlLauncherUtils.launchURL(project.githubUrl!),
          ),
        if (project.pubDevUrl != null)
          SecondaryButton(
            text: 'View on pub.dev',
            icon: Icons.inventory_2_rounded,
            onPressed: () => UrlLauncherUtils.launchURL(project.pubDevUrl!),
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
          child: Center(
            child: PhoneMockupLarge(
              imagePath: project.mockupImage,
              accentColor: project.accentColor,
              screenshots: project.screenshots,
            ),
          ),
        ),

        const SizedBox(width: 80),

        Expanded(flex: 5, child: _buildDetails(context)),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      children: [
        PhoneMockupLarge(
          imagePath: project.mockupImage,
          accentColor: project.accentColor,
          screenshots: project.screenshots,
        ),

        const SizedBox(height: 48),

        _buildDetails(context),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          context,
          title: 'Technologies Used',
          icon: Icons.code_rounded,
          child: TechBadgeRow(
            technologies: project.technologies,
            spacing: 8,
            runSpacing: 8,
          ),
        ),

        const SizedBox(height: 40),

        _buildSection(
          context,
          title: 'About This Project',
          icon: Icons.info_rounded,
          child: Text(
            project.fullDescription,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.8,
            ),
          ),
        ),

        if (project.features.isNotEmpty) ...[
          const SizedBox(height: 40),

          _buildSection(
            context,
            title: 'Key Features',
            icon: Icons.star_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: project.features
                  .map((feature) => _buildBulletPoint(context, feature))
                  .toList(),
            ),
          ),
        ],

        if (project.challenges.isNotEmpty) ...[
          const SizedBox(height: 40),

          _buildSection(
            context,
            title: 'Challenges Overcome',
            icon: Icons.psychology_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: project.challenges
                  .map((challenge) => _buildBulletPoint(context, challenge))
                  .toList(),
            ),
          ),
        ],

        if (project.impact != null) ...[
          const SizedBox(height: 40),

          _buildSection(
            context,
            title: 'Impact',
            icon: Icons.trending_up_rounded,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: project.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
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
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      project.impact!,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
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
  }) {
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 22, color: project.accentColor),
            const SizedBox(width: 10),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: project.accentColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherProjects(BuildContext context) {
    final otherProjects = ProjectsData.allProjects
        .where((p) => p.id != project.id)
        .take(3)
        .toList();

    if (otherProjects.isEmpty) return const SizedBox.shrink();

    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 40 : 60,
      ),
      color: isDark ? AppColors.darkBgSecondary : AppColors.lightBgSecondary,
      child: Column(
        children: [
          Text(
            'Other Projects',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: otherProjects.map((p) {
              return _OtherProjectChip(project: p);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _BackButton({required this.onPressed});

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                size: 18,
                color: _isHovered
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Back to Projects',
                style: TextStyle(
                  fontSize: 14,
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

  const _OtherProjectChip({required this.project});

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                size: 18,
                color: _isHovered
                    ? project.accentColor
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 10),
              Text(
                project.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? project.accentColor
                      : colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
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
