import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/tech_badge.dart';
import '../models/experience_model.dart';

class ExperienceTimeline extends StatelessWidget {
  final List<Experience> experiences;
  final bool isVisible;

  const ExperienceTimeline({
    super.key,
    required this.experiences,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (index) {
        final experience = experiences[index];
        final isFirst = index == 0;
        final isLast = index == experiences.length - 1;

        return AnimatedOpacity(
          duration: Duration(milliseconds: 600 + (index * 150)),
          opacity: isVisible ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: Duration(milliseconds: 600 + (index * 150)),
            offset: isVisible ? Offset.zero : const Offset(-0.1, 0),
            curve: Curves.easeOutCubic,
            child: ExperienceTimelineItem(
              experience: experience,
              isFirst: isFirst,
              isLast: isLast,
            ),
          ),
        );
      }),
    );
  }
}

class ExperienceTimelineItem extends StatefulWidget {
  final Experience experience;
  final bool isFirst;
  final bool isLast;

  const ExperienceTimelineItem({
    super.key,
    required this.experience,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  State<ExperienceTimelineItem> createState() => _ExperienceTimelineItemState();
}

class _ExperienceTimelineItemState extends State<ExperienceTimelineItem> {
  bool _isHovered = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    if (isMobile) {
      return _buildMobileLayout(context);
    } else if (isTablet) {
      return _buildTabletLayout(context);
    } else {
      return _buildDesktopLayout(context);
    }
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 180, child: _buildDateColumn(context)),

          _buildTimelineLine(context),

          const SizedBox(width: 32),

          Expanded(child: _buildContentCard(context)),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: _buildDateColumn(context, compact: true)),

          _buildTimelineLine(context),

          const SizedBox(width: 20),

