import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
import '../../open_source/data/open_source_data.dart';
import '../../open_source/models/github_models.dart';
import '../models/project_model.dart';

class ProjectsData {
  ProjectsData._();

  static final List<Project> allProjects = [
    Project(
      id: '1',
      title: 'Expense Tracker',
      slug: 'expense-tracker',
      shortDescription:
          'Production-ready finance app with multi-currency support, biometric authentication, and comprehensive export options.',
      fullDescription: '''
A comprehensive personal finance management application built with Flutter, designed to help users track their expenses and manage their budgets effectively.

This app demonstrates clean architecture principles, efficient state management, and a polished user experience that rivals commercial finance apps.

The project showcases my ability to build production-ready applications with attention to security, performance, and user experience.
      ''',
      mockupImage: AppAssets.mockupExpenseTracker,
      screenshots: const [],
      technologies: const [
        'Flutter',
        'Dart',
        'Hive',
        'Provider',
        'PDF',
        'Excel',
      ],
      category: ProjectCategory.fintech,
      status: ProjectStatus.completed,
      githubUrl: AppUrls.expenseTrackerRepo,
      features: const [
        'Multi-currency support with real-time conversion',
        'Biometric authentication (Face ID / Fingerprint)',
        'Export to PDF and Excel formats',
        'Beautiful charts and analytics',
        'Category-wise expense tracking',
        'Budget goals and notifications',
        'Dark/Light theme support',
        'Offline-first architecture',
      ],
      challenges: const [
        'Implementing secure biometric authentication across platforms',
        'Building a robust offline-first sync mechanism',
        'Creating performant chart visualizations with large datasets',
      ],
      impact:
          'Open source project helping developers learn Flutter best practices',
      completedAt: DateTime(2025, 1, 15),
      isFeatured: true,
      accentColor: AppColors.success,
    ),

    Project(
      id: '2',
      title: 'Custom Ruler',
      slug: 'custom-ruler',
      shortDescription:
          'A highly customizable Flutter package for creating beautiful ruler widgets with horizontal/vertical orientations.',
      fullDescription: '''
Custom Ruler is a Flutter package that provides a highly customizable ruler widget for measurement and selection purposes.

Published on pub.dev, this package demonstrates my commitment to the Flutter community and open-source development. It's designed with flexibility in mind, allowing developers to customize every aspect of the ruler's appearance.

The package follows Flutter's best practices for package development and includes comprehensive documentation and examples.
      ''',
      mockupImage: AppAssets.mockupCustomRuler,
      screenshots: const [],
      technologies: const ['Flutter', 'Dart', 'Custom Painter', 'pub.dev'],
      category: ProjectCategory.package,
      status: ProjectStatus.maintenance,
      pubDevUrl: AppUrls.customRulerPackage,
      githubUrl: 'https://github.com/sanaullah49/custom_ruler',
      features: const [
        'Horizontal and vertical orientations',
        'Customizable tick marks and labels',
        'Smooth scrolling with physics',
        'Configurable scale and units',
        'Callback for value changes',
        'Haptic feedback support',
        'RTL language support',
      ],
      challenges: const [
        'Optimizing CustomPainter for smooth performance',
        'Handling edge cases for different screen sizes',
        'Creating an intuitive API for developers',
      ],
      impact: 'Published package used by Flutter developers worldwide',
      completedAt: DateTime(2025, 2, 1),
      isFeatured: true,
      accentColor: AppColors.accent,
    ),

    Project(
      id: '3',
      title: 'Medical Device App',
      slug: 'medical-device-app',
      shortDescription:
          'Native Android app for serial port communication with medical hardware devices and real-time device data capture.',
      fullDescription: '''
A specialized healthcare application that interfaces with medical devices through serial port communication, enabling real-time device data capture and analysis.

This project required deep understanding of hardware communication protocols, Android's USB/Serial APIs, and strict adherence to healthcare data standards.

Built primarily in Java with Android SDK, demonstrating my versatility beyond Flutter when project requirements demand native solutions.
      ''',
      mockupImage: AppAssets.mockupMedicalDevice,
      screenshots: const [],
      technologies: const [
        'Java',
        'Android SDK',
        'Serial Communication',
        'USB API',
      ],
      category: ProjectCategory.healthcare,
      status: ProjectStatus.completed,
      features: const [
        'Real-time serial port communication',
        'Medical device data parsing',
        'Health metrics visualization',
        'Data export and reporting',
        'HIPAA-compliant data handling',
        'Offline data storage',
        'Alert system for abnormal readings',
      ],
      challenges: const [
        'Implementing reliable serial communication with various devices',
        'Ensuring data accuracy for medical-grade applications',
        'Meeting healthcare compliance requirements',
      ],
      impact:
          'Deployed in healthcare facilities for reliable device data workflows',
      completedAt: DateTime(2025, 1, 1),
      isFeatured: true,
      accentColor: AppColors.error,
    ),

    Project(
      id: '4',
      title: 'Anime Wallpaper Maker',
      slug: 'anime-wallpaper-maker',
      shortDescription:
          'Feature-rich wallpaper app with video wallpapers, customization options, and a vast collection of anime-themed content.',
      fullDescription: '''
A creative wallpaper application that allows users to discover, customize, and set beautiful anime-themed wallpapers on their devices.

Features include video wallpapers, live wallpapers, and extensive customization options. The app has been published on the Play Store and serves thousands of users.

This project showcases my ability to build consumer-facing products with engaging user experiences and monetization strategies.
      ''',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      screenshots: const [],
      technologies: const [
        'Flutter',
        'Dart',
        'AdMob',
        'Firebase',
        'Video Player',
      ],
      category: ProjectCategory.utility,
      status: ProjectStatus.completed,
      playStoreUrl: AppUrls.animeWallpaperApp,
      features: const [
        'Vast collection of anime wallpapers',
        'Video and live wallpaper support',
        'Category-based browsing',
        'Favorites and collections',
        'Easy wallpaper setting',
        'Download for offline use',
        'Share with friends',
        'Regular content updates',
      ],
      challenges: const [
        'Optimizing video playback for battery efficiency',
        'Managing large image assets efficiently',
        'Implementing effective ad placement without hurting UX',
      ],
      impact: 'Published on Play Store with active user base',
      completedAt: DateTime(2025, 1, 20),
      isFeatured: true,
      accentColor: AppColors.secondary,
    ),

    Project(
      id: '5',
      title: 'Izzana Ordering App',
      slug: 'izzana-ordering',
      shortDescription:
          'Restaurant ordering and operations app with offline-first architecture and real-time sync.',
      fullDescription: '''
A comprehensive ordering solution designed specifically for restaurants, featuring order management, table tracking, and payment flows.

Built with an offline-first approach to ensure reliability even without internet connectivity, with seamless sync when connection is restored.

The app received a 4.5+ star rating for its intuitive Material Design UI/UX.
      ''',
      mockupImage: AppAssets.mockupPOS,
      screenshots: const [],
      technologies: const ['Flutter', 'Firebase', 'Stripe', 'SQLite', 'Bloc'],
      category: ProjectCategory.ecommerce,
      status: ProjectStatus.completed,
      features: const [
        'Order management system',
        'Table tracking and reservation',
        'Stripe payment integration',
        'Offline-first with sync',
        'Kitchen display system',
        'Receipt printing',
        'Sales analytics and reports',
        'Staff management',
      ],
      challenges: const [
        'Building reliable offline-first sync mechanism',
        'Coordinating payment and order workflows across shifts',
        'Creating intuitive UI for fast-paced restaurant environment',
      ],
      impact: 'Achieved 4.5+ star rating, used by multiple restaurants',
      completedAt: DateTime(2023, 6, 1),
      isFeatured: false,
      accentColor: AppColors.warning,
    ),

    Project(
      id: '6',
      title: 'Khareedo Farokht',
      slug: 'khareedo-farokht',
      shortDescription:
          'E-commerce marketplace app with vendor management, real-time chat, and comprehensive shopping features.',
      fullDescription: '''
A full-featured e-commerce platform connecting buyers and sellers with real-time communication and secure payment processing.

The app includes vendor storefronts, product management, cart functionality, wishlists, and a complete checkout flow.

Built with scalability in mind to handle growing user bases and product catalogs.
      ''',
      mockupImage: AppAssets.mockupEcommerce,
      screenshots: const [],
      technologies: const [
        'Flutter',
        'Firebase',
        'REST API',
        'JWT',
        'Provider',
      ],
      category: ProjectCategory.ecommerce,
      status: ProjectStatus.completed,
      features: const [
        'Vendor marketplace',
        'Product catalog management',
        'Shopping cart and wishlist',
        'Real-time chat with vendors',
        'JWT authentication',
        'Payment gateway integration',
        'Order tracking',
        'Reviews and ratings',
      ],
      challenges: const [
        'Implementing real-time chat at scale',
        'Building secure authentication system',
        'Managing complex state across the app',
      ],
      impact: 'Connects local vendors with customers across the region',
      completedAt: DateTime(2023, 3, 1),
      isFeatured: false,
      accentColor: AppColors.primary,
    ),

    Project(
      id: '8',
      title: 'File Manager Pro',
      slug: 'file-manager-pro',
      shortDescription:
          'Advanced file manager with cloud integration, secure vault, and comprehensive file operations.',
      fullDescription: '''
A powerful file management application offering advanced features like cloud storage integration, secure file vault, and batch operations.

Published on the Play Store as part of the utility apps collection at Mega Minds Studio.
      ''',
      mockupImage: AppAssets.placeholderProject,
      screenshots: const [],
      technologies: const ['Flutter', 'Dart', 'Hive', 'Encryption', 'AdMob'],
      category: ProjectCategory.utility,
      status: ProjectStatus.completed,
      features: const [
        'File browsing and management',
        'Cloud storage integration',
        'Secure vault with encryption',
        'Batch file operations',
        'Search functionality',
        'Favorites and recent files',
        'Multiple view modes',
      ],
      challenges: const [
        'Implementing secure file encryption',
        'Handling large file operations efficiently',
        'Creating intuitive file navigation UX',
      ],
      impact: 'Part of a broader Play Store portfolio of consumer utility apps',
      completedAt: DateTime(2024, 2, 1),
      isFeatured: false,
      accentColor: AppColors.info,
    ),
    ..._expandedPortfolioProjects,
    ..._publisherPackageProjects,
  ];

