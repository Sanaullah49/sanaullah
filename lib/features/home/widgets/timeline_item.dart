import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class TimelineItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String period;
  final String location;
  final List<String> points;
  final bool isFirst;
  final bool isLast;
  final Color? accentColor;
  final IconData? icon;

  const TimelineItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.period,
    required this.location,
    required this.points,
    this.isFirst = false,
    this.isLast = false,
    this.accentColor,
    this.icon,
  });

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.accentColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimelineLine(context, accentColor),

            const SizedBox(width: 24),

            Expanded(child: _buildContentCard(context, accentColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineLine(BuildContext context, Color accentColor) {
    final colorScheme = context.colorScheme;

    return SizedBox(
      width: 24,
      child: Column(
        children: [
          if (!widget.isFirst)
            Container(
              width: 2,
              height: 20,
              color: colorScheme.outline.withValues(alpha: 0.3),
            ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered
                  ? accentColor
                  : accentColor.withValues(alpha: 0.2),
              border: Border.all(color: accentColor, width: 2),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.4),
                        blurRadius: 12,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: widget.icon != null
                  ? Icon(
                      widget.icon,
                      size: 12,
                      color: _isHovered ? Colors.white : accentColor,
                    )
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isHovered ? Colors.white : accentColor,
                      ),
                    ),
            ),
          ),

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

  Widget _buildContentCard(BuildContext context, Color accentColor) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isHovered
              ? accentColor.withValues(alpha: 0.4)
              : colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _isHovered
                ? accentColor.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: isDark ? 0.15 : 0.03),
            blurRadius: _isHovered ? 25 : 10,
            offset: const Offset(0, 5),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _isHovered ? accentColor : colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.period,
                  style: textTheme.labelSmall?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                widget.location,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          if (widget.points.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            ...widget.points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        point,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.6,
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
    );
  }
}
