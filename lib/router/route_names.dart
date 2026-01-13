class RouteNames {
  RouteNames._();

  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String blog = '/blog';
  static const String hireMe = '/hire-me';
  static const String contact = '/contact';

  static const String heroSection = '#hero';
  static const String aboutSection = '#about';
  static const String skillsSection = '#skills';
  static const String projectsSection = '#projects';
  static const String experienceSection = '#experience';
  static const String testimonialsSection = '#testimonials';
  static const String blogSection = '#blog';
  static const String contactSection = '#contact';

  static String projectDetail(String slug) => '$projects/$slug';

  static String blogPost(String slug) => '$blog/$slug';

  static bool isActive(String currentPath, String route) {
    if (route == home) {
      return currentPath == home;
    }
    return currentPath.startsWith(route);
  }

  static String getPageTitle(String path) {
    if (path == home) return 'Home';
    if (path == about) return 'About';
    if (path.startsWith(projects)) return 'Projects';
    if (path.startsWith(blog)) return 'Blog';
    if (path == hireMe || path == contact) return 'Hire Me';
    return 'Page';
  }
}
