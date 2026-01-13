import '../../../core/constants/app_assets.dart';
import '../models/blog_model.dart';

class BlogData {
  BlogData._();

  static final List<BlogPost> allPosts = [
    BlogPost(
      id: '1',
      title: 'Clean Architecture in Flutter: A Practical Guide',
      slug: 'clean-architecture-flutter',
      excerpt:
          'Learn how to implement Clean Architecture in your Flutter apps to make them scalable, testable, and maintainable.',
      content: _cleanArchitectureContent,
      coverImage: AppAssets.placeholderBlog,
      publishedAt: DateTime(2025, 2, 1),
      tags: ['Flutter', 'Clean Architecture', 'SOLID', 'Riverpod'],
      readTime: 8,
      category: BlogCategory.architecture,
      isFeatured: true,
      views: 1250,
      likes: 45,
    ),
    BlogPost(
      id: '2',
      title: 'Mastering State Management with Riverpod',
      slug: 'mastering-riverpod',
      excerpt:
          'A comprehensive guide to using Riverpod for state management in Flutter applications, from basics to advanced patterns.',
      content: _riverpodContent,
      coverImage: AppAssets.placeholderBlog,
      publishedAt: DateTime(2025, 1, 15),
      tags: ['Flutter', 'Riverpod', 'State Management'],
      readTime: 6,
      category: BlogCategory.stateManagement,
      isFeatured: true,
      views: 980,
      likes: 32,
    ),
    BlogPost(
      id: '3',
      title: 'Optimizing Flutter App Performance',
      slug: 'flutter-performance',
      excerpt:
          'Tips and tricks to improve your Flutter app\'s performance, reduce jank, and ensure a smooth user experience.',
      content: _performanceContent,
      coverImage: AppAssets.placeholderBlog,
      publishedAt: DateTime(2024, 12, 20),
      tags: ['Flutter', 'Performance', 'Optimization'],
      readTime: 5,
      category: BlogCategory.flutter,
      isFeatured: false,
      views: 850,
      likes: 28,
    ),
    BlogPost(
      id: '4',
      title: 'Building Responsive UIs in Flutter',
      slug: 'responsive-ui-flutter',
      excerpt:
          'Learn how to create responsive layouts that look great on mobile, tablet, and desktop using Flutter.',
      content: _responsiveContent,
      coverImage: AppAssets.placeholderBlog,
      publishedAt: DateTime(2024, 11, 10),
      tags: ['Flutter', 'UI/UX', 'Responsive'],
      readTime: 7,
      category: BlogCategory.uiux,
      isFeatured: false,
      views: 1100,
      likes: 40,
    ),
  ];

  static List<BlogPost> get featuredPosts =>
      allPosts.where((p) => p.isFeatured).toList();

  static List<BlogPost> get recentPosts =>
      (allPosts..sort((a, b) => b.publishedAt.compareTo(a.publishedAt)))
          .take(3)
          .toList();

  static BlogPost? getBySlug(String slug) {
    try {
      return allPosts.firstWhere((p) => p.slug == slug);
    } catch (e) {
      return null;
    }
  }

  static List<BlogPost> getByCategory(BlogCategory category) {
    return allPosts.where((p) => p.category == category).toList();
  }

  static List<BlogCategory> get categories {
    return BlogCategory.values;
  }

  static const String _cleanArchitectureContent = '''
# Clean Architecture in Flutter

Clean Architecture is a software design philosophy that separates the elements of a design into ring levels. The main rule of Clean Architecture is that code dependencies can only move from the outer levels inward. Code on the inner layers can have no knowledge of functions on the outer layers.

## Why Use Clean Architecture?

1. **Separation of Concerns**: Each layer has a specific responsibility.
2. **Testability**: Business logic can be tested without UI or external dependencies.
3. **Independence**: UI, database, and frameworks can be changed without affecting business logic.

## The Layers

### 1. Domain Layer (Inner Layer)
This is the core of your application. It contains:
- **Entities**: Plain Dart objects representing your data.
- **Repositories (Interfaces)**: Abstract definitions of how data is accessed.
- **Use Cases**: Business logic encapsulating specific actions.

### 2. Data Layer (Middle Layer)
This layer implements the repositories defined in the domain layer. It contains:
- **Models**: Extensions of entities with JSON serialization logic.
- **Data Sources**: APIs for remote or local data access (e.g., REST API, Hive).
- **Repository Implementations**: The bridge between data sources and domain repositories.

### 3. Presentation Layer (Outer Layer)
This is where the UI lives. It contains:
- **State Management**: BLoC, Provider, or Riverpod logic.
- **Widgets**: Flutter widgets for displaying data.
- **Pages**: Screens of your application.

## Implementation Example

Here's a simple example of how to structure a feature using Clean Architecture...

// Domain: Entity
class User {
  final String id;
  final String name;
  const User({required this.id, required this.name});
}

// Domain: Repository Interface
abstract class UserRepository {
  Future<User> getUser(String id);
}

// Domain: Use Case
class GetUser {
  final UserRepository repository;
  GetUser(this.repository);
  
  Future<User> call(String id) {
    return repository.getUser(id);
  }
}
  
  ''';

  static const String _riverpodContent = '''
  Mastering Riverpod
Riverpod is a reactive caching and data-binding framework that was born as an evolution of the Provider package.

Why Riverpod?
Compile-safe: No more ProviderNotFoundException.
Testing: Built-in support for testing.
Independence: Doesn't depend on the widget tree.
Types of Providers
1. Provider
The most basic provider. Use it for values that don't change or for dependency injection.

2. StateProvider
For simple state that can be modified from outside.

3. FutureProvider
For asynchronous operations that return a value.

4. StreamProvider
For streams of data (e.g., Firebase Auth state).

5. StateNotifierProvider
For complex state management using a StateNotifier class.


  final counterProvider = StateProvider<int>((ref) => 0);

class CounterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      body: Center(child: Text('\$count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
  ''';

  static const String _performanceContent = '''

Optimizing Flutter App Performance
Flutter is fast by default, but complex apps can still suffer from performance issues if not built carefully.

Key Areas to Focus On
1. Build Method Optimization
Keep build() methods pure and fast.
Avoid expensive computations inside build().
Break down large widgets into smaller, const widgets.
2. List Rendering
Use ListView.builder for long lists.
Set itemExtent if items have fixed height.
Use const constructors for list items.
3. Image Caching
Use cached_network_image for remote images.
Resize images to the display size using cacheWidth and cacheHeight.
4. DevTools
Use the Performance Overlay to spot jank.

Check the Frame Rendering Chart.

Use the Timeline view to deep dive into frame builds.
''';

  static const String _responsiveContent = '''

Building Responsive UIs in Flutter
Creating apps that look good on all screen sizes is crucial in today's multi-device world.

Strategies
1. LayoutBuilder
Use LayoutBuilder to get the constraints of the parent widget and decide what to render.

2. MediaQuery
Use MediaQuery to get the size of the screen and current orientation.

3. Flexible & Expanded
Use Flexible and Expanded widgets to make children take up available space.

4. Adaptive Packages
Packages like flutter_adaptive_scaffold or responsive_framework can simplify the process.

Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return _buildDesktopLayout();
      } else {
        return _buildMobileLayout();
      }
    },
  );
}
''';
}
