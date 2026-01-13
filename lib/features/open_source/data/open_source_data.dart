import '../../../core/constants/app_urls.dart';
import '../models/github_models.dart';

class OpenSourceData {
  OpenSourceData._();

  static const GitHubStats githubStats = GitHubStats(
    publicRepos: 25,
    followers: 120,
    following: 50,
    totalStars: 85,
    totalForks: 32,
    contributions: 450,
    avatarUrl: 'https://github.com/sanaullah49.png',
    profileUrl: AppUrls.github,
  );

  static final List<GitHubRepo> featuredRepos = [
    GitHubRepo(
      name: 'expense_tracker',
      description:
          'Production-ready expense tracking app with multi-currency support, biometric auth, and export features.',
      url: AppUrls.expenseTrackerRepo,
      language: 'Dart',
      stars: 45,
      forks: 12,
      watchers: 8,
      updatedAt: DateTime(2025, 1, 15),
      topics: ['flutter', 'dart', 'finance', 'hive', 'provider'],
    ),
    GitHubRepo(
      name: 'custom_ruler',
      description:
          'A highly customizable Flutter package for creating ruler widgets with horizontal/vertical orientations.',
      url: 'https://github.com/sanaullah49/custom_ruler',
      language: 'Dart',
      stars: 28,
      forks: 8,
      watchers: 5,
      updatedAt: DateTime(2025, 2, 1),
      topics: ['flutter', 'package', 'widget', 'pub-dev'],
    ),
    GitHubRepo(
      name: 'flutter_portfolio',
      description:
          'My personal portfolio website built with Flutter Web, featuring responsive design and animations.',
      url: 'https://github.com/sanaullah49/flutter_portfolio',
      language: 'Dart',
      stars: 15,
      forks: 5,
      watchers: 3,
      updatedAt: DateTime(2025, 2, 10),
      topics: ['flutter', 'portfolio', 'web', 'responsive'],
    ),
  ];

  static final List<PubDevPackage> packages = [
    PubDevPackage(
      name: 'custom_ruler',
      description:
          'A customizable ruler widget for Flutter with support for horizontal and vertical orientations, custom styling, and smooth interactions.',
      version: '1.0.2',
      url: AppUrls.customRulerPackage,
      likes: 35,
      pubPoints: 130,
      popularity: 72,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      publishedAt: DateTime(2025, 1, 20),
      isVerified: true,
    ),
  ];

  static List<ContributionDay> generateMockContributions() {
    final contributions = <ContributionDay>[];
    final now = DateTime.now();
    final random = DateTime.now().millisecondsSinceEpoch;

    for (int i = 365; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final seed = (date.day * date.month + random) % 10;
      final count = seed < 3
          ? 0
          : seed < 5
          ? (seed % 3) + 1
          : seed < 8
          ? (seed % 5) + 3
          : (seed % 8) + 5;

      final level = _getContributionLevel(count);
      contributions.add(
        ContributionDay(date: date, count: count, level: level),
      );
    }

    return contributions;
  }

  static ContributionLevel _getContributionLevel(int count) {
    if (count == 0) return ContributionLevel.none;
    if (count <= 2) return ContributionLevel.low;
    if (count <= 5) return ContributionLevel.medium;
    if (count <= 8) return ContributionLevel.high;
    return ContributionLevel.veryHigh;
  }

  static int get yearlyContributions {
    return generateMockContributions()
        .where((c) => c.date.year == DateTime.now().year)
        .fold(0, (sum, c) => sum + c.count);
  }
}
