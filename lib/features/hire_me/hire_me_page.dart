import 'package:flutter/material.dart';

import '../../core/utils/url_launcher_utils.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../core/widgets/social_button.dart';
import '../home/widgets/contact_form.dart';
import '../testimonials/widgets/testimonial_stats.dart';
import 'data/pricing_data.dart';
import 'models/pricing_model.dart';

class HireMePage extends StatelessWidget {
  const HireMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final horizontalPadding = isMobile ? 24.0 : 40.0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: 60),
          _buildHeroSection(context),
          const SizedBox(height: 80),
          _buildPricingSection(context),
          const SizedBox(height: 80),
          _buildContactSection(context),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return Column(
        children: [
          Text(
            'Hire Me',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Flutter Developer\nfor your next project',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildFeatureItem(
                  context,
                  Icons.rocket_launch,
                  'Fast Development',
                  'Ship quality apps quickly',
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  context,
                  Icons.code,
                  'Clean Code',
                  'Maintainable and scalable',
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  context,
                  Icons.support_agent,
                  'Full Support',
                  'From idea to deployment',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            text: 'Get Started',
            icon: Icons.arrow_forward,
            onPressed: () => UrlLauncherUtils.openCalendly(),
            fullWidth: true,
          ),
          const SizedBox(height: 16),
          SecondaryButton(
            text: 'View Portfolio',
            icon: Icons.work,
            onPressed: () {},
            fullWidth: true,
          ),
          const SizedBox(height: 32),
          const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
        ],
      );
    }

    // Desktop/Tablet
    return Column(
      children: [
        Text(
          'Hire Me',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Expert Flutter Developer ready to build\nyour next amazing application',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeatureItem(
                      context,
                      Icons.rocket_launch,
                      'Fast Development',
                      'Ship quality apps quickly with modern practices',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureItem(
                      context,
                      Icons.code,
                      'Clean Code',
                      'Maintainable architecture that scales',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureItem(
                      context,
                      Icons.support_agent,
                      'Full Support',
                      'End-to-end development services',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                children: [
                  PrimaryButton(
                    text: 'Schedule a Call',
                    icon: Icons.calendar_today,
                    onPressed: () => UrlLauncherUtils.openCalendly(),
                    fullWidth: true,
                    height: 56,
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    text: 'Send Message',
                    icon: Icons.email,
                    onPressed: () => UrlLauncherUtils.launchEmail(
                      subject: 'Hire Me Inquiry',
                    ),
                    fullWidth: true,
                    height: 56,
                  ),
                  const SizedBox(height: 24),
                  const TestimonialStatsInline(),
                  const SizedBox(height: 24),
                  const SocialButtonRow(
                    showEmail: true,
                    showBuyMeACoffee: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Column(
      children: [
        Text(
          'Simple Pricing',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose the plan that fits your needs',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 48),
        if (isMobile)
          ...PricingData.plans.map(
            (plan) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _SimplePricingCard(plan: plan),
            ),
          )
        else
          Row(
            children: PricingData.plans
                .map(
                  (plan) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: _SimplePricingCard(plan: plan),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Let\'s Talk About Your Project',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Ready to get started? Fill out the form below and I\'ll get back to you within 24 hours.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        const ContactForm(),
      ],
    );
  }
}

class _SimplePricingCard extends StatelessWidget {
  final PricingPlan plan;

  const _SimplePricingCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: plan.isPopular
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  plan.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (plan.isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'POPULAR',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            plan.subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            plan.priceRange,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          if (plan.billing.isNotEmpty) ...[
            Text(
              plan.billing,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 24),
          ...plan.features
              .take(4)
              .map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 20, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: plan.isCustom ? 'Contact Me' : 'Get Started',
            onPressed: () => UrlLauncherUtils.openCalendly(),
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
