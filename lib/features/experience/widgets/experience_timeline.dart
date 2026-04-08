import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final useMobileLayout = screenWidth < 760;
    final useTabletLayout = screenWidth >= 760 && screenWidth < 1100;

    if (useMobileLayout) {
      return _buildMobileLayout(context);
    } else if (useTabletLayout) {
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

    return Container(
      margin: EdgeInsets.only(
        bottom: widget.isLast ? 0 : (isSmallMobile ? 18 : 22),
      ),
      child: _buildMobileContentCard(context),
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            experience.accentColor.withValues(alpha: isDark ? 0.1 : 0.08),
            isDark ? AppColors.darkCard : AppColors.lightCard,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: experience.accentColor.withValues(alpha: 0.18),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: experience.accentColor.withValues(
              alpha: isDark ? 0.08 : 0.06,
            ),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.26 : 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildMobileMetaChip(
                context,
                icon: Icons.calendar_today_rounded,
                label: experience.dateRange,
                color: experience.accentColor,
              ),
              _buildMobileMetaChip(
                context,
                icon: Icons.access_time_rounded,
                label: experience.duration,
                color: experience.accentColor.withValues(alpha: 0.9),
              ),
              if (experience.isCurrent)
                _CurrentBadge(color: experience.accentColor, small: true),
            ],
          ),

          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              final stackedHeader = constraints.maxWidth < 280;

              final companyBlock = Column(
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
              );

              final companyIcon = Container(
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
              );

              if (stackedHeader) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    companyIcon,
                    const SizedBox(height: 14),
                    companyBlock,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  companyIcon,
                  const SizedBox(width: 12),
                  Expanded(child: companyBlock),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 10,
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

          const SizedBox(height: 14),

          Text(
            experience.description,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: isSmallMobile ? 13 : 14,
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
            maxLines: _isExpanded ? null : 3,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          Text(
            'Stack used',
            style: textTheme.labelMedium?.copyWith(
              color: experience.accentColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.technologies
                .take(_isExpanded ? experience.technologies.length : 4)
                .map(
                  (tech) =>
                      _buildTechChip(context, tech, experience.accentColor),
                )
                .toList(),
          ),

          if (experience.achievements.isNotEmpty) ...[
            const SizedBox(height: 14),
            TextButton.icon(
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
                _isExpanded ? 'Hide details' : 'View impact',
                style: TextStyle(
                  color: experience.accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: isSmallMobile ? 13 : 14,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                backgroundColor: experience.accentColor.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: _buildMobileExpandedContent(context),
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

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isSmallMobile ? 190 : 220),
      child: Container(
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
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isSmallMobile ? 12 : 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
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
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: experience.accentColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: experience.accentColor.withValues(alpha: 0.14),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (experience.achievements.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      size: isSmallMobile ? 18 : 20,
                      color: experience.accentColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Selected impact',
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: isSmallMobile ? 15 : 16,
                        fontWeight: FontWeight.w700,
                        color: experience.accentColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ...experience.achievements.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 18,
                          height: 18,
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
                                fontSize: 9,
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
            ],
          ),
        ),
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
        transform: Matrix4.translationValues(_isHovered ? 8.0 : 0.0, 0.0, 0.0),
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

            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildDesktopMetaItem(
                  context,
                  icon: Icons.location_on_outlined,
                  label: experience.location,
                ),
                _buildDesktopMetaItem(
                  context,
                  icon: Icons.work_outline_rounded,
                  label: experience.type,
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
              technologies: experience.technologies.take(4).toList(),
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

  Widget _buildDesktopMetaItem(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 220),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
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
