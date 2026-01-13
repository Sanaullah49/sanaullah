import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/utils/url_launcher_utils.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/social_button.dart';
import '../home/widgets/contact_form.dart';
import '../testimonials/widgets/testimonial_stats.dart';
import 'data/pricing_data.dart';
import 'widgets/pricing_card.dart';

class HireMePage extends StatelessWidget {
  const HireMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 60 : 100,
            ),
            decoration: BoxDecoration(
              gradient: context.isDarkMode
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF020617),
                        Color(0xFF020617),
                        Color(0xFF111827),
                      ],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE0EAFF), Color(0xFFF5F3FF)],
                    ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: isMobile
                    ? _buildMobileHero(context)
                    : _buildDesktopHero(context),
              ),
            ),
          ),

          const SizedBox(height: 40),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40 : 60,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: _buildPricingSection(context),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40 : 60,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: const ContactForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHero(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hire a Flutter Developer\nwho thinks like a founder',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "I don’t just write code. I help you design, build, and ship mobile products\nthat people actually use — and that can make you serious money.",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              const TestimonialStatsInline(),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  PrimaryButton(
                    text: 'Book a Free 15‑min Call',
                    icon: Icons.calendar_today_rounded,
                    onPressed: () => UrlLauncherUtils.openCalendly(),
                  ),
                  SecondaryButton(
                    text: 'Email Me Your Idea',
                    icon: Icons.email_rounded,
                    onPressed: () => UrlLauncherUtils.launchEmail(
                      subject: 'Project Idea - Flutter App',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
            ],
          ),
        ),

        const SizedBox(width: 60),

        Expanded(flex: 4, child: _buildHeroHighlights(context)),
      ],
    );
  }

  Widget _buildMobileHero(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hire a Flutter Developer\nwho thinks like a founder',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "I help you design, build, and ship Flutter apps that users love\nand that can generate real revenue.",
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        const TestimonialStatsInline(),
        const SizedBox(height: 24),
        PrimaryButton(
          text: 'Book a Free 15‑min Call',
          icon: Icons.calendar_today_rounded,
          fullWidth: true,
          onPressed: () => UrlLauncherUtils.openCalendly(),
        ),
        const SizedBox(height: 12),
        SecondaryButton(
          text: 'Email Me Your Idea',
          icon: Icons.email_rounded,
          fullWidth: true,
          onPressed: () => UrlLauncherUtils.launchEmail(
            subject: 'Project Idea - Flutter App',
          ),
        ),
        const SizedBox(height: 24),
        _buildHeroHighlights(context),
        const SizedBox(height: 24),
        const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
      ],
    );
  }

  Widget _buildHeroHighlights(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final items = [
      _HighlightItem(
        icon: Icons.rocket_launch_rounded,
        title: 'Outcome‑driven development',
        description:
            'We start from your business goals and design the app around outcomes—not just features.',
      ),
      _HighlightItem(
        icon: Icons.architecture_rounded,
        title: 'Clean, scalable architecture',
        description:
            'SOLID, Clean Architecture, and best practices so your app can grow without turning into a mess.',
      ),
      _HighlightItem(
        icon: Icons.bolt_rounded,
        title: 'Speed without chaos',
        description:
            'You get fast delivery without sacrificing code quality, stability, or long‑term maintainability.',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    final isMobile = context.isMobile;
    final plans = PricingData.plans;

    return Column(
      children: [
        Text(
          'Choose how we work together',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Pricing ranges are realistic based on scope. Once I understand your project, you’ll get a clear, fixed quote.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            if (isMobile || constraints.maxWidth < 900) {
              return Column(
                children: [
                  for (final plan in plans) ...[
                    PricingCard(plan: plan),
                    const SizedBox(height: 24),
                  ],
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: PricingCard(plan: plans[0])),
                const SizedBox(width: 24),
                Expanded(child: PricingCard(plan: plans[1])),
                const SizedBox(width: 24),
                Expanded(child: PricingCard(plan: plans[2])),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _HighlightItem {
  final IconData icon;
  final String title;
  final String description;

  const _HighlightItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
