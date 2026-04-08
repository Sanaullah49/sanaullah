import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../models/skill_model.dart';
import '../widgets/tech_stack_grid.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredTech = TechStackData.allTechnologies.where((tech) {
      const names = {
        'Flutter',
        'Dart',
        'Firebase',
        'REST API',
        'Bloc',
        'Riverpod',
        'SQLite',
        'Hive',
        'Git',
        'Figma',
        'Android',
        'iOS',
      };

      return names.contains(tech.name);
    }).toList();

    const pillars = [
      _SkillPillarData(
        title: 'Flutter Delivery',
        description:
            'Cross-platform product work with the polish needed for real releases, not just prototypes.',
        color: AppColors.primary,
        icon: Icons.phone_iphone_rounded,
        bullets: [
          'Responsive UI implementation',
          'Play Store and App Store shipping',
          'Performance tuning on real devices',
        ],
      ),
      _SkillPillarData(
        title: 'Architecture',
        description:
            'Codebases structured for iteration, debugging, and handoff as products grow.',
        color: AppColors.accent,
        icon: Icons.account_tree_rounded,
        bullets: [
          'Bloc, Riverpod, Provider',
          'Feature-based organization',
          'Readable state and data flow',
        ],
      ),
      _SkillPillarData(
        title: 'Integration Work',
        description:
            'Comfortable across APIs, storage, Firebase, and the practical details around shipping mobile products.',
        color: AppColors.secondary,
        icon: Icons.cloud_sync_rounded,
        bullets: [
          'REST APIs and Firebase',
          'Offline storage and sync',
          'Tooling, version control, and QA',
        ],
      ),
    ];

    return SectionWrapper(
      sectionId: 'skills',
      backgroundColor: context.isDarkMode
          ? AppColors.darkBgSecondary.withValues(alpha: 0.72)
          : AppColors.lightBgSecondary.withValues(alpha: 0.92),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'SKILLS',
            title: 'The stack is here, but the real value is how I use it',
            subtitle:
                'Yes, a portfolio should show skills. It just works better when they are framed as capability and delivery, not a random tech dump.',
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 900) {
                return Column(
                  children: pillars
                      .map(
                        (pillar) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _SkillPillarCard(data: pillar),
                        ),
                      )
                      .toList(),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: pillars.asMap().entries.map((entry) {
                  final index = entry.key;
                  final pillar = entry.value;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index == pillars.length - 1 ? 0 : 16,
                      ),
                      child: _SkillPillarCard(data: pillar),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 44),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.colorScheme.surface.withValues(
                alpha: context.isDarkMode ? 0.74 : 0.94,
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: context.colorScheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Core stack',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Text(
                    'A compact view is enough here. Visitors just need confidence in the tools you are strongest with.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      height: 1.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: featuredTech
                      .map((tech) => TechBadgeLarge(tech: tech))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillPillarData {
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final List<String> bullets;

  const _SkillPillarData({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.bullets,
  });
}

class _SkillPillarCard extends StatelessWidget {
  final _SkillPillarData data;

  const _SkillPillarCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: data.color.withValues(alpha: 0.22),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: data.color.withValues(
              alpha: context.isDarkMode ? 0.08 : 0.05,
            ),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(data.icon, color: data.color),
          ),
          const SizedBox(height: 18),
          Text(
            data.title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 18),
          ...data.bullets.map(
            (bullet) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: data.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      bullet,
                      style: context.textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
