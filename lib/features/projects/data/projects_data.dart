import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
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
          'Native Android app for serial port communication with medical hardware devices for real-time health monitoring.',
      fullDescription: '''
A specialized healthcare application that interfaces with medical devices through serial port communication, enabling real-time health data monitoring and analysis.

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
      impact: 'Deployed in healthcare facilities for patient monitoring',
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
      title: 'Izzana Restaurant POS',
      slug: 'izzana-pos',
      shortDescription:
          'Complete point-of-sale system for restaurants with offline-first architecture and real-time sync.',
      fullDescription: '''
A comprehensive POS solution designed specifically for restaurants, featuring order management, table tracking, and payment processing.

Built with an offline-first approach to ensure reliability even without internet connectivity, with seamless sync when connection is restored.

The app received a 4.5+ star rating for its intuitive Material Design UI/UX.
      ''',
      mockupImage: AppAssets.mockupPOS,
      screenshots: const [],
      technologies: const ['Flutter', 'Firebase', 'Stripe', 'SQLite', 'Bloc'],
      category: ProjectCategory.fintech,
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
        'Integrating with various payment providers',
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

    const Project(
      id: '7',
      title: 'Health Monitoring Suite',
      slug: 'health-monitoring-suite',
      shortDescription:
          'Flutter + Native Android health apps for real-time patient monitoring with medical device integration.',
      fullDescription: '''
A suite of health monitoring applications developed at Cross Sonic, interfacing with various medical devices for patient health tracking.

The project combines Flutter for the main interface with native Android components for hardware communication.

Implements clean architecture and SOLID principles, reducing codebase complexity by 30%.
      ''',
      mockupImage: AppAssets.mockupMedicalDevice,
      screenshots: [],
      technologies: ['Flutter', 'Java', 'Android SDK', 'Bluetooth', 'Firebase'],
      category: ProjectCategory.healthcare,
      status: ProjectStatus.inProgress,
      features: [
        'Real-time health metrics',
        'Medical device connectivity',
        'Patient data management',
        'Doctor dashboard',
        'Alert notifications',
        'Historical data analysis',
        'Compliance with health standards',
      ],
      challenges: [
        'Bridging Flutter and native Android for hardware access',
        'Ensuring real-time data accuracy',
        'Meeting healthcare regulatory requirements',
      ],
      impact: 'Used in healthcare facilities for patient care',
      completedAt: null,
      isFeatured: false,
      accentColor: AppColors.error,
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
      impact: 'Part of 10+ apps published on Play Store',
      completedAt: DateTime(2024, 2, 1),
      isFeatured: false,
      accentColor: AppColors.info,
    ),
  ];

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
