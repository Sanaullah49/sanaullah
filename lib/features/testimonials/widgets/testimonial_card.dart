import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../model/testimonial_model.dart';

class TestimonialCard extends StatefulWidget {
  final Testimonial testimonial;
  final bool isActive;
  final VoidCallback? onTap;

  const TestimonialCard({
    super.key,
    required this.testimonial,
    this.isActive = false,
    this.onTap,
  });

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final testimonial = widget.testimonial;
    final accentColor = testimonial.accentColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.isActive || _isHovered
                  ? accentColor.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.1),
              width: widget.isActive ? 2 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.isActive || _isHovered
                    ? accentColor.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                blurRadius: widget.isActive || _isHovered ? 30 : 15,
                offset: Offset(0, widget.isActive || _isHovered ? 12 : 6),
              ),
            ],
          ),
          transform: Matrix4.identity()
            ..translateByDouble(0.0, _isHovered ? -6.0 : 0.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.format_quote_rounded,
                        size: 24,
                        color: accentColor,
                      ),
                    ),
                  ),
                  _buildRating(context, testimonial.rating),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Text(
                  '"${testimonial.content}"',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.7,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 24),

              Container(
                height: 1,
                color: colorScheme.outline.withValues(alpha: 0.1),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  _buildAvatar(context, testimonial),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          testimonial.displayName,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${testimonial.displayRole} at ${testimonial.company}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  _buildSourceBadge(context, testimonial.source),
                ],
              ),

              if (testimonial.projectWorkedOn != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.folder_rounded, size: 12, color: accentColor),
                      const SizedBox(width: 6),
                      Text(
                        testimonial.projectWorkedOn!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, double rating) {
    final fullStars = rating.floor();
    final hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(fullStars, (index) {
          return const Icon(
            Icons.star_rounded,
            size: 18,
            color: AppColors.warning,
          );
        }),
        if (hasHalfStar)
          const Icon(
            Icons.star_half_rounded,
            size: 18,
            color: AppColors.warning,
          ),
        ...List.generate(5 - fullStars - (hasHalfStar ? 1 : 0), (index) {
          return Icon(
            Icons.star_outline_rounded,
            size: 18,
            color: AppColors.warning.withValues(alpha: 0.3),
          );
        }),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, Testimonial testimonial) {
    final accentColor = testimonial.accentColor ?? AppColors.primary;

    if (testimonial.avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 22,
        backgroundImage: NetworkImage(testimonial.avatarUrl),
        backgroundColor: accentColor.withValues(alpha: 0.1),
      );
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accentColor, accentColor.withValues(alpha: 0.7)],
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          testimonial.initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSourceBadge(BuildContext context, TestimonialSource source) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: source.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(source.icon, size: 12, color: source.color),
          const SizedBox(width: 4),
          Text(
            source.label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: source.color,
            ),
          ),
        ],
      ),
    );
  }
}

class TestimonialCardCompact extends StatefulWidget {
  final Testimonial testimonial;

  const TestimonialCardCompact({super.key, required this.testimonial});

  @override
  State<TestimonialCardCompact> createState() => _TestimonialCardCompactState();
}

class _TestimonialCardCompactState extends State<TestimonialCardCompact> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final testimonial = widget.testimonial;
    final accentColor = testimonial.accentColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? accentColor.withValues(alpha: 0.4)
                : colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < testimonial.rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  size: 14,
                  color: AppColors.warning,
                );
              }),
            ),

            const SizedBox(height: 12),

            Text(
              '"${testimonial.content}"',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accentColor, accentColor.withValues(alpha: 0.7)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      testimonial.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testimonial.displayName,
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        testimonial.company,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
