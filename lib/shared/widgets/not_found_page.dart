import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/secondary_button.dart';
import '../../router/route_names.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                child: Text(
                  '404',
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: 150,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -5,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Page Not Found',
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Text(
                  "Oops! The page you're looking for doesn't exist or has been moved. Let's get you back on track.",
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),

              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  PrimaryButton(
                    text: 'Go Home',
                    icon: Icons.home_rounded,
                    onPressed: () => context.go(RouteNames.home),
                  ),
                  SecondaryButton(
                    text: 'View Projects',
                    icon: Icons.work_rounded,
                    onPressed: () => context.go(RouteNames.projects),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              Text(
                '🤔 Looking for something specific?',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.go(RouteNames.hireMe),
                child: const Text('Contact me and I\'ll help you out!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
