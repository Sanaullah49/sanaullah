import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../data/testimonials_data.dart';

export 'testimonial_stats.dart' show TestimonialStatsInline;

class TestimonialStatsRow extends StatelessWidget {
  const TestimonialStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final stats = TestimonialsData.stats;

    final items = [
      _StatItem(
        icon: Icons.star_rounded,
        value: stats.averageRating.toString(),
        label: 'Average Rating',
        suffix: '/5',
        color: AppColors.warning,
      ),
      _StatItem(
        icon: Icons.reviews_rounded,
        value: stats.totalReviews.toString(),
        label: 'Total Reviews',
        suffix: '+',
        color: AppColors.primary,
      ),
      _StatItem(
        icon: Icons.thumb_up_rounded,
        value: stats.satisfactionRate.toString(),
        label: 'Satisfaction',
        suffix: '%',
        color: AppColors.success,
      ),
      _StatItem(
        icon: Icons.emoji_events_rounded,
        value: stats.fiveStarCount.toString(),
        label: '5-Star Reviews',
        color: AppColors.accent,
      ),
    ];

    if (isMobile) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: items
            .map(
              (item) => SizedBox(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                child: _TestimonialStatCard(stat: item),
              ),
            )
            .toList(),
      );
    }

    return Row(
      children: items
          .map(
            (item) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _TestimonialStatCard(stat: item),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _StatItem {
  final IconData icon;
  final String value;
  final String label;
  final String? suffix;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    this.suffix,
    required this.color,
  });
}

class _TestimonialStatCard extends StatefulWidget {
  final _StatItem stat;

  const _TestimonialStatCard({required this.stat});

  @override
  State<_TestimonialStatCard> createState() => _TestimonialStatCardState();
}

class _TestimonialStatCardState extends State<_TestimonialStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final stat = widget.stat;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? stat.color.withValues(alpha: 0.5)
                : colorScheme.outline.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: stat.color.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _isHovered ? -5.0 : 0.0, 0.0, 0.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: stat.color.withValues(alpha: _isHovered ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(stat.icon, size: 24, color: stat.color),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stat.value,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: _isHovered ? stat.color : colorScheme.onSurface,
                  ),
                ),
                if (stat.suffix != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      stat.suffix!,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: stat.color,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              stat.label,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TestimonialStatsInline extends StatelessWidget {
  const TestimonialStatsInline({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final stats = TestimonialsData.stats;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(Icons.star_rounded, size: 18, color: AppColors.warning),
            const SizedBox(width: 4),
            Text(
              '${stats.averageRating}',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        _buildDivider(context),

        Text(
          '${stats.totalReviews}+ Reviews',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),

        _buildDivider(context),

        Row(
          children: [
            Icon(Icons.verified_rounded, size: 16, color: AppColors.success),
            const SizedBox(width: 4),
            Text(
              '${stats.satisfactionRate}% Satisfied',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: context.colorScheme.outline.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}