          Expanded(child: _buildContentCard(context)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final isSmallMobile = MediaQuery.of(context).size.width < 380;
    final experience = widget.experience;

    return Container(
      margin: EdgeInsets.only(
        bottom: widget.isLast ? 0 : (isSmallMobile ? 24 : 32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildMobileTimelineDot(context),

              const SizedBox(width: 12),

              Expanded(child: _buildMobileDateBadge(context)),
            ],
          ),

          const SizedBox(height: 16),

          _buildMobileContentCard(context),

          if (!widget.isLast)
            Padding(
              padding: const EdgeInsets.only(left: 11, top: 16),
              child: Container(
                width: 3,
                height: 24,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      experience.accentColor.withValues(alpha: 0.3),
                      experience.accentColor.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileTimelineDot(BuildContext context) {
    final experience = widget.experience;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                experience.accentColor.withValues(alpha: 0.2),
                experience.accentColor.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: experience.accentColor.withValues(alpha: 0.15),
            border: Border.all(color: experience.accentColor, width: 3),
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: experience.accentColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileDateBadge(BuildContext context) {
    final experience = widget.experience;
    final textTheme = context.textTheme;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallMobile ? 12 : 16,
        vertical: isSmallMobile ? 8 : 10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            experience.accentColor.withValues(alpha: 0.1),
            experience.accentColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: experience.accentColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: isSmallMobile ? 12 : 14,
                color: experience.accentColor,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  experience.dateRange,
                  style: textTheme.labelLarge?.copyWith(
                    fontSize: isSmallMobile ? 12 : 13,
                    fontWeight: FontWeight.w700,
                    color: experience.accentColor,
                  ),
                ),
              ),
              if (experience.isCurrent)
                _CurrentBadge(color: experience.accentColor, small: true),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: isSmallMobile ? 11 : 12,
                color: experience.accentColor.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 6),
              Text(
                experience.duration,
                style: textTheme.labelSmall?.copyWith(
                  fontSize: isSmallMobile ? 11 : 12,
                  fontWeight: FontWeight.w600,
                  color: experience.accentColor.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileContentCard(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final experience = widget.experience;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return Container(
      padding: EdgeInsets.all(isSmallMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: experience.accentColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: experience.accentColor.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isSmallMobile ? 48 : 56,
                height: isSmallMobile ? 48 : 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      experience.accentColor.withValues(alpha: 0.2),
                      experience.accentColor.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: experience.accentColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.business_rounded,
                    size: isSmallMobile ? 24 : 28,
                    color: experience.accentColor,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.title,
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: isSmallMobile ? 17 : 19,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience.company,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: isSmallMobile ? 14 : 15,
                        color: experience.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildMobileMetaChip(
                context,
                icon: Icons.location_on_rounded,
                label: experience.location,
                color: colorScheme.primary,
              ),
              _buildMobileMetaChip(
                context,
                icon: Icons.work_rounded,
                label: experience.type,
                color: colorScheme.secondary,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  experience.accentColor.withValues(alpha: 0.1),
                  experience.accentColor.withValues(alpha: 0.3),
                  experience.accentColor.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            experience.description,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: isSmallMobile ? 13 : 14,
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: _buildMobileExpandedContent(context),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.technologies
                .take(isSmallMobile ? 5 : 6)
                .map(
                  (tech) =>
                      _buildTechChip(context, tech, experience.accentColor),
                )
                .toList(),
          ),

          const SizedBox(height: 12),

          Center(
            child: TextButton.icon(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              icon: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _isExpanded ? 0.5 : 0,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: experience.accentColor,
                ),
              ),
              label: Text(
                _isExpanded ? 'Show Less' : 'Show More',
                style: TextStyle(
                  color: experience.accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallMobile ? 13 : 14,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                backgroundColor: experience.accentColor.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMetaChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallMobile ? 10 : 12,
        vertical: isSmallMobile ? 6 : 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmallMobile ? 14 : 15, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallMobile ? 12 : 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(BuildContext context, String tech, Color accentColor) {
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallMobile ? 10 : 12,
        vertical: isSmallMobile ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withValues(alpha: 0.2), width: 1),
      ),
      child: Text(
        tech,
        style: TextStyle(
          fontSize: isSmallMobile ? 11 : 12,
          fontWeight: FontWeight.w600,
          color: accentColor,
        ),
      ),
    );
  }

  Widget _buildMobileExpandedContent(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final experience = widget.experience;
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                experience.accentColor.withValues(alpha: 0.1),
                experience.accentColor.withValues(alpha: 0.3),
                experience.accentColor.withValues(alpha: 0.1),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        if (experience.achievements.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: experience.accentColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: experience.accentColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: experience.accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.emoji_events_rounded,
                        size: isSmallMobile ? 18 : 20,
                        color: experience.accentColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Key Achievements',
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: isSmallMobile ? 15 : 16,
                        fontWeight: FontWeight.w700,
                        color: experience.accentColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...experience.achievements.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: experience.accentColor.withValues(
                              alpha: 0.15,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: experience.accentColor,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: experience.accentColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: isSmallMobile ? 13 : 14,
                              color: colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDateColumn(BuildContext context, {bool compact = false}) {
    final experience = widget.experience;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.only(top: widget.isFirst ? 0 : 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            experience.dateRange,
            style: textTheme.titleSmall?.copyWith(
              fontSize: compact ? 13 : null,
              fontWeight: FontWeight.w600,
              color: _isHovered
                  ? experience.accentColor
                  : colorScheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 6),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 8 : 10,
              vertical: compact ? 3 : 4,
            ),
            decoration: BoxDecoration(
              color: experience.accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              experience.duration,
              style: TextStyle(
                fontSize: compact ? 10 : 11,
                fontWeight: FontWeight.w600,
                color: experience.accentColor,
              ),
            ),
          ),

          if (experience.isCurrent) ...[
            const SizedBox(height: 8),
            _CurrentBadge(color: experience.accentColor),
          ],
        ],
      ),
    );
  }

  Widget _buildTimelineLine(BuildContext context) {
    final colorScheme = context.colorScheme;

    return SizedBox(
      width: 48,
      child: Column(
        children: [
          if (!widget.isFirst)
            Container(
              width: 2,
              height: 20,
              color: colorScheme.outline.withValues(alpha: 0.3),
            ),

          _buildTimelineDot(context),

          if (!widget.isLast)
            Expanded(
              child: Container(
                width: 2,
                color: colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot(BuildContext context) {
    final experience = widget.experience;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isHovered ? 28 : 24,
      height: _isHovered ? 28 : 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _isHovered
            ? experience.accentColor
            : experience.accentColor.withValues(alpha: 0.2),
        border: Border.all(color: experience.accentColor, width: 2.5),
        boxShadow: _isHovered
            ? [
                BoxShadow(
                  color: experience.accentColor.withValues(alpha: 0.4),
                  blurRadius: 12,
                ),
              ]
            : null,
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isHovered ? 10 : 8,
          height: _isHovered ? 10 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered ? Colors.white : experience.accentColor,
          ),
        ),
      ),
    );
  }

  Widget _buildContentCard(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final experience = widget.experience;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? experience.accentColor.withValues(alpha: 0.5)
                : colorScheme.outline.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? experience.accentColor.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: _isHovered ? 30 : 15,
              offset: Offset(0, _isHovered ? 10 : 5),
            ),
          ],
        ),
        transform: Matrix4.identity()..translate(_isHovered ? 8.0 : 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: experience.accentColor.withValues(
                      alpha: _isHovered ? 0.2 : 0.1,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: experience.accentColor.withValues(
                        alpha: _isHovered ? 0.5 : 0.2,
                      ),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.business_rounded,
                      size: 24,
                      color: experience.accentColor,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: _isHovered
                              ? experience.accentColor
                              : colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        experience.company,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  icon: AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _isExpanded ? 0.5 : 0,
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  experience.location,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.work_outline_rounded,
                  size: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  experience.type,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              experience.description,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),

            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: _buildDesktopExpandedContent(context),
            ),

            const SizedBox(height: 20),

            TechBadgeRow(
              technologies: experience.technologies.take(5).toList(),
              spacing: 8,
              runSpacing: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopExpandedContent(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final experience = widget.experience;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Divider(height: 1),
        const SizedBox(height: 20),

        if (experience.achievements.isNotEmpty) ...[
          Row(
            children: [
              Icon(
                Icons.emoji_events_rounded,
                size: 18,
                color: experience.accentColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Key Achievements',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...experience.achievements.map(
            (achievement) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: experience.accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      achievement,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
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
}

class _CurrentBadge extends StatefulWidget {
  final Color color;
  final bool small;

  const _CurrentBadge({required this.color, this.small = false});

  @override
  State<_CurrentBadge> createState() => _CurrentBadgeState();
}

class _CurrentBadgeState extends State<_CurrentBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallMobile = MediaQuery.of(context).size.width < 380;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? (isSmallMobile ? 6 : 8) : 10,
            vertical: widget.small ? (isSmallMobile ? 2 : 3) : 4,
          ),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.success.withValues(
                  alpha: _controller.value * 0.3,
                ),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: widget.small ? (isSmallMobile ? 5 : 6) : 8,
                height: widget.small ? (isSmallMobile ? 5 : 6) : 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: widget.small ? (isSmallMobile ? 3 : 4) : 6),
              Text(
                'Current',
                style: TextStyle(
                  fontSize: widget.small ? (isSmallMobile ? 8 : 9) : 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
