import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/about/about_page.dart';
import '../features/blog/presentation/blog_detail_page.dart';
import '../features/blog/presentation/blog_list_page.dart';
import '../features/hire_me/hire_me_page.dart';
import '../features/home/home_page.dart';
import '../features/projects/presentation/project_detail_page.dart';
import '../features/projects/presentation/projects_page.dart';
import '../shared/layouts/main_layout.dart';
import '../shared/widgets/not_found_page.dart';
import 'page_transitions.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.home,
    debugLogDiagnostics: true,

    errorBuilder: (context, state) => const NotFoundPage(),

    observers: [RouteObserver<ModalRoute<void>>()],

    redirect: (context, state) {
      return null;
    },

    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(currentPath: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: RouteNames.home,
            name: 'home',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder: PageTransitions.fadeTransition,
            ),
          ),

          GoRoute(
            path: RouteNames.about,
            name: 'about',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AboutPage(),
              transitionsBuilder: PageTransitions.slideUpTransition,
            ),
          ),

          GoRoute(
            path: RouteNames.projects,
            name: 'projects',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const ProjectsPage(),
              transitionsBuilder: PageTransitions.slideUpTransition,
            ),
            routes: [
              GoRoute(
                path: ':slug',
                name: 'project-detail',
                pageBuilder: (context, state) {
                  final slug = state.pathParameters['slug'] ?? '';
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: ProjectDetailPage(slug: slug),
                    transitionsBuilder: PageTransitions.slideLeftTransition,
                  );
                },
              ),
            ],
          ),

          GoRoute(
            path: RouteNames.blog,
            name: 'blog',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const BlogListPage(),
              transitionsBuilder: PageTransitions.slideUpTransition,
            ),
            routes: [
              GoRoute(
                path: ':slug',
                name: 'blog-detail',
                pageBuilder: (context, state) {
                  final slug = state.pathParameters['slug'] ?? '';
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: BlogDetailPage(slug: slug),
                    transitionsBuilder: PageTransitions.slideLeftTransition,
                  );
                },
              ),
            ],
          ),

          GoRoute(
            path: RouteNames.hireMe,
            name: 'hire-me',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HireMePage(),
              transitionsBuilder: PageTransitions.scaleTransition,
            ),
          ),

          GoRoute(
            path: RouteNames.contact,
            name: 'contact',
            redirect: (context, state) => RouteNames.hireMe,
          ),
        ],
      ),
    ],
  );
});

extension GoRouterExtension on BuildContext {
  void goHome() => go(RouteNames.home);

  void goAbout() => go(RouteNames.about);

  void goProjects() => go(RouteNames.projects);

  void goProjectDetail(String slug) => go('${RouteNames.projects}/$slug');

  void goBlog() => go(RouteNames.blog);

  void goBlogPost(String slug) => go('${RouteNames.blog}/$slug');

  void goHireMe() => go(RouteNames.hireMe);

  void goBack() => pop();

  bool get canGoBack => canPop();
}
