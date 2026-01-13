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
    final isMobile = context.isMobile;
    final isDark = context.isDarkMode;

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
              const SectionTitle(
                tag: 'CAREER',
                title: 'Work Experience',
                subtitle:
                    'My professional journey building impactful mobile applications across various industries',
              ),

              SizedBox(height: isMobile ? 32 : 48),

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

              SizedBox(height: isMobile ? 48 : 64),

              ExperienceTimeline(
                experiences: ExperienceData.experiences,
                isVisible: _isVisible,
              ),

              SizedBox(height: isMobile ? 48 : 64),

              _buildEducationSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
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
            Row(
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
                Icon(
                  Icons.school_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
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
            ),

            const SizedBox(height: 32),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: _EducationCard(education: education),
            ),
          ],
        ),
      ),
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
    final textTheme = context.textTheme;
    final education = widget.education;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
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
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: education.accentColor.withOpacity(
                  _isHovered ? 0.2 : 0.1,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: education.accentColor.withOpacity(
                    _isHovered ? 0.5 : 0.2,
                  ),
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
        ),
      ),
    );
  }

  Widget _buildMetaChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
