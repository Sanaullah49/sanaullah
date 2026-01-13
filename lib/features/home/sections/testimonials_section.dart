import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../testimonials/data/testimonials_data.dart';
import '../../testimonials/widgets/testimonial_slider.dart';
import '../../testimonials/widgets/testimonial_stats.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isDark = context.isDarkMode;

    return VisibilityDetector(
      key: const Key('testimonials-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        color: isDark ? AppColors.darkBgSecondary : AppColors.lightBgSecondary,
        child: SectionWrapper(
          sectionId: 'testimonials',
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              const SectionTitle(
                tag: 'TESTIMONIALS',
                title: 'What Clients Say',
                subtitle:
                    'Trusted by businesses worldwide to deliver exceptional mobile experiences',
              ),

              SizedBox(height: isMobile ? 32 : 48),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isVisible ? 1.0 : 0.0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 600),
                  offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                  curve: Curves.easeOutCubic,
                  child: const TestimonialStatsRow(),
                ),
              ),

              SizedBox(height: isMobile ? 48 : 64),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: _isVisible ? 1.0 : 0.0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 800),
                  offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                  curve: Curves.easeOutCubic,
                  child: TestimonialSlider(
                    testimonials: TestimonialsData.featured,
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 32 : 48),

              _buildTrustBadges(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustBadges(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;

    final badges = [
      _TrustBadge(
        icon: Icons.verified_user_rounded,
        label: '100% Satisfaction',
      ),
      _TrustBadge(icon: Icons.schedule_rounded, label: 'On-Time Delivery'),
      _TrustBadge(icon: Icons.support_agent_rounded, label: '24/7 Support'),
      _TrustBadge(icon: Icons.security_rounded, label: 'Secure & Reliable'),
    ];

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _isVisible ? 1.0 : 0.0,
      child: Column(
        children: [
          Text(
            'Why clients trust me',
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: badges.map((badge) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(badge.icon, size: 18, color: AppColors.success),
                    const SizedBox(width: 8),
                    Text(
                      badge.label,
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TrustBadge {
  final IconData icon;
  final String label;

  const _TrustBadge({required this.icon, required this.label});
}
