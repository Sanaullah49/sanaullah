import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../models/skill_model.dart';
import '../widgets/skill_bar.dart';
import '../widgets/skill_card.dart';
import '../widgets/tech_stack_grid.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final isDark = context.isDarkMode;

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        color: isDark ? AppColors.darkBgSecondary : AppColors.lightBgSecondary,
        child: SectionWrapper(
          sectionId: 'skills',
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              const SectionTitle(
                tag: 'MY SKILLS',
                title: 'Technologies & Tools',
                subtitle:
                    'The tech stack I use to bring ideas to life and deliver exceptional results',
              ),

              SizedBox(height: isMobile ? 48 : 80),

              _buildSkillCategories(context),

              SizedBox(height: isMobile ? 48 : 80),

              _buildTechStackSection(context),

              SizedBox(height: isMobile ? 48 : 80),

              _buildProficiencySection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCategories(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    final categories = [
      SkillCategory(
        title: 'Mobile Development',
        icon: Icons.phone_android_rounded,
        color: AppColors.flutter,
        skills: ['Flutter', 'Dart', 'Android (Java/Kotlin)', 'iOS (Swift)'],
        description: 'Building native-quality cross-platform mobile apps',
      ),
      SkillCategory(
        title: 'State Management',
        icon: Icons.account_tree_rounded,
        color: AppColors.accent,
        skills: ['Provider', 'Bloc/Cubit', 'GetX', 'Riverpod'],
        description: 'Efficient state management for scalable apps',
      ),
      SkillCategory(
        title: 'Backend & Database',
        icon: Icons.storage_rounded,
        color: AppColors.firebase,
        skills: ['Firebase', 'REST APIs', 'SQLite', 'Hive', 'Isar'],
        description: 'Seamless data management and API integration',
      ),
      SkillCategory(
        title: 'Tools & Workflow',
        icon: Icons.build_rounded,
        color: AppColors.success,
        skills: ['Git/GitHub', 'VS Code', 'Android Studio', 'Figma', 'Postman'],
        description: 'Professional development workflow and collaboration',
      ),
    ];

    if (isMobile) {
      return Column(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildAnimatedCard(category, categories.indexOf(category)),
          );
        }).toList(),
      );
    }

    if (isTablet) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildAnimatedCard(categories[0], 0),
                const SizedBox(height: 24),
                _buildAnimatedCard(categories[2], 2),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                _buildAnimatedCard(categories[1], 1),
                const SizedBox(height: 24),
                _buildAnimatedCard(categories[3], 3),
              ],
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 3 ? 0 : 24),
            child: _buildAnimatedCard(category, index),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnimatedCard(SkillCategory category, int index) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500 + (index * 100)),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: Duration(milliseconds: 500 + (index * 100)),
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        curve: Curves.easeOutCubic,
        child: SkillCategoryCard(category: category),
      ),
    );
  }

  Widget _buildTechStackSection(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, colorScheme.primary],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'TECH STACK',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 40,
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, Colors.transparent],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        TechStackGrid(animate: _isVisible),
      ],
    );
  }

  Widget _buildProficiencySection(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final proficiencies = [
      SkillProficiency(
        name: 'Flutter & Dart',
        percentage: 95,
        color: AppColors.flutter,
      ),
      SkillProficiency(
        name: 'State Management (Bloc/Provider)',
        percentage: 90,
        color: AppColors.accent,
      ),
      SkillProficiency(
        name: 'Firebase & Backend Integration',
        percentage: 88,
        color: AppColors.firebase,
      ),
      SkillProficiency(
        name: 'UI/UX Implementation',
        percentage: 92,
        color: AppColors.figma,
      ),
      SkillProficiency(
        name: 'Clean Architecture & SOLID',
        percentage: 85,
        color: AppColors.success,
      ),
      SkillProficiency(
        name: 'Git & Version Control',
        percentage: 90,
        color: AppColors.git,
      ),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, colorScheme.primary],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'PROFICIENCY',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 40,
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, Colors.transparent],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: List.generate(proficiencies.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  opacity: _isVisible ? 1.0 : 0.0,
                  child: AnimatedSlide(
                    duration: Duration(milliseconds: 500 + (index * 100)),
                    offset: _isVisible ? Offset.zero : const Offset(-0.1, 0),
                    curve: Curves.easeOutCubic,
                    child: SkillBar(
                      proficiency: proficiencies[index],
                      animate: _isVisible,
                      delay: Duration(milliseconds: index * 150),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
