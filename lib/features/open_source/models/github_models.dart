import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class GitHubStats {
  final int publicRepos;
  final int followers;
  final int following;
  final int totalStars;
  final int totalForks;
  final int contributions;
  final String avatarUrl;
  final String profileUrl;

  const GitHubStats({
    this.publicRepos = 0,
    this.followers = 0,
    this.following = 0,
    this.totalStars = 0,
    this.totalForks = 0,
    this.contributions = 0,
    this.avatarUrl = '',
    this.profileUrl = '',
  });

  factory GitHubStats.mock() {
    return const GitHubStats(
      publicRepos: 25,
      followers: 120,
      following: 50,
      totalStars: 85,
      totalForks: 32,
      contributions: 450,
      avatarUrl: 'https://github.com/sanaullah49.png',
      profileUrl: 'https://github.com/sanaullah49',
    );
  }
}

class GitHubRepo {
  final String name;
  final String description;
  final String url;
  final String language;
  final int stars;
  final int forks;
  final int watchers;
  final bool isForked;
  final DateTime? updatedAt;
  final List<String> topics;

  const GitHubRepo({
    required this.name,
    required this.description,
    required this.url,
    this.language = 'Dart',
    this.stars = 0,
    this.forks = 0,
    this.watchers = 0,
    this.isForked = false,
    this.updatedAt,
    this.topics = const [],
  });

  Color get languageColor {
    switch (language.toLowerCase()) {
      case 'dart':
        return AppColors.dart;
      case 'flutter':
        return AppColors.flutter;
      case 'java':
        return const Color(0xFFB07219);
      case 'kotlin':
        return const Color(0xFF7F52FF);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'typescript':
        return const Color(0xFF3178C6);
      case 'python':
        return const Color(0xFF3776AB);
      default:
        return AppColors.primary;
    }
  }
}

class PubDevPackage {
  final String name;
  final String description;
  final String version;
  final String url;
  final int likes;
  final int pubPoints;
  final int popularity;
  final List<String> platforms;
  final DateTime? publishedAt;
  final bool isVerified;

  const PubDevPackage({
    required this.name,
    required this.description,
    required this.version,
    required this.url,
    this.likes = 0,
    this.pubPoints = 0,
    this.popularity = 0,
    this.platforms = const ['Android', 'iOS', 'Web'],
    this.publishedAt,
    this.isVerified = false,
  });

  String get popularityString => '$popularity%';

  bool get hasGoodScore => pubPoints >= 100;
}

class ContributionDay {
  final DateTime date;
  final int count;
  final ContributionLevel level;

  const ContributionDay({
    required this.date,
    required this.count,
    required this.level,
  });
}

enum ContributionLevel { none, low, medium, high, veryHigh }

extension ContributionLevelExtension on ContributionLevel {
  Color getColor(bool isDark) {
    switch (this) {
      case ContributionLevel.none:
        return isDark ? const Color(0xFF161B22) : const Color(0xFFEBEDF0);
      case ContributionLevel.low:
        return isDark ? const Color(0xFF0E4429) : const Color(0xFF9BE9A8);
      case ContributionLevel.medium:
        return isDark ? const Color(0xFF006D32) : const Color(0xFF40C463);
      case ContributionLevel.high:
        return isDark ? const Color(0xFF26A641) : const Color(0xFF30A14E);
      case ContributionLevel.veryHigh:
        return isDark ? const Color(0xFF39D353) : const Color(0xFF216E39);
    }
  }
}
