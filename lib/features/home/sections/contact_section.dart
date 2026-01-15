import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../core/widgets/social_button.dart';
import '../../testimonials/widgets/testimonial_stats.dart';
import '../widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3) {}
      },
      child: SectionWrapper(
        sectionId: 'contact',
        backgroundColor: context.isDarkMode
            ? AppColors.darkBgSecondary
            : AppColors.lightBgSecondary,
        child: Column(
          children: [
            SectionTitle(
              tag: 'CONTACT',
              title: "Let's Build Something Great",
              subtitle:
                  "Serious about a high-impact Flutter app? Drop your idea below – I reply within 12–24 hours.",
              centerAlign: true,
            ),

            const SizedBox(height: 32),

            const TestimonialStatsInline(),

            const SizedBox(height: 48),

            LayoutBuilder(
              builder: (context, constraints) {
                final bool useColumn = isMobile || constraints.maxWidth < 1000;

                if (useColumn) {
                  return const Column(
                    children: [
                      _ContactInfoCard(),
                      SizedBox(height: 32),
                      ContactForm(),
                    ],
                  );
                }

                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _ContactInfoCard()),
                    SizedBox(width: 48),
                    Expanded(flex: 6, child: ContactForm()),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  const _ContactInfoCard();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Perfect if you...',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _buildBullet(
            'Want a Flutter expert from idea → Play Store launch',
            context,
          ),
          _buildBullet(
            'Care about clean code, performance & scalability',
            context,
          ),
          _buildBullet(
            'Value clear deadlines & honest technical feedback',
            context,
          ),
          _buildBullet(
            'Are ready to invest in a revenue-generating product',
            context,
          ),

          const SizedBox(height: 32),

          Text(
            'Get in touch',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          _ContactTile(
            icon: Icons.email_rounded,
            title: 'Email (Recommended)',
            value: 'sanaullah49@gmail.com',
            onTap: () => UrlLauncherUtils.launchEmail(
              subject: 'Flutter Project – Let\'s Talk!',
            ),
          ),
          const SizedBox(height: 12),
          _ContactTile(
            icon: Icons.chat_rounded,
            title: 'WhatsApp',
            value: '+92 336 2451056',
            onTap: () => UrlLauncherUtils.launchWhatsApp(
              message:
                  'Hi Sana! I have a Flutter project I\'d love to discuss.',
            ),
          ),
          const SizedBox(height: 12),
          _ContactTile(
            icon: Icons.calendar_today_rounded,
            title: 'Schedule a Call',
            value: 'Book 15-min discovery call',
            onTap: () => UrlLauncherUtils.openCalendly(),
          ),

          const SizedBox(height: 32),

          const Text(
            'Or reach me directly',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
        ],
      ),
    );
  }

  Widget _buildBullet(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkBgTertiary
              : AppColors.lightBgSecondary.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
