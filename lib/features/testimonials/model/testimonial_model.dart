import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class Testimonial {
  final String id;
  final String name;
  final String role;
  final String company;
  final String? companyUrl;
  final String avatarUrl;
  final String content;
  final double rating;
  final String? projectWorkedOn;
  final DateTime? date;
  final bool isAnonymous;
  final TestimonialSource source;
  final Color? accentColor;

  const Testimonial({
    required this.id,
    required this.name,
    required this.role,
    required this.company,
    this.companyUrl,
    this.avatarUrl = '',
    required this.content,
    this.rating = 5.0,
    this.projectWorkedOn,
    this.date,
    this.isAnonymous = false,
    this.source = TestimonialSource.direct,
    this.accentColor,
  });

  String get initials {
    if (isAnonymous) return '?';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }

  String get displayName => isAnonymous ? 'Anonymous Client' : name;

  String get displayRole {
    if (isAnonymous) return 'Verified Client';
    return role;
  }

  String? get formattedDate {
    if (date == null) return null;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date!.month - 1]} ${date!.year}';
  }
}

enum TestimonialSource {
  direct,
  linkedin,
  upwork,
  fiverr,
  clutch,
  google,
  email,
}

extension TestimonialSourceExtension on TestimonialSource {
  String get label {
    switch (this) {
      case TestimonialSource.direct:
        return 'Direct';
      case TestimonialSource.linkedin:
        return 'LinkedIn';
      case TestimonialSource.upwork:
        return 'Upwork';
      case TestimonialSource.fiverr:
        return 'Fiverr';
      case TestimonialSource.clutch:
        return 'Clutch';
      case TestimonialSource.google:
        return 'Google';
      case TestimonialSource.email:
        return 'Email';
    }
  }

  IconData get icon {
    switch (this) {
      case TestimonialSource.direct:
        return Icons.chat_bubble_rounded;
      case TestimonialSource.linkedin:
        return Icons.business_rounded;
      case TestimonialSource.upwork:
        return Icons.work_rounded;
      case TestimonialSource.fiverr:
        return Icons.storefront_rounded;
      case TestimonialSource.clutch:
        return Icons.verified_rounded;
      case TestimonialSource.google:
        return Icons.star_rounded;
      case TestimonialSource.email:
        return Icons.email_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TestimonialSource.direct:
        return AppColors.primary;
      case TestimonialSource.linkedin:
        return AppColors.linkedin;
      case TestimonialSource.upwork:
        return AppColors.success;
      case TestimonialSource.fiverr:
        return AppColors.success;
      case TestimonialSource.clutch:
        return AppColors.error;
      case TestimonialSource.google:
        return AppColors.warning;
      case TestimonialSource.email:
        return AppColors.info;
    }
  }
}

class TestimonialStats {
  final int totalReviews;
  final double averageRating;
  final int fiveStarCount;
  final int satisfactionRate;

  const TestimonialStats({
    this.totalReviews = 0,
    this.averageRating = 5.0,
    this.fiveStarCount = 0,
    this.satisfactionRate = 100,
  });
}
