import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../router/route_names.dart';
import '../../blog/data/blog_data.dart';
import '../../blog/widgets/blog_card.dart';

class BlogSection extends StatefulWidget {
  const BlogSection({super.key});

  @override
  State<BlogSection> createState() => _BlogSectionState();
}

class _BlogSectionState extends State<BlogSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final recentPosts = BlogData.recentPosts;

    return VisibilityDetector(
      key: const Key('blog-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: SectionWrapper(
        sectionId: 'blog',
        child: Column(
          children: [
            const SectionTitle(
              tag: 'BLOG',
              title: 'Latest Articles',
              subtitle:
                  'Thoughts, tutorials, and insights on Flutter development and software engineering',
            ),

            SizedBox(height: isMobile ? 48 : 80),

            _buildBlogGrid(context, recentPosts),

            SizedBox(height: isMobile ? 48 : 64),

            _buildViewAllButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogGrid(BuildContext context, List<dynamic> posts) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: isMobile ? 0.9 : 0.85,
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 500 + (index * 150)),
              opacity: _isVisible ? 1.0 : 0.0,
              child: AnimatedSlide(
                duration: Duration(milliseconds: 500 + (index * 150)),
                offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                curve: Curves.easeOutCubic,
                child: BlogCard(post: posts[index]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildViewAllButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SecondaryButton(
          text: 'Read All Articles',
          icon: Icons.article_rounded,
          onPressed: () => context.go(RouteNames.blog),
        ),
      ],
    );
  }
}
