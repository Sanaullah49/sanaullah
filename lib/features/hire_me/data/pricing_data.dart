import '../../../core/theme/app_colors.dart';
import '../models/pricing_model.dart';

class PricingData {
  PricingData._();

  static const List<PricingPlan> plans = [
    PricingPlan(
      id: 'starter',
      name: 'Starter Launch',
      subtitle: 'MVP or small app to validate your idea fast',
      priceRange: '\$800 - \$1.5k',
      billing: 'per project',
      isPopular: false,
      isCustom: false,
      features: [
        '1 Flutter app (Android + iOS)',
        'Up to 3 core screens (e.g. auth, home, list/detail)',
        'Basic state management (Provider/Riverpod)',
        'Simple REST/Firebase integration',
        'Clean, production-ready codebase',
        'Bug fixes for 14 days after launch',
      ],
      idealFor: [
        'Early-stage founders validating an idea',
        'Agencies needing a quick proof-of-concept',
        'Internal tools / admin dashboards',
      ],
      deliveryTime: '2–3 weeks',
      supportLevel: 'Email support during development',
      accentColor: AppColors.success,
    ),
    PricingPlan(
      id: 'growth',
      name: 'Growth Product',
      subtitle: 'Serious app with revenue in mind',
      priceRange: '\$2k - \$5k',
      billing: 'per project',
      isPopular: true,
      isCustom: false,
      features: [
        'Full Flutter app (Android + iOS)',
        'Up to 10 screens with custom UI',
        'Advanced state management (Bloc / Riverpod)',
        'Authentication, payments, analytics integration',
        'Offline-first patterns where needed',
        'Clean Architecture + SOLID principles',
        'Performance optimization pass',
        'Bug fixes for 30 days after launch',
      ],
      idealFor: [
        'Founders planning to monetize / raise capital',
        'Businesses replacing legacy mobile apps',
        'Agencies needing a reliable Flutter partner',
      ],
      deliveryTime: '4–8 weeks',
      supportLevel: 'Priority support during development',
      accentColor: AppColors.primary,
    ),
    PricingPlan(
      id: 'partner',
      name: 'Technical Partner',
      subtitle: 'Ongoing engagement for ambitious products',
      priceRange: '\$1.5k+ / month',
      billing: 'monthly / retainer',
      isPopular: false,
      isCustom: true,
      features: [
        'Dedicated Flutter development each month',
        'Feature development & refactoring',
        'Architecture reviews & performance tuning',
        'Mentoring your in-house devs',
        'Priority bug fixing & support',
        'Long-term roadmap collaboration',
      ],
      idealFor: [
        'Startups needing a part-time senior Flutter dev',
        'Agencies with recurring Flutter work',
        'Companies scaling an existing Flutter product',
      ],
      deliveryTime: 'Ongoing engagement',
      supportLevel: 'High-priority support & async calls',
      accentColor: AppColors.accent,
    ),
  ];
}
