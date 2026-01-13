import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/animated_counter.dart';

class StatsRow extends StatefulWidget {
  const StatsRow({super.key});

  @override
  State<StatsRow> createState() => _StatsRowState();
}

class _StatsRowState extends State<StatsRow> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    final padding = isMobile
        ? const EdgeInsets.symmetric(vertical: 24, horizontal: 16)
        : const EdgeInsets.symmetric(vertical: 40, horizontal: 32);

    return VisibilityDetector(
      key: const Key('stats-row'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.darkBgSecondary.withValues(alpha: 0.5)
              : AppColors.lightBgSecondary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: isMobile || isTablet
            ? _buildResponsiveLayout(context)
            : _buildDesktopStats(context),
      ),
    );
  }

  Widget _buildDesktopStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(
          context,
          value: AppConstants.yearsExperience,
          label: 'Years Experience',
          delay: 0,
        ),
        _buildDivider(context),
        _buildStatItem(
          context,
          value: AppConstants.appsPublished,
          label: 'Apps Published',
          delay: 100,
        ),
        _buildDivider(context),
        _buildStatItem(
          context,
          value: AppConstants.clientSatisfaction,
          label: 'Client Satisfaction',
          delay: 200,
        ),
        _buildDivider(context),
        _buildStatItem(
          context,
          value: AppConstants.linesOfCode,
          label: 'Lines of Code',
          delay: 300,
        ),
      ],
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    final isMobile = context.isMobile;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildStatItem(
                context,
                value: AppConstants.yearsExperience,
                label: isMobile ? 'Years Exp.' : 'Years Experience',
                delay: 0,
                compact: true,
              ),
            ),
            if (!isMobile) _buildDivider(context),
            Expanded(
              child: _buildStatItem(
                context,
                value: AppConstants.appsPublished,
                label: isMobile ? 'Apps Shipped' : 'Apps Published',
                delay: 100,
                compact: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          height: 1,
          width: double.infinity,
          color: context.colorScheme.outline.withValues(alpha: 0.1),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildStatItem(
                context,
                value: AppConstants.clientSatisfaction,
                label: isMobile ? 'Satisfaction' : 'Client Satisfaction',
                delay: 200,
                compact: true,
              ),
            ),
            if (!isMobile) _buildDivider(context),
            Expanded(
              child: _buildStatItem(
                context,
                value: AppConstants.linesOfCode,
                label: 'Lines of Code',
                delay: 300,
                compact: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String value,
    required String label,
    required int delay,
    bool compact = false,
  }) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isMobile = context.isMobile;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        curve: Curves.easeOutCubic,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _isVisible
                ? AnimatedCounter(
                    value: value,
                    style:
                        (isMobile
                                ? textTheme.headlineSmall
                                : textTheme.displaySmall)
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: isMobile ? 28 : 36,
                              foreground: Paint()
                                ..shader = AppColors.primaryGradient
                                    .createShader(
                                      const Rect.fromLTWH(0, 0, 100, 50),
                                    ),
                            ),
                    duration: Duration(milliseconds: 2000 + delay),
                  )
                : Text(
                    '0',
                    style:
                        (isMobile
                                ? textTheme.headlineSmall
                                : textTheme.displaySmall)
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: colorScheme.primary,
                            ),
                  ),

            const SizedBox(height: 8),

            Text(
              label,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 12 : 14,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      width: 1,
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: context.colorScheme.outline.withValues(alpha: 0.2),
    );
  }
}
