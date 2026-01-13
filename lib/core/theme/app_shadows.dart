import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> get cardShadowDark => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get cardHoverShadowDark => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.15),
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.3),
      blurRadius: 40,
      spreadRadius: -5,
    ),
  ];

  static List<BoxShadow> get ctaGlowShadow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.4),
      blurRadius: 25,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get cardShadowLight => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get cardHoverShadowLight => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.08),
      blurRadius: 30,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get navbarShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.25),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];

  static List<BoxShadow> get imageShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 25,
      offset: const Offset(0, 12),
    ),
  ];
}
