import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
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

    return SectionWrapper(
      sectionId: 'contact',
      child: Column(
        children: [
          const SectionTitle(
            tag: 'CONTACT',
            title: 'Let\'s Talk About Your Project',
            subtitle:
                'Serious about building a high-impact Flutter app? Tell me about your idea and I\'ll help you turn it into a production-ready product.',
          ),

          SizedBox(height: isMobile ? 32 : 48),

          const TestimonialStatsInline(),

          SizedBox(height: isMobile ? 40 : 60),

          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile || constraints.maxWidth < 900) {
                return Column(
                  children: [
                    const _ContactInfoPanel(),
                    const SizedBox(height: 32),
                    const ContactForm(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(flex: 4, child: _ContactInfoPanel()),
                  SizedBox(width: 40),
                  Expanded(flex: 5, child: ContactForm()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactInfoPanel extends StatelessWidget {
  const _ContactInfoPanel();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Fit Check',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'I\'m a good fit if you:',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),

          _Bullet(
            text:
                'Need a Flutter expert to own your mobile app from idea to release',
          ),
          _Bullet(
            text:
                'Care about clean architecture, performance, and long-term maintainability',
          ),
          _Bullet(
            text:
                'Want clear communication, deadlines met, and honest technical feedback',
          ),
          _Bullet(
            text:
                'Are ready to invest in a product that can generate serious revenue',
          ),

          const SizedBox(height: 24),

          Text(
            'Contact methods',
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          _ContactMethodTile(
            icon: Icons.email_rounded,
            label: 'Email',
            value: AppConstants.email,
            description: 'Best for detailed project briefs & proposals',
            onTap: () => UrlLauncherUtils.launchEmail(
              subject: 'Project Inquiry - Flutter App',
            ),
          ),
          const SizedBox(height: 12),
          _ContactMethodTile(
            icon: Icons.chat_rounded,
            label: 'WhatsApp',
            value: '+92-336-2451056',
            description: 'Quick questions & time-sensitive communication',
            onTap: () => UrlLauncherUtils.launchWhatsApp(
              message:
                  'Hi Sana, I\'d like to discuss a Flutter project. Are you available?',
            ),
          ),
          const SizedBox(height: 12),
          _ContactMethodTile(
            icon: Icons.calendar_today_rounded,
            label: 'Schedule a Call',
            value: 'Book a 15-min discovery call',
            description: 'Perfect for high-level idea validation',
            onTap: () => UrlLauncherUtils.openCalendly(),
          ),

          const SizedBox(height: 24),

          Text(
            'Or connect directly',
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          const SocialButtonRow(showEmail: true, showBuyMeACoffee: true),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(3.5),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactMethodTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String description;
  final VoidCallback onTap;

  const _ContactMethodTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final isDark = context.isDarkMode;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBgTertiary : AppColors.lightBgSecondary,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.8,
                      ),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.open_in_new_rounded,
              size: 16,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}
