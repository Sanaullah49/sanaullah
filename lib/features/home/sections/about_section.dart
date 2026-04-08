import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final paragraphs = AppConstants.aboutDescription
        .trim()
        .split('\n\n')
        .where((item) => item.trim().isNotEmpty)
        .toList();

    return SectionWrapper(
      sectionId: 'about',
      backgroundColor: context.isDarkMode
          ? AppColors.darkBgSecondary.withValues(alpha: 0.8)
          : AppColors.lightBgSecondary.withValues(alpha: 0.8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            const SectionTitle(
              tag: 'WHY ME',
              title: 'Thoughtful delivery, not just Flutter implementation',
              subtitle:
                  'I work best with founders and product teams who need someone dependable across product polish, architecture, and shipping.',
            ),
            const SizedBox(height: 64),
            LayoutBuilder(
              builder: (context, constraints) {
                final useColumn = constraints.maxWidth < 940;

                return useColumn
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AboutNarrative(paragraphs: paragraphs),
                          const SizedBox(height: 28),
                          const _AboutStrengths(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _AboutNarrative(paragraphs: paragraphs),
                          ),
                          const SizedBox(width: 32),
                          const Expanded(flex: 5, child: _AboutStrengths()),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutNarrative extends StatelessWidget {
  final List<String> paragraphs;

  const _AboutNarrative({required this.paragraphs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...paragraphs.map(
          (paragraph) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text(
              paragraph,
              style: context.textTheme.bodyLarge?.copyWith(height: 1.85),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: const [
            _MetricCard(
              value: '25+',
              label: 'Products released',
              icon: Icons.rocket_launch_rounded,
            ),
            _MetricCard(
              value: '3',
              label: 'Core domains',
              icon: Icons.layers_rounded,
            ),
            _MetricCard(
              value: '2',
              label: 'Store ecosystems',
              icon: Icons.phone_iphone_rounded,
            ),
          ],
        ),
      ],
    );
  }
}

class _AboutStrengths extends StatelessWidget {
  const _AboutStrengths();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _StrengthCard(
          icon: Icons.architecture_rounded,
          title: 'Architecture that stays readable',
          description:
              'I care about codebases that support iteration, onboarding, and debugging after the first release.',
        ),
        SizedBox(height: 16),
        _StrengthCard(
          icon: Icons.speed_rounded,
          title: 'Calm product polish',
          description:
              'UI states, edge cases, performance, and release details get attention because they shape trust.',
        ),
        SizedBox(height: 16),
        _StrengthCard(
          icon: Icons.forum_rounded,
          title: 'Clear collaboration',
          description:
              'You get honest technical judgment, predictable progress, and communication that reduces ambiguity.',
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _MetricCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            value,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(height: 1.55),
          ),
        ],
      ),
    );
  }
}

class _StrengthCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _StrengthCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.accent),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: context.textTheme.bodyMedium?.copyWith(height: 1.7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
