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

    return isMobile
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
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

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTimelineDot(context),
            const SizedBox(width: 16),
            _buildMobileDateInfo(context),
          ],
        ),

        Row(
          children: [
            const SizedBox(width: 12),
            if (!widget.isLast)
              Container(
                width: 2,
                height: 20,
                color: context.colorScheme.outline.withValues(alpha: 0.3),
              ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: _buildContentCard(context),
        ),

        if (!widget.isLast) const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDateColumn(BuildContext context) {
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
              fontWeight: FontWeight.w600,
              color: _isHovered
                  ? experience.accentColor
                  : colorScheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 6),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: experience.accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              experience.duration,
              style: TextStyle(
                fontSize: 11,
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

  Widget _buildMobileDateInfo(BuildContext context) {
    final experience = widget.experience;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                experience.dateRange,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: experience.accentColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• ${experience.duration}',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (experience.isCurrent) ...[
                const SizedBox(width: 8),
                _CurrentBadge(color: experience.accentColor, small: true),
              ],
            ],
          ),
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
              secondChild: _buildExpandedContent(context),
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

  Widget _buildExpandedContent(BuildContext context) {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 8 : 10,
            vertical: widget.small ? 3 : 4,
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
                width: widget.small ? 6 : 8,
                height: widget.small ? 6 : 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: widget.small ? 4 : 6),
              Text(
                'Current',
                style: TextStyle(
                  fontSize: widget.small ? 9 : 10,
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
