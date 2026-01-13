import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../data/open_source_data.dart';
import '../models/github_models.dart';

class ContributionGraph extends StatefulWidget {
  final List<ContributionDay> contributions;
  final bool isVisible;

  const ContributionGraph({
    super.key,
    required this.contributions,
    this.isVisible = true,
  });

  @override
  State<ContributionGraph> createState() => _ContributionGraphState();
}

class _ContributionGraphState extends State<ContributionGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(covariant ContributionGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${OpenSourceData.yearlyContributions} contributions',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'in the last year',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  _buildLegend(context),
                ],
              ),

              SizedBox(height: isMobile ? 16 : 24),

              SizedBox(
                height: isMobile ? 100 : 120,
                child: _buildGraph(context),
              ),

              const SizedBox(height: 12),

              _buildMonthLabels(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegend(BuildContext context) {
    final isDark = context.isDarkMode;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Less',
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 4),
        ...ContributionLevel.values.map((level) {
          return Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: level.getColor(isDark),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
        const SizedBox(width: 4),
        Text(
          'More',
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildGraph(BuildContext context) {
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;
    final contributions = widget.contributions;

    final weeks = <List<ContributionDay>>[];
    var currentWeek = <ContributionDay>[];

    for (var i = 0; i < contributions.length; i++) {
      currentWeek.add(contributions[i]);
      if (currentWeek.length == 7) {
        weeks.add(currentWeek);
        currentWeek = [];
      }
    }
    if (currentWeek.isNotEmpty) {
      weeks.add(currentWeek);
    }

    final displayWeeks = isMobile
        ? weeks.skip(weeks.length - 26).toList()
        : weeks;
    final cellSize = isMobile ? 10.0 : 12.0;
    final cellGap = 3.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(displayWeeks.length, (weekIndex) {
              final week = displayWeeks[weekIndex];
              final animationProgress = _animation.value;
              final weekProgress =
                  (animationProgress * displayWeeks.length - weekIndex).clamp(
                    0.0,
                    1.0,
                  );

              return Padding(
                padding: EdgeInsets.only(right: cellGap),
                child: Column(
                  children: List.generate(7, (dayIndex) {
                    if (dayIndex >= week.length) {
                      return SizedBox(
                        width: cellSize,
                        height: cellSize + cellGap,
                      );
                    }

                    final day = week[dayIndex];
                    return Padding(
                      padding: EdgeInsets.only(bottom: cellGap),
                      child: Opacity(
                        opacity: weekProgress,
                        child: Transform.scale(
                          scale: weekProgress,
                          child: _ContributionCell(
                            day: day,
                            size: cellSize,
                            isDark: isDark,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildMonthLabels(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isMobile = context.isMobile;

    final months = isMobile
        ? ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb']
        : [
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
            'Jan',
            'Feb',
          ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: months.map((month) {
        return Text(
          month,
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 10,
          ),
        );
      }).toList(),
    );
  }
}

class _ContributionCell extends StatefulWidget {
  final ContributionDay day;
  final double size;
  final bool isDark;

  const _ContributionCell({
    required this.day,
    required this.size,
    required this.isDark,
  });

  @override
  State<_ContributionCell> createState() => _ContributionCellState();
}

class _ContributionCellState extends State<_ContributionCell> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message:
            '${widget.day.count} contributions on ${_formatDate(widget.day.date)}',
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.day.level.getColor(widget.isDark),
            borderRadius: BorderRadius.circular(2),
            border: _isHovered
                ? Border.all(color: AppColors.primary, width: 1)
                : null,
          ),
          transform: Matrix4.identity()
            ..scaleByDouble(_isHovered ? 1.2 : 1.0, 0.0, 0.0, 0.0),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
