import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class Project {
  final String id;
  final String title;
  final String slug;
  final String shortDescription;
  final String fullDescription;
  final String mockupImage;
  final List<String> screenshots;
  final List<String> technologies;
  final ProjectCategory category;
  final ProjectStatus status;
  final String? githubUrl;
  final String? liveUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? pubDevUrl;
  final List<String> features;
  final List<String> challenges;
  final String? impact;
  final DateTime? completedAt;
  final bool isFeatured;
  final Color accentColor;

  const Project({
    required this.id,
    required this.title,
    required this.slug,
    required this.shortDescription,
    required this.fullDescription,
    required this.mockupImage,
    this.screenshots = const [],
    required this.technologies,
    required this.category,
    this.status = ProjectStatus.completed,
    this.githubUrl,
    this.liveUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.pubDevUrl,
    this.features = const [],
    this.challenges = const [],
    this.impact,
    this.completedAt,
    this.isFeatured = false,
    this.accentColor = AppColors.primary,
  });

  bool get hasLinks =>
      githubUrl != null ||
      liveUrl != null ||
      playStoreUrl != null ||
      appStoreUrl != null ||
      pubDevUrl != null;

  String? get primaryLink =>
      liveUrl ?? playStoreUrl ?? appStoreUrl ?? githubUrl ?? pubDevUrl;

  String get primaryLinkLabel {
    if (liveUrl != null) return 'Live Demo';
    if (playStoreUrl != null) return 'Play Store';
    if (appStoreUrl != null) return 'App Store';
    if (pubDevUrl != null) return 'pub.dev';
    if (githubUrl != null) return 'GitHub';
    return 'View';
  }
}

enum ProjectCategory {
  mobileApp,
  package,
  openSource,
  webApp,
  healthcare,
  fintech,
  ecommerce,
  utility,
}

extension ProjectCategoryExtension on ProjectCategory {
  String get label {
    switch (this) {
      case ProjectCategory.mobileApp:
        return 'Mobile App';
      case ProjectCategory.package:
        return 'Flutter Package';
      case ProjectCategory.openSource:
        return 'Open Source';
      case ProjectCategory.webApp:
        return 'Web App';
      case ProjectCategory.healthcare:
        return 'Healthcare';
      case ProjectCategory.fintech:
        return 'Fintech';
      case ProjectCategory.ecommerce:
        return 'E-Commerce';
      case ProjectCategory.utility:
        return 'Utility';
    }
  }

  IconData get icon {
    switch (this) {
      case ProjectCategory.mobileApp:
        return Icons.phone_android_rounded;
      case ProjectCategory.package:
        return Icons.inventory_2_rounded;
      case ProjectCategory.openSource:
        return Icons.code_rounded;
      case ProjectCategory.webApp:
        return Icons.web_rounded;
      case ProjectCategory.healthcare:
        return Icons.health_and_safety_rounded;
      case ProjectCategory.fintech:
        return Icons.account_balance_rounded;
      case ProjectCategory.ecommerce:
        return Icons.shopping_cart_rounded;
      case ProjectCategory.utility:
        return Icons.build_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ProjectCategory.mobileApp:
        return AppColors.primary;
      case ProjectCategory.package:
        return AppColors.accent;
      case ProjectCategory.openSource:
        return AppColors.success;
      case ProjectCategory.webApp:
        return AppColors.info;
      case ProjectCategory.healthcare:
        return AppColors.error;
      case ProjectCategory.fintech:
        return AppColors.warning;
      case ProjectCategory.ecommerce:
        return AppColors.secondary;
      case ProjectCategory.utility:
        return AppColors.git;
    }
  }
}

enum ProjectStatus { completed, inProgress, maintenance, archived }

extension ProjectStatusExtension on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.maintenance:
        return 'Maintenance';
      case ProjectStatus.archived:
        return 'Archived';
    }
  }

  Color get color {
    switch (this) {
      case ProjectStatus.completed:
        return AppColors.success;
      case ProjectStatus.inProgress:
        return AppColors.warning;
      case ProjectStatus.maintenance:
        return AppColors.info;
      case ProjectStatus.archived:
        return AppColors.neutral500;
    }
  }
}
