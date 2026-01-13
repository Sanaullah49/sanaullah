import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../router/route_names.dart';
import '../data/blog_data.dart';
import '../models/blog_model.dart';

class BlogDetailPage extends StatelessWidget {
  final String slug;

  const BlogDetailPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final post = BlogData.getBySlug(slug);

    if (post == null) {
      return _buildNotFound(context);
    }

    return _BlogPostContent(post: post);
  }

  Widget _buildNotFound(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article_outlined,
              size: 80,
              color: context.colorScheme.onSurfaceVariant.withValues(
                alpha: 0.5,
              ),
            ),
            const SizedBox(height: 24),
            Text('Article Not Found', style: context.textTheme.headlineMedium),
            const SizedBox(height: 16),
            Text(
              'The article you\'re looking for doesn\'t exist or has been removed.',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'View All Articles',
              icon: Icons.arrow_back_rounded,
              onPressed: () => context.go(RouteNames.blog),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlogPostContent extends StatelessWidget {
  final BlogPost post;

  const _BlogPostContent({required this.post});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final horizontalPadding = context.horizontalPadding;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 40 : 60,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetaInfo(context),

                  const SizedBox(height: 40),

                  _buildMarkdownContent(context),

                  const SizedBox(height: 60),

                  _buildTags(context),

                  const SizedBox(height: 40),

                  const Divider(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final categoryColor = post.category.color;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: isDark ? 0.1 : 0.05),
        border: Border(
          bottom: BorderSide(
            color: categoryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: TextButton.icon(
                  onPressed: () => context.go(RouteNames.blog),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Back to Blog'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Text(
              post.title,
              style: context.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaInfo(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final categoryColor = post.category.color;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: categoryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            post.category.label,
            style: TextStyle(
              color: categoryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),

        const Spacer(),

        Icon(
          Icons.calendar_today_rounded,
          size: 14,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          post.formattedDate,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(width: 16),

        Icon(
          Icons.access_time_rounded,
          size: 14,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          '${post.readTime} min read',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildMarkdownContent(BuildContext context) {
    final isDark = context.isDarkMode;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return MarkdownBody(
      data: post.content,
      selectable: true,
      onTapLink: (text, href, title) {
        if (href != null) {
          UrlLauncherUtils.launchURL(href);
        }
      },
      styleSheet: MarkdownStyleSheet(
        h1: textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        h2: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        h3: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        p: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          height: 1.8,
        ),
        listBullet: textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
        code: TextStyle(
          fontFamily: 'monospace',
          backgroundColor: isDark
              ? const Color(0xFF1E1E1E)
              : const Color(0xFFF5F5F5),
          color: isDark ? const Color(0xFFD4D4D4) : const Color(0xFF24292E),
          fontSize: 14,
        ),
        codeblockDecoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
        ),
        blockquote: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
          fontStyle: FontStyle.italic,
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: colorScheme.primary, width: 4),
          ),
        ),
      ),
    );
  }

  Widget _buildTags(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: post.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '#$tag',
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
        );
      }).toList(),
    );
  }
}
