import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../router/route_names.dart';
import '../../open_source/data/open_source_data.dart';

class OpenSourceHighlightsSection extends StatelessWidget {
  const OpenSourceHighlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final contributions = OpenSourceData.selectedContributions;
    final mergedCount = contributions
        .where((item) => item.status.name == 'merged')
        .length;

    return SectionWrapper(
      sectionId: 'open-source',
      backgroundColor: context.isDarkMode
          ? AppColors.darkBg.withValues(alpha: 0.5)
          : AppColors.lightBgSecondary.withValues(alpha: 0.88),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'OPEN SOURCE',
            title: 'Open source, with the full context',
            subtitle:
                'If you want to judge the work itself instead of a decorative summary, this opens the complete page with the actual Flutter PRs, packages, repositories, and contribution history.',
          ),
          const SizedBox(height: 28),
          _OpenSourceGatewayCard(
            contributionCount: contributions.length,
            mergedCount: mergedCount,
            packageCount: OpenSourceData.packages.length,
          ),
        ],
      ),
    );
  }
}

class _OpenSourceGatewayCard extends StatefulWidget {
  final int contributionCount;
  final int mergedCount;
  final int packageCount;

  const _OpenSourceGatewayCard({
    required this.contributionCount,
    required this.mergedCount,
    required this.packageCount,
  });

  @override
  State<_OpenSourceGatewayCard> createState() => _OpenSourceGatewayCardState();
}

class _OpenSourceGatewayCardState extends State<_OpenSourceGatewayCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 700;
    final isCompact = MediaQuery.of(context).size.width < 980;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(RouteNames.openSource),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 20 : 28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      AppColors.primary.withValues(alpha: 0.16),
                      AppColors.accent.withValues(alpha: 0.1),
                      AppColors.secondary.withValues(alpha: 0.14),
                    ]
                  : [
                      AppColors.primary.withValues(alpha: 0.08),
                      AppColors.accent.withValues(alpha: 0.05),
                      AppColors.secondary.withValues(alpha: 0.08),
                    ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.42)
                  : AppColors.primary.withValues(alpha: 0.16),
              width: _isHovered ? 1.6 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.16)
                    : Colors.black.withValues(alpha: isDark ? 0.12 : 0.04),
                blurRadius: _isHovered ? 28 : 18,
                offset: Offset(0, _isHovered ? 16 : 10),
              ),
            ],
          ),
          transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _TopPill(
                    icon: Icons.open_in_new_rounded,
                    label: 'Open full page',
                    color: AppColors.primary,
                  ),
                  _MiniPill(label: '${widget.contributionCount} PRs'),
                  _MiniPill(label: '${widget.mergedCount} merged'),
                  _MiniPill(label: '${widget.packageCount} packages'),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'The point is signal, not decoration',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Text(
                  'If you are reviewing how I work in public, open this page. It shows the actual Flutter pull requests, the packages I maintain, the repositories behind them, and the contribution activity that gives the work real context.',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.8,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              if (isCompact)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'See the full open-source page',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: _isHovered
                            ? AppColors.primary
                            : colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'Flutter PRs, packages, repos, and activity',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        _ArrowCta(isHovered: _isHovered),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'See the full open-source page',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: _isHovered
                              ? AppColors.primary
                              : colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Flutter PRs, packages, repos, and activity',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _ArrowCta(isHovered: _isHovered),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrowCta extends StatelessWidget {
  final bool isHovered;

  const _ArrowCta({required this.isHovered});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isHovered ? 0.18 : 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.24)),
      ),
      child: Icon(
        Icons.arrow_forward_rounded,
        color: AppColors.primary,
        size: 20,
      ),
    );
  }
}

class _TopPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _TopPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: context.textTheme.labelLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  final String label;

  const _MiniPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        label,
        style: context.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
