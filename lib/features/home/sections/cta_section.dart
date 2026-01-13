import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_urls.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/social_button.dart';
import '../../../router/route_names.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF020617),
                  Color(0xFF0F172A),
                  Color(0xFF020617),
                ],
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE0EAFF), Color(0xFFF5F3FF)],
              ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                AppConstants.ctaTitle,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                AppConstants.ctaSubtitle,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  PrimaryButton(
                    text: 'Hire Me',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: () => context.go(RouteNames.hireMe),
                  ),
                  SecondaryButton(
                    text: 'Email Me',
                    icon: Icons.email_rounded,
                    onPressed: () => UrlLauncherUtils.launchEmail(
                      subject: 'Project Inquiry - Flutter Developer',
                    ),
                  ),
                  SecondaryButton(
                    text: 'Buy Me a Coffee',
                    icon: Icons.local_cafe_rounded,
                    onPressed: () =>
                        UrlLauncherUtils.launchURL(AppUrls.buyMeACoffee),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
            ],
          ),
        ),
      ),
    );
  }
}
