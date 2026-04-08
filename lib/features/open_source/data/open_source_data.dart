import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
import '../models/github_models.dart';

class OpenSourceData {
  OpenSourceData._();

  static const GitHubStats githubStats = GitHubStats(
    publicRepos: 20,
    privateRepos: 130,
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
      name: 'flutter_wallpaper_plus',
      description:
          'Flutter plugin to set both home screen and lock screen wallpaper with support for crop, scale, and native gallery saving.',
      version: '1.1.1',
      url: AppUrls.flutterWallpaperPlusPackage,
      likes: 0,
      pubPoints: 130,
      downloads: 42,
      platforms: const ['Android'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'arc_progress_ring',
      description:
          'A sleek and customizable Flutter widget for rendering animated circular progress rings with support for milestones, gradients, glass effects, and center content.',
      version: '1.0.1',
      url: AppUrls.arcProgressRingPackage,
      likes: 0,
      pubPoints: 160,
      downloads: 17,
      platforms: const ['Android', 'iOS', 'Linux', 'macOS', 'Web', 'Windows'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'custom_ruler',
      description:
          'A highly customizable Flutter package for creating ruler widgets with horizontal and vertical orientations, custom styling, and smooth interactions.',
      version: '1.0.0',
      url: AppUrls.customRulerPackage,
      likes: 0,
      pubPoints: 160,
      downloads: 49,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'ai_kit',
      description:
          'A Flutter package for building modern assistant chat interfaces with streaming, conversation state, message models, and plug-and-play widgets.',
      version: '0.1.0',
      url: AppUrls.aiKitPackage,
      likes: 0,
      pubPoints: 150,
      downloads: 7,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'goal_progress_indicator',
      description:
          'A highly customizable Flutter package for visualizing goal progress with multiple built-in styles, animated transitions, and threshold markers.',
      version: '1.0.0',
      url: AppUrls.goalProgressIndicatorPackage,
      likes: 0,
      pubPoints: 150,
      downloads: 9,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'magic_responsive',
      description:
          'A lightweight, zero-configuration Flutter package for truly responsive UIs across phones, tablets, desktops, and ultra-wide screens.',
      version: '0.0.1',
      url: AppUrls.magicResponsivePackage,
      likes: 0,
      pubPoints: 150,
      downloads: 7,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'flutter_build_doctor',
      description:
          'A Flutter tool that scans your project and automatically detects common build issues, misconfigurations, and plugin mismatches with actionable suggestions.',
      version: '0.1.0',
      url: AppUrls.flutterBuildDoctorPackage,
      likes: 0,
      pubPoints: 150,
      downloads: 7,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'flutter_lifecycle_guard',
      description:
          'Effortlessly manage app lifecycle states in Flutter with prebuilt handlers, intuitive state utilities, and minimal setup.',
      version: '1.0.0-dev.1',
      url: AppUrls.flutterLifecycleGuardPackage,
      likes: 0,
      pubPoints: 140,
      downloads: 4,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'vidkit',
      description:
          'VidKit is a Flutter package for embedding branded short-form video reels with smooth playback, engagement callbacks, and an extensible UI layer.',
      version: '0.1.1',
      url: AppUrls.vidkitPackage,
      likes: 0,
      pubPoints: 130,
      downloads: 44,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'webify_toolkit',
      description:
          'Webify Toolkit helps you turn existing Flutter widgets into polished web-ready sections with responsive wrappers, SEO helpers, and styling utilities.',
      version: '0.1.0',
      url: AppUrls.webifyToolkitPackage,
      likes: 0,
      pubPoints: 150,
      downloads: 4,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'hyper_table',
      description:
          'High-performance Flutter data grid with virtual scrolling, frozen columns, sorting, filtering, editing, tree data, and synchronized section scrolling.',
      version: '0.1.0',
      url: AppUrls.hyperTablePackage,
      likes: 0,
      pubPoints: 160,
      downloads: 27,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
    PubDevPackage(
      name: 'auto_theme',
      description:
          'Automatically generate the opposite Flutter theme from the one you already designed.',
      version: '0.1.1',
      url: AppUrls.autoThemePackage,
      likes: 0,
      pubPoints: 150,
      downloads: null,
      platforms: const ['Android', 'iOS', 'Web', 'macOS', 'Windows', 'Linux'],
      isVerified: true,
    ),
  ];

  static final List<OpenSourceContribution> selectedContributions = [
    OpenSourceContribution(
      reference: '#184193',
      title: 'Removed a cross-import from sliver_app_bar_test',
      summary:
          'Cleaned up Flutter framework tests by removing the sliver_test_utils cross-import and inlining the small geometry helper directly into the test.',
      repository: 'flutter/flutter',
      url: AppUrls.flutterFrameworkPr,
      dateLabel: 'Merged Apr 1, 2026',
      area: 'Framework tests',
      status: ContributionStatus.merged,
      tags: ['framework', 'material', 'scrolling'],
      accentColor: AppColors.primary,
    ),
    OpenSourceContribution(
      reference: '#184651',
      title:
          'Removed feedback_tester cross-import from checkbox_list_tile_test',
      summary:
          'Simplified another Flutter framework test by inlining the small feedback tester helper and removing the cross-import dependency.',
      repository: 'flutter/flutter',
      url: AppUrls.flutterCheckboxListTilePr,
      dateLabel: 'Recent PR · Apr 6, 2026',
      area: 'Framework tests',
      status: ContributionStatus.recent,
      tags: ['framework', 'material', 'test cleanup'],
      accentColor: AppColors.accent,
    ),
    OpenSourceContribution(
      reference: '#184192',
      title: 'Disabled web hot reload when flutter run uses --no-hot',
      summary:
          'Updated flutter_tools so the --no-hot flag correctly disables web hot reload, with regression coverage for both command handling and the resident web runner.',
      repository: 'flutter/flutter',
      url: AppUrls.flutterNoHotPr,
      dateLabel: 'Recent PR · Mar 26, 2026',
      area: 'Flutter tool',
      status: ContributionStatus.recent,
      tags: ['tool', 'web', 'regression tests'],
      accentColor: AppColors.secondary,
    ),
    OpenSourceContribution(
      reference: '#184189',
      title: 'Preserved multiple Set-Cookie headers in the web proxy',
      summary:
          'Fixed Flutter web proxy behavior so multiple Set-Cookie headers are preserved correctly, backed by an end-to-end regression test.',
      repository: 'flutter/flutter',
      url: AppUrls.flutterSetCookiePr,
      dateLabel: 'Recent PR · Mar 26, 2026',
      area: 'Web tooling',
      status: ContributionStatus.recent,
      tags: ['tool', 'web proxy', 'networking'],
      accentColor: AppColors.info,
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
