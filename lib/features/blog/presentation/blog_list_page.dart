import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../data/blog_data.dart';
import '../models/blog_model.dart';
import '../widgets/blog_card.dart';

class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key});

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  BlogCategory? _selectedCategory;
  final List<BlogPost> _allPosts = BlogData.allPosts;

  List<BlogPost> get _filteredPosts {
    if (_selectedCategory == null) return _allPosts;
    return _allPosts.where((p) => p.category == _selectedCategory).toList();
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
            tag: 'BLOG',
            title: 'Articles & Tutorials',
            subtitle:
                'Sharing my journey, learnings, and technical guides on Flutter development',
          ),

          SizedBox(height: isMobile ? 32 : 48),

          _buildCategoryFilters(context),

          SizedBox(height: isMobile ? 32 : 48),

          _buildBlogGrid(context),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(BuildContext context) {
    final categories = BlogData.categories;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _BlogCategoryChip(
            label: 'All',
            isSelected: _selectedCategory == null,
            onTap: () => setState(() => _selectedCategory = null),
          ),

          const SizedBox(width: 12),

          ...categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _BlogCategoryChip(
                label: category.label,
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

  Widget _buildBlogGrid(BuildContext context) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    if (_filteredPosts.isEmpty) {
      return _buildEmptyState(context);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isMobile ? 0.9 : 0.85,
      ),
      itemCount: _filteredPosts.length,
      itemBuilder: (context, index) {
        return BlogCard(post: _filteredPosts[index]);
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
            Icons.search_off_rounded,
            size: 64,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No articles found',
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

class _BlogCategoryChip extends StatefulWidget {
  final String label;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;

  const _BlogCategoryChip({
    required this.label,
    this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_BlogCategoryChip> createState() => _BlogCategoryChipState();
}

class _BlogCategoryChipState extends State<_BlogCategoryChip> {
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
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              color: widget.isSelected
                  ? chipColor
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
