import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../data/projects_data.dart';
import '../models/project_model.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  ProjectCategory? _selectedCategory;
  final List<Project> _allProjects = ProjectsData.allProjects;

  List<Project> get _filteredProjects {
    if (_selectedCategory == null) return _allProjects;
    return _allProjects.where((p) => p.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'MY WORK',
            title: 'All Projects',
            subtitle:
                'Explore my complete portfolio of mobile apps, packages, and open-source contributions',
          ),

          SizedBox(height: isMobile ? 32 : 48),

          _buildCategoryFilters(context),

          SizedBox(height: isMobile ? 32 : 48),

          _buildProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(BuildContext context) {
    final categories = ProjectsData.availableCategories;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _CategoryChip(
            label: 'All',
            icon: Icons.apps_rounded,
            isSelected: _selectedCategory == null,
            onTap: () => setState(() => _selectedCategory = null),
          ),

          const SizedBox(width: 12),

          ...categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _CategoryChip(
                label: category.label,
                icon: category.icon,
                color: category.color,
                isSelected: _selectedCategory == category,
                onTap: () => setState(() => _selectedCategory = category),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    if (_filteredProjects.isEmpty) {
      return _buildEmptyState(context);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isMobile ? 0.85 : 0.95,
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        return ProjectCard(project: _filteredProjects[index], index: index);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 64,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No projects found',
            style: context.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different category',
            style: context.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final chipColor = widget.color ?? colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? chipColor.withValues(alpha: 0.15)
                : (_isHovered
                      ? (isDark
                            ? AppColors.darkCard
                            : AppColors.lightBgSecondary)
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: widget.isSelected
                  ? chipColor.withValues(alpha: 0.6)
                  : (_isHovered
                        ? colorScheme.outline.withValues(alpha: 0.5)
                        : colorScheme.outline.withValues(alpha: 0.2)),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.isSelected
                    ? chipColor
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: widget.isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: widget.isSelected
                      ? chipColor
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
