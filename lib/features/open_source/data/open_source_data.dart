import '../../../core/constants/app_urls.dart';
import '../models/github_models.dart';

class OpenSourceData {
  OpenSourceData._();

  static const GitHubStats githubStats = GitHubStats(
    publicRepos: 9,
    followers: 2,
    following: 6,
    totalStars: 10,
    totalForks: 3,
    contributions: 450,
    avatarUrl: 'https://github.com/sanaullah49.png',
    profileUrl: AppUrls.github,
  );

  static final List<GitHubRepo> featuredRepos = [
    GitHubRepo(
      name: 'arc_progress_ring',
      description:
          'A highly customizable circular progress indicator with milestone markers, glassmorphic effects, and smooth animations for Flutter.',
      url: AppUrls.expenseTrackerRepo,
      language: 'Dart',
      stars: 3,
      forks: 2,
      watchers: 8,
      updatedAt: DateTime(2026, 1, 8),
      topics: ['flutter', 'package', 'widget', 'pub-dev'],
    ),
    GitHubRepo(
      name: 'expense_tracker',
      description:
          'Production-ready expense tracking app with multi-currency support, biometric auth, and export features.',
      url: AppUrls.expenseTrackerRepo,
      language: 'Dart',
      stars: 7,
      forks: 2,
      watchers: 8,
      updatedAt: DateTime(2025, 12, 27),
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
      updatedAt: DateTime(2026, 1, 2),
      topics: ['flutter', 'package', 'widget', 'pub-dev'],
    ),
    GitHubRepo(
      name: 'sanaullah',
      description:
          'My personal portfolio website built with Flutter Web, featuring responsive design and animations.',
      url: 'https://github.com/sanaullah49/sanaullah',
      language: 'Dart',
      stars: 3,
      forks: 1,
      watchers: 2,
      updatedAt: DateTime.now(),
      topics: ['flutter', 'portfolio', 'web', 'responsive'],
    ),
  ];

  static final List<PubDevPackage> packages = [
    PubDevPackage(
      name: 'custom_ruler',
      description:
          'A customizable ruler widget for Flutter with support for horizontal and vertical orientations, custom styling, and smooth interactions.',
      version: '1.0.0',
      url: AppUrls.customRulerPackage,
      likes: 7,
      pubPoints: 160,
      popularity: 144,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      publishedAt: DateTime(2025, 12, 28),
      isVerified: true,
    ),
    PubDevPackage(
      name: 'arc_progress_ring',
      description:
          'A customizable ruler widget for Flutter with support for horizontal and vertical orientations, custom styling, and smooth interactions.',
      version: '1.0.1',
      url: AppUrls.arcProgressRingPackage,
      likes: 6,
      pubPoints: 160,
      popularity: 147,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      publishedAt: DateTime(2025, 1, 7),
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
