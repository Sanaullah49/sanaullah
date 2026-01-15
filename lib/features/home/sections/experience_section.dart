import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../experience/data/experience_data.dart';
import '../../experience/widgets/experience_stats.dart';
import '../../experience/widgets/experience_timeline.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return VisibilityDetector(
      key: const Key('experience-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        color: isDark ? AppColors.darkBgSecondary : AppColors.lightBgSecondary,
        child: SectionWrapper(
          sectionId: 'experience',
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              SectionTitle(
                tag: 'CAREER',
                title: 'Work Experience',
                subtitle: isSmallMobile
                    ? 'My professional journey'
                    : 'My professional journey building impactful mobile applications across various industries',
              ),

              SizedBox(
                height: context.responsive(mobile: 24, tablet: 36, desktop: 48),
              ),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isVisible ? 1.0 : 0.0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 600),
                  offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                  curve: Curves.easeOutCubic,
                  child: const ExperienceStats(),
                ),
              ),

              SizedBox(
                height: context.responsive(mobile: 32, tablet: 48, desktop: 64),
              ),

              ExperienceTimeline(
                experiences: ExperienceData.experiences,
                isVisible: _isVisible,
              ),

              SizedBox(
                height: context.responsive(mobile: 32, tablet: 48, desktop: 64),
              ),

              _buildEducationSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    final isMobile = context.isMobile;
    final education = ExperienceData.education.first;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 800),
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        curve: Curves.easeOutCubic,
        child: Column(
          children: [
            _buildEducationHeader(context),

            SizedBox(height: isMobile ? 20 : 32),

            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.responsive(
                  mobile: double.infinity,
                  tablet: 700,
                  desktop: 800,
                ),
              ),
              child: _EducationCard(education: education),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationHeader(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isMobile = context.isMobile;

    if (isMobile) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_rounded, color: colorScheme.primary, size: 18),
          const SizedBox(width: 8),
          Text(
            'EDUCATION',
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, colorScheme.primary],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.school_rounded, color: colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          'EDUCATION',
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }
}

class _EducationCard extends StatefulWidget {
  final dynamic education;

  const _EducationCard({required this.education});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final education = widget.education;
    final isMobile = context.isMobile;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(
          context.responsive(
            mobile: isSmallMobile ? 16 : 20,
            tablet: 24,
            desktop: 28,
          ),
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(
            context.responsive(mobile: 16, tablet: 18, desktop: 20),
          ),
          border: Border.all(
            color: _isHovered
                ? education.accentColor.withOpacity(0.5)
                : colorScheme.outline.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? education.accentColor.withOpacity(0.1)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: _isHovered ? 30 : 15,
              offset: Offset(0, _isHovered ? 10 : 5),
            ),
          ],
        ),
        child: isMobile
            ? _buildMobileLayout(context, education)
            : _buildDesktopLayout(context, education),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, dynamic education) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: isSmallMobile ? 56 : 64,
          height: isSmallMobile ? 56 : 64,
          decoration: BoxDecoration(
            color: education.accentColor.withOpacity(_isHovered ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: education.accentColor.withOpacity(_isHovered ? 0.5 : 0.2),
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.school_rounded,
              size: isSmallMobile ? 24 : 28,
              color: education.accentColor,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Column(
          children: [
            Text(
              education.fullDegree,
              style: textTheme.titleMedium?.copyWith(
                fontSize: isSmallMobile ? 15 : null,
                fontWeight: FontWeight.w600,
                color: _isHovered
                    ? education.accentColor
                    : colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              education.institution,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: isSmallMobile ? 13 : null,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildMetaChip(
                  context,
                  icon: Icons.calendar_today_rounded,
                  label: education.dateRange,
                  color: education.accentColor,
                ),
                if (education.gpa != null)
                  _buildMetaChip(
                    context,
                    icon: Icons.star_rounded,
                    label: 'CGPA: ${education.gpa}',
                    color: education.accentColor,
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, dynamic education) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: education.accentColor.withOpacity(_isHovered ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: education.accentColor.withOpacity(_isHovered ? 0.5 : 0.2),
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.school_rounded,
              size: 28,
              color: education.accentColor,
            ),
          ),
        ),

        const SizedBox(width: 24),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                education.fullDegree,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? education.accentColor
                      : colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                education.institution,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _buildMetaChip(
                    context,
                    icon: Icons.calendar_today_rounded,
                    label: education.dateRange,
                    color: education.accentColor,
                  ),

                  const SizedBox(width: 12),

                  if (education.gpa != null)
                    _buildMetaChip(
                      context,
                      icon: Icons.star_rounded,
                      label: 'CGPA: ${education.gpa}',
                      color: education.accentColor,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetaChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallMobile ? 8 : 10,
        vertical: isSmallMobile ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmallMobile ? 11 : 12, color: color),
          SizedBox(width: isSmallMobile ? 4 : 6),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallMobile ? 10 : 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
