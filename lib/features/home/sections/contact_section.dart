import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../core/widgets/status_badge.dart';
import '../widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1000;

    return SectionWrapper(
      sectionId: 'contact',
      backgroundColor: context.isDarkMode
          ? AppColors.darkBgSecondary
          : AppColors.lightBgSecondary,
      child: Column(
        children: [
          const SectionTitle(
            tag: 'CONTACT',
            title: "Let's talk about the product, not just the stack",
            subtitle:
                "If you need help launching, stabilizing, or leveling up a Flutter app, send the brief and I'll reply with a grounded next step.",
            centerAlign: true,
          ),
          const SizedBox(height: 48),
          if (isMobile)
            const Column(
              children: [
                _ContactInfoCard(),
                SizedBox(height: 28),
                ContactForm(),
              ],
            )
          else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _ContactInfoCard()),
                SizedBox(width: 40),
                Expanded(flex: 6, child: ContactForm()),
              ],
            ),
        ],
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

    return Container(
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
          const StatusBadge(text: 'Usually replies within 12-24 hours'),
          const SizedBox(height: 22),
          Text(
            'Best fit if you need help with...',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          _buildBullet(
            'Shipping a new Flutter product from zero to release',
            context,
          ),
          _buildBullet(
            'Stabilizing an existing app with better structure and polish',
            context,
          ),
          _buildBullet(
            'Building product features that need careful UX and performance',
            context,
          ),
          _buildBullet(
            'Working with someone who communicates clearly and flags risks early',
            context,
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBgTertiary
                  : AppColors.lightBgSecondary.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Direct contact',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _ContactTile(
                  icon: Icons.email_rounded,
                  title: 'Email',
                  value: AppConstants.email,
                  onTap: () => UrlLauncherUtils.launchEmail(
                    subject: 'Flutter Project Inquiry',
                  ),
                ),
                const SizedBox(height: 12),
                _ContactTile(
                  icon: Icons.chat_rounded,
                  title: 'WhatsApp',
                  value: AppConstants.phone,
                  onTap: () => UrlLauncherUtils.launchWhatsApp(
                    message:
                        'Hi Sana! I have a Flutter project I would like to discuss.',
                  ),
                ),
                const SizedBox(height: 12),
                _ContactTile(
                  icon: Icons.calendar_today_rounded,
                  title: 'Discovery Call',
                  value: 'Book a short intro call',
                  onTap: () => UrlLauncherUtils.openCalendly(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _ContactTile(
            icon: Icons.location_on_rounded,
            title: 'Based in',
            value: AppConstants.location,
          ),
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
  final VoidCallback? onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
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
                      color: onTap != null
                          ? AppColors.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_outward_rounded,
                size: 18,
                color: AppColors.primary.withValues(alpha: 0.7),
              ),
          ],
        ),
      ),
    );
  }
}
