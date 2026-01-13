import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class Experience {
  final String id;
  final String title;
  final String company;
  final String companyUrl;
  final String location;
  final String type;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final List<String> responsibilities;
  final List<String> achievements;
  final List<String> technologies;
  final Color accentColor;
  final String? logoAsset;

  const Experience({
    required this.id,
    required this.title,
    required this.company,
    this.companyUrl = '',
    required this.location,
    this.type = 'Full-time',
    required this.startDate,
    this.endDate,
    required this.description,
    this.responsibilities = const [],
    this.achievements = const [],
    this.technologies = const [],
    this.accentColor = AppColors.primary,
    this.logoAsset,
  });

  bool get isCurrent => endDate == null;

  String get dateRange {
    final start = _formatDate(startDate);
    final end = endDate != null ? _formatDate(endDate!) : 'Present';
    return '$start - $end';
  }

  String get duration {
    final end = endDate ?? DateTime.now();
    final months = _monthsBetween(startDate, end);

    if (months < 1) return 'Less than a month';
    if (months == 1) return '1 month';
    if (months < 12) return '$months months';

    final years = months ~/ 12;
    final remainingMonths = months % 12;

    if (remainingMonths == 0) {
      return years == 1 ? '1 year' : '$years years';
    }

    final yearStr = years == 1 ? '1 year' : '$years years';
    final monthStr = remainingMonths == 1
        ? '1 month'
        : '$remainingMonths months';
    return '$yearStr $monthStr';
  }

  String _formatDate(DateTime date) {
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
    return '${months[date.month - 1]} ${date.year}';
  }

  int _monthsBetween(DateTime from, DateTime to) {
    return (to.year - from.year) * 12 + (to.month - from.month);
  }
}

class Education {
  final String id;
  final String degree;
  final String field;
  final String institution;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String? gpa;
  final List<String> achievements;
  final Color accentColor;

  const Education({
    required this.id,
    required this.degree,
    required this.field,
    required this.institution,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.gpa,
    this.achievements = const [],
    this.accentColor = AppColors.accent,
  });

  String get dateRange {
    return '${startDate.year} - ${endDate.year}';
  }

  String get fullDegree => '$degree in $field';
}

class Certification {
  final String id;
  final String name;
  final String issuer;
  final DateTime issueDate;
  final DateTime? expiryDate;
  final String? credentialId;
  final String? credentialUrl;
  final Color accentColor;

  const Certification({
    required this.id,
    required this.name,
    required this.issuer,
    required this.issueDate,
    this.expiryDate,
    this.credentialId,
    this.credentialUrl,
    this.accentColor = AppColors.success,
  });

  bool get isValid => expiryDate == null || expiryDate!.isAfter(DateTime.now());
}
