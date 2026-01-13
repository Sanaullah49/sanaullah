import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PricingPlan {
  final String id;
  final String name;
  final String subtitle;
  final String priceRange;
  final String billing;
  final bool isPopular;
  final bool isCustom;
  final List<String> features;
  final List<String> idealFor;
  final String? deliveryTime;
  final String? supportLevel;
  final Color accentColor;

  const PricingPlan({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.priceRange,
    required this.billing,
    this.isPopular = false,
    this.isCustom = false,
    required this.features,
    this.idealFor = const [],
    this.deliveryTime,
    this.supportLevel,
    this.accentColor = AppColors.primary,
  });
}
