import '../../../core/theme/app_colors.dart';
import '../models/experience_model.dart';

class ExperienceData {
  ExperienceData._();

  static final List<Experience> experiences = [
    Experience(
      id: '1',
      title: 'Flutter Developer',
      company: 'Cross Sonic Pvt LTD',
      location: 'Lahore, Pakistan',
      type: 'Full-time',
      startDate: DateTime(2024, 7),
      endDate: null,
      description:
          'Leading mobile development initiatives for healthcare applications, '
          'focusing on medical device integration and real-time health monitoring solutions.',
      responsibilities: [
        'Building serial communication apps for medical devices',
        'Developing health monitoring apps using Flutter and native Android',
        'Implementing clean architecture and SOLID principles',
        'Mentoring junior developers and conducting code reviews',
      ],
      achievements: [
        'Built serial communication app enabling real-time hardware interfacing',
        'Reduced codebase complexity by 30% through architectural improvements',
        'Successfully mentored 3 junior developers',
        'Implemented weekly code review process improving code quality',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Java',
        'Android SDK',
        'Serial Communication',
        'Bloc',
        'Clean Architecture',
      ],
      accentColor: AppColors.primary,
    ),
    Experience(
      id: '2',
      title: 'Flutter Developer',
      company: 'Mega Minds Studio',
      location: 'Multan, Pakistan',
      type: 'Full-time',
      startDate: DateTime(2023, 6),
      endDate: DateTime(2024, 7),
      description:
          'Developed and published multiple consumer applications on Google Play Store, '
          'working with international clients on diverse mobile app projects.',
      responsibilities: [
        'Publishing apps on Play Store including wallpaper and utility apps',
        'Optimizing app performance and state management',
        'Integrating monetization solutions and analytics',
        'Managing client relationships and project deliverables',
      ],
      achievements: [
        'Published 10+ apps on Play Store with strong user ratings',
        'Reduced app load time by 40% through optimized state management',
        'Increased revenue by 25% through strategic ad integration',
        'Maintained 100% client satisfaction rate across 5 international clients',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'AdMob',
        'Provider',
        'GetX',
        'REST API',
      ],
      accentColor: AppColors.accent,
    ),
    Experience(
      id: '3',
      title: 'Flutter Developer',
      company: 'ITZone Technology',
      location: 'Multan, Pakistan',
      type: 'Full-time',
      startDate: DateTime(2023, 3),
      endDate: DateTime(2023, 6),
      description:
          'Developed a comprehensive restaurant POS application with offline-first '
          'architecture, payment integration, and intuitive Material Design UI.',
      responsibilities: [
        'Building Izzana Restaurant POS app from scratch',
        'Implementing offline-first architecture with real-time sync',
        'Integrating Stripe payments and Firebase notifications',
        'Creating intuitive UI/UX following Material Design guidelines',
      ],
      achievements: [
        'Delivered fully functional POS system used by restaurants',
        'Achieved 4.5+ star rating through intuitive UI/UX design',
        'Successfully integrated Stripe payment processing',
        'Implemented robust offline-first data sync mechanism',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'Stripe',
        'SQLite',
        'Bloc',
        'Push Notifications',
      ],
      accentColor: AppColors.warning,
    ),
    Experience(
      id: '4',
      title: 'Flutter Developer',
      company: 'Tech Storm Software House',
      location: 'Multan, Pakistan',
      type: 'Full-time',
      startDate: DateTime(2022, 11),
      endDate: DateTime(2023, 3),
      description:
          'Built e-commerce marketplace application with comprehensive vendor management, '
          'real-time chat functionality, and secure payment integration.',
      responsibilities: [
        'Developing Khareedo Farokht e-commerce app',
        'Implementing vendor management and real-time chat',
        'Building authentication and payment systems',
        'Creating cart, wishlist, and checkout flows',
      ],
      achievements: [
        'Launched full-featured e-commerce marketplace',
        'Implemented secure JWT authentication system',
        'Built real-time chat connecting buyers and sellers',
        'Integrated complete payment processing flow',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'REST API',
        'JWT',
        'Provider',
        'WebSocket',
      ],
      accentColor: AppColors.success,
    ),
  ];

  static final List<Education> education = [
    Education(
      id: '1',
      degree: 'Bachelor of Science',
      field: 'Information Technology',
      institution: 'University of Education, Lahore',
      location: 'Lahore, Pakistan',
      startDate: DateTime(2018),
      endDate: DateTime(2022),
      gpa: '3.54/4.00',
      achievements: [
        'Graduated with distinction',
        'Focused on software development and mobile technologies',
        'Active member of the programming society',
        'Completed cross-platform mobile app as final year project',
      ],
      accentColor: AppColors.info,
    ),
  ];

  static const List<Certification> certifications = [];

  static String get totalExperience {
    if (experiences.isEmpty) return '0 years';

    final firstJob = experiences.last.startDate;
    final now = DateTime.now();
    final years = now.year - firstJob.year;

    if (years < 1) return 'Less than a year';
    if (years == 1) return '1+ year';
    return '$years+ years';
  }

  static Experience? get currentPosition {
    try {
      return experiences.firstWhere((e) => e.isCurrent);
    } catch (e) {
      return null;
    }
  }
}
