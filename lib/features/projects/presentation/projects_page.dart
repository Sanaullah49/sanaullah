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

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: isMobile ? 40 : 80,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
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
        ),
      ),
    );
  }

  Widget _buildCategoryFilters(BuildContext context) {
    final categories = ProjectsData.availableCategories;
    final isMobile = context.isMobile;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 0),
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
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double childAspectRatio;
    double spacing;

    if (screenWidth < 600) {
      crossAxisCount = 1;
      childAspectRatio = 0.75;
      spacing = 20.0;
    } else if (screenWidth < 700) {
      crossAxisCount = 1;
      childAspectRatio = 0.85;
      spacing = 24.0;
    } else if (screenWidth < 900) {
      crossAxisCount = 2;
      childAspectRatio = 0.78;
      spacing = 20.0;
    } else if (screenWidth < 1100) {
      crossAxisCount = 2;
      childAspectRatio = 0.95;
      spacing = 24.0;
    } else if (screenWidth < 1400) {
      crossAxisCount = 2;
      childAspectRatio = 1.05;
      spacing = 28.0;
    } else {
      crossAxisCount = 3;
      childAspectRatio = 0.95;
      spacing = 32.0;
    }

    if (_filteredProjects.isEmpty) {
      return _buildEmptyState(context);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
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
    final isMobile = context.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 14 : 16,
            vertical: isMobile ? 8 : 10,
          ),
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
                size: isMobile ? 16 : 18,
                color: widget.isSelected
                    ? chipColor
                    : colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
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
