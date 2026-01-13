import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../models/pricing_model.dart';

class PricingCard extends StatefulWidget {
  final PricingPlan plan;

  const PricingCard({super.key, required this.plan});

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  bool _isHovered = false;

  void _onPrimaryAction() {
    final subject = 'Project Inquiry - ${widget.plan.name} Plan';
    final body =
        '''
Hi Sana,

I'm interested in the **${widget.plan.name}** plan.

Here are a few details about my project:
- Type of app: 
- Timeline:
- Budget range:

Let me know the next steps.

Thanks,
''';

    UrlLauncherUtils.launchEmail(subject: subject, body: body);
  }

  void _onSecondaryAction() {
    UrlLauncherUtils.openCalendly();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final plan = widget.plan;

    final highlightColor = plan.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: plan.isPopular || _isHovered
                ? highlightColor.withValues(alpha: 0.6)
                : colorScheme.outline.withValues(alpha: 0.15),
            width: plan.isPopular ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: plan.isPopular || _isHovered
                  ? highlightColor.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: isDark ? 0.18 : 0.05),
              blurRadius: plan.isPopular || _isHovered ? 30 : 18,
              offset: Offset(0, plan.isPopular || _isHovered ? 14 : 8),
            ),
          ],
        ),
        transform: Matrix4.identity()
          ..translateByDouble(
            0.0,
            _isHovered || plan.isPopular ? -6.0 : 0.0,
            0.0,
            0.0,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (plan.isPopular)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: highlightColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: highlightColor.withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department_rounded,
                        size: 14,
                        color: highlightColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Most Popular',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: highlightColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (plan.isPopular) const SizedBox(height: 16),

            Text(
              plan.name,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              plan.subtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  plan.priceRange,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: highlightColor,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  plan.billing,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            if (plan.deliveryTime != null || plan.supportLevel != null) ...[
              const SizedBox(height: 8),
              if (plan.deliveryTime != null)
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      plan.deliveryTime!,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              if (plan.supportLevel != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      plan.supportLevel!,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ],

            const SizedBox(height: 20),

            Text(
              'Includes',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            ...plan.features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            if (plan.idealFor.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Best for',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...plan.idealFor.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: plan.isCustom ? 'Book a Call' : 'Start This Plan',
                    icon: plan.isCustom
                        ? Icons.calendar_today_rounded
                        : Icons.send_rounded,
                    onPressed: plan.isCustom
                        ? _onSecondaryAction
                        : _onPrimaryAction,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SecondaryButton(
                    text: 'Ask a Question',
                    icon: Icons.chat_rounded,
                    onPressed: _onSecondaryAction,
                    height: 50,
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
