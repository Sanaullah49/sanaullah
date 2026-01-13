import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class BlogPost {
  final String id;
  final String title;
  final String slug;
  final String excerpt;
  final String content;
  final String coverImage;
  final DateTime publishedAt;
  final List<String> tags;
  final int readTime;
  final BlogCategory category;
  final bool isFeatured;
  final int views;
  final int likes;

  const BlogPost({
    required this.id,
    required this.title,
    required this.slug,
    required this.excerpt,
    required this.content,
    required this.coverImage,
    required this.publishedAt,
    required this.tags,
    required this.readTime,
    required this.category,
    this.isFeatured = false,
    this.views = 0,
    this.likes = 0,
  });

  String get formattedDate {
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
    return '${months[publishedAt.month - 1]} ${publishedAt.day}, ${publishedAt.year}';
  }
}

enum BlogCategory {
  flutter,
  dart,
  architecture,
  stateManagement,
  uiux,
  career,
  tutorial,
}

extension BlogCategoryExtension on BlogCategory {
  String get label {
    switch (this) {
      case BlogCategory.flutter:
        return 'Flutter';
      case BlogCategory.dart:
        return 'Dart';
      case BlogCategory.architecture:
        return 'Architecture';
      case BlogCategory.stateManagement:
        return 'State Management';
      case BlogCategory.uiux:
        return 'UI/UX';
      case BlogCategory.career:
        return 'Career';
      case BlogCategory.tutorial:
        return 'Tutorial';
    }
  }

  Color get color {
    switch (this) {
      case BlogCategory.flutter:
        return AppColors.flutter;
      case BlogCategory.dart:
        return AppColors.dart;
      case BlogCategory.architecture:
        return AppColors.primary;
      case BlogCategory.stateManagement:
        return AppColors.accent;
      case BlogCategory.uiux:
        return AppColors.secondary;
      case BlogCategory.career:
        return AppColors.success;
      case BlogCategory.tutorial:
        return AppColors.warning;
    }
  }
}