  static final List<Project> _expandedPortfolioProjects = [
    _portfolioProject(
      id: '9',
      title: 'RoadmapForge',
      slug: 'roadmapforge',
      shortDescription:
          'Next.js customer feedback and public roadmap platform built for small B2B SaaS teams.',
      fullDescription: '''
RoadmapForge is a customer feedback and roadmap platform built with Next.js and deployed on Vercel.

It gives small B2B SaaS teams a branded feedback board, a public roadmap, and an internal workspace for triaging requests, tracking votes, and sharing product updates in one place.

The product was built quickly with a strong product-first mindset, pairing a polished marketing experience with a workflow that helps founders replace scattered support conversations with one clear feedback loop.
      ''',
      mockupImage: AppAssets.placeholderProject,
      technologies: const ['Next.js', 'TypeScript', 'Tailwind CSS', 'Vercel'],
      category: ProjectCategory.webApp,
      liveUrl: 'https://roadmapforge.vercel.app/',
      features: const [
        'Public feedback board and roadmap',
        'Request voting and prioritization',
        'Admin workspace for triage and updates',
        'Pricing, demo, and onboarding flows',
        'API and webhook-ready product positioning',
      ],
      challenges: const [
        'Designing a simple feedback workflow for small SaaS teams',
        'Balancing polished marketing with product usability',
        'Shipping a cohesive MVP quickly without losing quality',
      ],
      impact:
          'Live product site and SaaS prototype built end-to-end with Next.js.',
      isFeatured: true,
      accentColor: AppColors.info,
    ),
    _portfolioProject(
      id: '10',
      title: 'Waterfall Wallpaper Live',
      slug: 'waterfall-wallpaper-live',
      shortDescription:
          'Live wallpaper app featuring waterfall scenes, motion backgrounds, and quick personalization.',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      technologies: const ['Flutter', 'Dart', 'AdMob', 'Video Player'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.rsapps.waterfall.wallpaper.live',
      impact:
          'Published on Google Play as part of a growing wallpaper app portfolio.',
      accentColor: AppColors.secondary,
    ),
    _portfolioProject(
      id: '11',
      title: 'Love Status Video Quotes',
      slug: 'love-status-video-quotes',
      shortDescription:
          'Shareable video status and quote app centered on love-themed short-form content.',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      technologies: const ['Flutter', 'Dart', 'Firebase', 'AdMob'],
      category: ProjectCategory.mobileApp,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.rsapps.love.status.video.quotes',
      impact:
          'Built for high-frequency browsing and sharing in a lightweight consumer app flow.',
      accentColor: AppColors.error,
    ),
    _portfolioProject(
      id: '12',
      title: 'Live Video Wallpaper',
      slug: 'live-video-wallpaper',
      shortDescription:
          'Video wallpaper utility for applying animated backgrounds to the home and lock screen.',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      technologies: const ['Flutter', 'Dart', 'Video Player', 'AdMob'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.offlinestudio.live.video.wallpaper.video_wall',
      impact:
          'Published as part of a consumer utility lineup focused on media-rich personalization.',
      accentColor: AppColors.secondary,
    ),
    _portfolioProject(
      id: '13',
      title: 'Signature Maker Sign Creator',
      slug: 'signature-maker-sign-creator',
      shortDescription:
          'Digital signature utility for creating stylized signatures and quick sign assets on mobile.',
      technologies: const ['Flutter', 'Dart', 'Custom Paint', 'PDF'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.docusign.signaturemaker.signcreator',
      impact:
          'Built to streamline signature creation into a fast, single-purpose mobile workflow.',
      accentColor: AppColors.info,
    ),
    _portfolioProject(
      id: '14',
      title: 'One Anime Piece Wallpapers Live',
      slug: 'one-anime-piece-wallpapers-live',
      shortDescription:
          'Anime-focused wallpaper app with themed live backgrounds and fan-oriented customization.',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      technologies: const ['Flutter', 'Dart', 'AdMob', 'Video Player'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.ccapps.ONEanimePiece.wallpapersLive',
      impact:
          'Expanded the themed wallpaper catalog with a niche audience-focused release.',
      accentColor: AppColors.secondary,
    ),
    _portfolioProject(
      id: '15',
      title: 'Dragon Wallpapers Live',
      slug: 'dragon-wallpapers-live',
      shortDescription:
          'Wallpaper app featuring dragon-themed static and animated backgrounds for Android.',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      technologies: const ['Flutter', 'Dart', 'AdMob', 'Video Player'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.ims.dragon.wallpapers.live',
      impact:
          'Built as part of a themed live-wallpaper release cycle for Android users.',
      accentColor: AppColors.secondary,
    ),
    _portfolioProject(
      id: '16',
      title: 'Retro Gaming Wallpapers',
      slug: 'retro-gaming-wallpapers',
      shortDescription:
          'Retro gaming wallpaper app with nostalgic artwork, pixel-inspired themes, and curated backgrounds.',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      technologies: const ['Flutter', 'Dart', 'Firebase', 'AdMob'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.lgs.retroGaming.Wallpapers',
      impact:
          'Added a nostalgia-driven visual theme to the Play Store wallpaper portfolio.',
      accentColor: AppColors.warning,
    ),
    _portfolioProject(
      id: '17',
      title: 'Full Battery Charging Alarm',
      slug: 'full-battery-charging-alarm',
      shortDescription:
          'Battery alarm utility with low-battery alerts, full-charge alarms, and charging reminders.',
      technologies: const ['Flutter', 'Dart', 'Notifications', 'Android SDK'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.emt.lowbatteryalarm.chargealarm',
      impact:
          'Built for practical daily utility use with clear alert-focused UX.',
      accentColor: AppColors.warning,
    ),
    _portfolioProject(
      id: '18',
      title: 'Video Player',
      slug: 'video-player',
      shortDescription:
          'Offline video player with local media browsing, playback controls, and lightweight navigation.',
      technologies: const ['Flutter', 'Dart', 'Video Player', 'File Access'],
      category: ProjectCategory.utility,
      impact:
          'Created as a focused media utility with dependable playback and simple controls.',
      accentColor: AppColors.info,
    ),
    _portfolioProject(
      id: '19',
      title: 'PDF Master Pro',
      slug: 'pdf-master-pro',
      shortDescription:
          'PDF productivity app for reading, organizing, and sharing documents on Android.',
      technologies: const ['Flutter', 'Dart', 'PDF', 'File Management'],
      category: ProjectCategory.utility,
      impact:
          'Built around fast document access and lightweight file productivity on mobile.',
      accentColor: AppColors.info,
    ),
    _portfolioProject(
      id: '20',
      title: 'Ghost VPN',
      slug: 'ghost-vpn',
      shortDescription:
          'Privacy-focused VPN app for secure browsing and location switching on Android.',
      technologies: const ['Flutter', 'Dart', 'REST API', 'Android SDK'],
      category: ProjectCategory.utility,
      impact:
          'Added a privacy-focused networking tool to the broader utility app portfolio.',
      accentColor: AppColors.primary,
    ),
    _portfolioProject(
      id: '21',
      title: 'Full QR Suite',
      slug: 'full-qr-suite',
      shortDescription:
          'All-in-one QR scanner and generator with history, sharing, and utility tools.',
      technologies: const ['Flutter', 'Dart', 'Camera', 'QR'],
      category: ProjectCategory.utility,
      impact:
          'Designed as a practical scan-and-generate tool with fast everyday workflows.',
      accentColor: AppColors.accent,
    ),
    _portfolioProject(
      id: '22',
      title: 'Custom Icon Changer',
      slug: 'custom-icon-changer',
      shortDescription:
          'Android customization app for swapping launcher icons and personalizing home screen shortcuts.',
      technologies: const ['Flutter', 'Dart', 'Android Intents', 'Launcher'],
      category: ProjectCategory.utility,
      impact:
          'Built for Android personalization with a quick-create, low-friction setup flow.',
      accentColor: AppColors.secondary,
    ),
    _portfolioProject(
      id: '23',
      title: 'Easy Park',
      slug: 'easy-park',
      shortDescription:
          'Parking companion app for saving parked locations and simplifying everyday parking flows.',
      technologies: const ['Flutter', 'Dart', 'Maps', 'Location'],
      category: ProjectCategory.utility,
      impact:
          'Created around a simple location-based workflow with clear everyday utility.',
      accentColor: AppColors.warning,
    ),
    _portfolioProject(
      id: '24',
      title: 'Quotes App',
      slug: 'quotes-app',
      shortDescription:
          'Daily quotes app with themed collections, favorites, and simple sharing experiences.',
      technologies: const ['Flutter', 'Dart', 'Firebase', 'Share'],
      category: ProjectCategory.mobileApp,
      impact:
          'Delivered as a lightweight content app optimized for quick reading and sharing.',
      accentColor: AppColors.error,
    ),
    _portfolioProject(
      id: '25',
      title: 'Inventory Management System',
      slug: 'inventory-management-system',
      shortDescription:
          'Stock and inventory app for tracking products, movement, and reorder workflows.',
      mockupImage: AppAssets.mockupEcommerce,
      technologies: const ['Flutter', 'Dart', 'Firebase', 'SQLite'],
      category: ProjectCategory.ecommerce,
      impact:
          'Built to support operational inventory workflows with mobile-first usability.',
      accentColor: AppColors.primary,
    ),
    _portfolioProject(
      id: '26',
      title: 'Notes & Todo',
      slug: 'notes-and-todo',
      shortDescription:
          'Personal productivity app for notes, checklists, reminders, and daily planning.',
      technologies: const ['Flutter', 'Dart', 'Hive', 'Notifications'],
      category: ProjectCategory.utility,
      impact:
          'Focused on fast capture, reminders, and clean personal task management flows.',
      accentColor: AppColors.accent,
    ),
    _portfolioProject(
      id: '27',
      title: 'All Language Translator',
      slug: 'all-language-translator',
      shortDescription:
          'Multilingual translator app for quick text translation, sharing, and travel-friendly usage.',
      technologies: const ['Flutter', 'Dart', 'REST API', 'Localization'],
      category: ProjectCategory.utility,
      impact:
          'Built as a general-purpose translation tool with speed and simplicity as priorities.',
      accentColor: AppColors.info,
    ),
    _portfolioProject(
      id: '28',
      title: 'GPS Maps Navigation Live Route Finder',
      slug: 'gps-maps-navigation-live-route-finder',
      shortDescription:
          'Navigation utility with maps, route finding, and trip assistance for Android users.',
      technologies: const ['Flutter', 'Dart', 'Maps', 'Location'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.offlineapps.gps.maps.navigation.live.routefinder',
      impact:
          'Built around location-aware navigation flows and practical route support features.',
      accentColor: AppColors.primary,
    ),
    _portfolioProject(
      id: '29',
      title: 'Wallpaper Admin Panels & Dashboards',
      slug: 'wallpaper-admin-panels-dashboards',
      shortDescription:
          'Internal admin panels for managing wallpaper catalogs, dashboards, featured content, and app operations across multiple wallpaper products.',
      fullDescription: '''
An internal operations suite built to support the wallpaper app portfolio with centralized admin panels and dashboards.

These tools help manage wallpaper uploads, category curation, promotional sections, content moderation, and release-time operations across multiple consumer wallpaper apps.

The dashboards were designed to reduce repetitive manual work and make it easier to keep large wallpaper catalogs fresh, organized, and aligned with each app's theme.
      ''',
      technologies: const ['Flutter', 'Dart', 'Firebase', 'Analytics'],
      category: ProjectCategory.webApp,
      features: const [
        'Wallpaper upload and content curation',
        'Category and collection management',
        'Featured banners and release control',
        'Dashboard views for content operations',
        'Multi-app admin workflow support',
      ],
      challenges: const [
        'Keeping admin workflows simple across multiple apps',
        'Organizing large visual catalogs efficiently',
        'Reducing repeated manual content operations',
      ],
      impact:
          'Improved day-to-day content operations for the broader wallpaper app portfolio.',
      accentColor: AppColors.info,
    ),
    _portfolioProject(
      id: '30',
      title: 'PixEdge',
      slug: 'pixedge',
      shortDescription:
          '4K live wallpaper app with animated backgrounds, visual personalization, and media-rich Android wallpaper flows.',
      mockupImage: AppAssets.mockupAnimeWallpaper,
      technologies: const ['Flutter', 'Dart', 'AdMob', 'Video Player'],
      category: ProjectCategory.utility,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.cre8ivex.pixedge',
      impact:
          'Added another media-rich personalization app to the live wallpaper portfolio on Google Play.',
      accentColor: AppColors.secondary,
    ),
  ];

  static final List<Project> _publisherPackageProjects = OpenSourceData.packages
      .where((package) => package.name != 'custom_ruler')
      .toList()
      .asMap()
      .entries
      .map((entry) => _buildPublisherPackageProject(entry.value, entry.key))
      .toList();

  static Project _buildPublisherPackageProject(
    PubDevPackage package,
    int index,
  ) {
    final title = _packageTitle(package.name);
    final platforms = package.platforms.take(3);

    return Project(
      id: 'pkg-${index + 1}',
      title: title,
      slug: package.name.replaceAll('_', '-'),
      shortDescription: package.description,
      fullDescription:
          '''
$title is one of the Flutter packages published under my verified thesanaullah.dev publisher profile on pub.dev.

${package.description}

This project entry is generated from the publisher package catalog so the Packages filter stays aligned with the open source section and my current pub.dev listings.
      ''',
      mockupImage: AppAssets.placeholderProject,
      screenshots: const [],
      technologies: ['Flutter', 'Dart', ...platforms],
      category: ProjectCategory.package,
      status: ProjectStatus.maintenance,
      pubDevUrl: package.url,
      features: [
        'Published package version ${package.version}',
        '${package.pubPoints} pub points on pub.dev',
        if (package.downloads != null)
          '${package.downloads} downloads recorded on pub.dev',
        'Available for ${package.platforms.join(', ')}',
      ],
      impact: package.downloads != null
          ? '${package.pubPoints} pub points and ${package.downloads} downloads on pub.dev.'
          : '${package.pubPoints} pub points on pub.dev.',
      isFeatured: false,
      accentColor: _packageAccentColor(index),
    );
  }

  static String _packageTitle(String name) {
    const overrides = {
      'ai_kit': 'Assistant Kit',
      'arc_progress_ring': 'Arc Progress Ring',
      'auto_theme': 'Auto Theme',
      'custom_ruler': 'Custom Ruler',
      'flutter_build_doctor': 'Flutter Build Doctor',
      'flutter_lifecycle_guard': 'Flutter Lifecycle Guard',
      'flutter_wallpaper_plus': 'Flutter Wallpaper Plus',
      'goal_progress_indicator': 'Goal Progress Indicator',
      'hyper_table': 'Hyper Table',
      'magic_responsive': 'Magic Responsive',
      'vidkit': 'VidKit',
      'webify_toolkit': 'Webify Toolkit',
    };

    return overrides[name] ??
        name
            .split('_')
            .map(
              (segment) => segment.isEmpty
                  ? segment
                  : '${segment[0].toUpperCase()}${segment.substring(1)}',
            )
            .join(' ');
  }

  static Color _packageAccentColor(int index) {
    const palette = [
      AppColors.accent,
      AppColors.info,
      AppColors.primary,
      AppColors.success,
      AppColors.secondary,
      AppColors.warning,
    ];

    return palette[index % palette.length];
  }

  static Project _portfolioProject({
    required String id,
    required String title,
    required String slug,
    required String shortDescription,
    required List<String> technologies,
    required ProjectCategory category,
    String? fullDescription,
    String mockupImage = AppAssets.placeholderProject,
    String? playStoreUrl,
    String? liveUrl,
    String? impact,
    ProjectStatus status = ProjectStatus.completed,
    List<String> features = const [],
    List<String> challenges = const [],
    DateTime? completedAt,
    bool isFeatured = false,
    Color? accentColor,
  }) {
    return Project(
      id: id,
      title: title,
      slug: slug,
      shortDescription: shortDescription,
      fullDescription:
          fullDescription ??
          '''
$title is part of my production app portfolio and was built around a focused user workflow.

$shortDescription

The project reflects my experience shipping consumer utilities, content apps, and business tools with practical UX and release-ready polish.
      ''',
      mockupImage: mockupImage,
      screenshots: const [],
      technologies: technologies,
      category: category,
      status: status,
      liveUrl: liveUrl,
      playStoreUrl: playStoreUrl,
      features: features,
      challenges: challenges,
      impact: impact,
      completedAt: completedAt,
      isFeatured: isFeatured,
      accentColor: accentColor ?? category.color,
    );
  }

  static List<Project> get featuredProjects =>
      allProjects.where((p) => p.isFeatured).toList();

  static List<Project> getByCategory(ProjectCategory category) =>
      allProjects.where((p) => p.category == category).toList();

  static Project? getBySlug(String slug) {
    try {
      return allProjects.firstWhere((p) => p.slug == slug);
    } catch (e) {
      return null;
    }
  }

  static Project? getById(String id) {
    try {
      return allProjects.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<ProjectCategory> get availableCategories {
    final categories = allProjects.map((p) => p.category).toSet().toList();
    categories.sort((a, b) => a.index.compareTo(b.index));
    return categories;
  }
}
