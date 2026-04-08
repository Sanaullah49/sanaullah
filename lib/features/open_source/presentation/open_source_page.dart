import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../router/route_names.dart';
import '../data/open_source_data.dart';
import '../models/github_models.dart';
import '../widgets/contribution_graph.dart';
import '../widgets/github_repo_card.dart';
import '../widgets/github_stats_card.dart';
import '../widgets/pub_dev_package_card.dart';

class OpenSourcePage extends StatelessWidget {
  const OpenSourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contributions = OpenSourceData.selectedContributions;
    final groupedContributions = _groupByRepository(contributions);
    final featuredContribution = contributions.firstWhere(
      (item) => item.status == ContributionStatus.merged,
      orElse: () => contributions.first,
    );
    final mergedCount = contributions
        .where((item) => item.status == ContributionStatus.merged)
        .length;
    final contributionAreas = contributions.map((item) => item.area).toSet();
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.horizontalPadding,
        vertical: isMobile ? 36 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopActions(
                isMobile: isMobile,
                onBackHome: () => context.go(RouteNames.home),
                onOpenGitHub: () => UrlLauncherUtils.launchURL(AppUrls.github),
                onOpenPubDev: () =>
                    UrlLauncherUtils.launchURL(AppUrls.pubDevProfile),
              ),
              SizedBox(height: isMobile ? 28 : 36),
              const SectionTitle(
                tag: 'OPEN SOURCE',
                title: 'How I Work In Public',
                subtitle:
                    'If you want to inspect the real work instead of a polished summary, this page shows the actual Flutter pull requests, packages, repositories, and contribution activity.',
                centerAlign: false,
              ),
              SizedBox(height: isMobile ? 20 : 28),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 16 : (isTablet ? 20 : 24)),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface.withValues(
                    alpha: context.isDarkMode ? 0.62 : 0.9,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: context.colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
                child: const GitHubStatsCard(),
              ),
              SizedBox(height: isMobile ? 28 : 36),
              _SectionBlock(
                title: 'Contribution Activity',
                subtitle:
                    'A quick view of recent contribution volume before you drill into the actual pull requests below.',
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 12 : (isTablet ? 16 : 18)),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface.withValues(
                      alpha: context.isDarkMode ? 0.62 : 0.9,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: context.colorScheme.outline.withValues(alpha: 0.1),
                    ),
                  ),
                  child: ContributionGraph(
                    contributions: OpenSourceData.generateMockContributions(),
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 28 : 36),
              _LedgerOverviewBand(
                contributionCount: contributions.length,
                mergedCount: mergedCount,
                packageCount: OpenSourceData.packages.length,
                repositoryCount: groupedContributions.length,
                contributionAreas: contributionAreas.toList(),
              ),
              SizedBox(height: isMobile ? 24 : 28),
              _FeaturedContributionPanel(contribution: featuredContribution),
              SizedBox(height: isMobile ? 28 : 36),
              _SectionBlock(
                title: 'Contribution Ledger',
                subtitle:
                    'Grouped by repository so you can scan what changed, where it landed, and how broad the work is getting over time.',
                child: Column(
                  children: groupedContributions.entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: _RepositoryLedgerGroup(
                            repository: entry.key,
                            contributions: entry.value,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: isMobile ? 28 : 36),
              _SectionBlock(
                title: 'pub.dev Packages',
                subtitle:
                    'These are the packages I maintain publicly so other Flutter developers can use the same building blocks in their own work.',
                child: _PackagesGrid(packages: OpenSourceData.packages),
              ),
              SizedBox(height: isMobile ? 28 : 36),
              _SectionBlock(
                title: 'Featured Repositories',
                subtitle:
                    'A few public repos that give more context around the kinds of products, packages, and experiments I ship in the open.',
                child: _ReposGrid(repositories: OpenSourceData.featuredRepos),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, List<OpenSourceContribution>> _groupByRepository(
    List<OpenSourceContribution> contributions,
  ) {
    final grouped = <String, List<OpenSourceContribution>>{};

    for (final contribution in contributions) {
      grouped.putIfAbsent(contribution.repository, () => []).add(contribution);
    }

    return grouped;
  }
}

class _TopActions extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onBackHome;
  final VoidCallback onOpenGitHub;
  final VoidCallback onOpenPubDev;

  const _TopActions({
    required this.isMobile,
    required this.onBackHome,
    required this.onOpenGitHub,
    required this.onOpenPubDev,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SecondaryButton(
            text: 'Back Home',
            icon: Icons.arrow_back_rounded,
            fullWidth: true,
            onPressed: onBackHome,
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            text: 'GitHub Profile',
            icon: Icons.open_in_new_rounded,
            fullWidth: true,
            onPressed: onOpenGitHub,
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            text: 'pub.dev Publisher',
            icon: Icons.inventory_2_rounded,
            fullWidth: true,
            onPressed: onOpenPubDev,
          ),
        ],
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        SecondaryButton(
          text: 'Back Home',
          icon: Icons.arrow_back_rounded,
          onPressed: onBackHome,
        ),
        SecondaryButton(
          text: 'GitHub Profile',
          icon: Icons.open_in_new_rounded,
          onPressed: onOpenGitHub,
        ),
        SecondaryButton(
          text: 'pub.dev Publisher',
          icon: Icons.inventory_2_rounded,
          onPressed: onOpenPubDev,
        ),
      ],
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _SectionBlock({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(
            subtitle,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.75,
            ),
          ),
        ),
        const SizedBox(height: 22),
        child,
      ],
    );
  }
}

class _PackagesGrid extends StatelessWidget {
  final List<PubDevPackage> packages;

  const _PackagesGrid({required this.packages});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 820) {
          return Column(
            children: List.generate(packages.length, (index) {
              final package = packages[index];
              final isLast = index == packages.length - 1;

              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
                child: PubDevPackageCard(package: package),
              );
            }),
          );
        }

        double cardWidth;
        if (constraints.maxWidth < 1200) {
          cardWidth = (constraints.maxWidth - 24) / 2;
        } else {
          cardWidth = (constraints.maxWidth - 48) / 3;
        }

        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: packages
              .map(
                (package) => SizedBox(
                  width: cardWidth,
                  child: PubDevPackageCard(package: package),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _ReposGrid extends StatelessWidget {
  final List<GitHubRepo> repositories;

  const _ReposGrid({required this.repositories});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = isMobile
            ? constraints.maxWidth
            : (constraints.maxWidth < 1100
                  ? (constraints.maxWidth - 20) / 2
                  : (constraints.maxWidth - 40) / 3);

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: repositories
              .map(
                (repo) => SizedBox(
                  width: cardWidth,
                  child: GitHubRepoCard(repo: repo),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _LedgerOverviewBand extends StatelessWidget {
  final int contributionCount;
  final int mergedCount;
  final int packageCount;
  final int repositoryCount;
  final List<String> contributionAreas;

  const _LedgerOverviewBand({
    required this.contributionCount,
    required this.mergedCount,
    required this.packageCount,
    required this.repositoryCount,
    required this.contributionAreas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.isMobile ? 18 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: context.isDarkMode
              ? [
                  AppColors.primary.withValues(alpha: 0.14),
                  AppColors.accent.withValues(alpha: 0.08),
                  AppColors.secondary.withValues(alpha: 0.12),
                ]
              : [
                  AppColors.primary.withValues(alpha: 0.06),
                  AppColors.accent.withValues(alpha: 0.04),
                  AppColors.secondary.withValues(alpha: 0.06),
                ],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.16),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start with the real signal',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'If you are evaluating whether I can contribute carefully, publicly, and consistently, this gives you the quick read before you scan the detailed record below.',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.75,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _OverviewPill(
                value: '$contributionCount',
                label: 'PRs listed',
                color: AppColors.primary,
              ),
              _OverviewPill(
                value: '$mergedCount',
                label: 'Merged',
                color: AppColors.success,
              ),
              _OverviewPill(
                value: '$packageCount',
                label: 'pub.dev packages',
                color: AppColors.accent,
              ),
              _OverviewPill(
                value: '$repositoryCount',
                label: 'Repositories',
                color: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: contributionAreas
                .map((area) => _ContributionChip(label: area))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _OverviewPill extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _OverviewPill({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surface.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: RichText(
        text: TextSpan(
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface,
          ),
          children: [
            TextSpan(
              text: '$value ',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            TextSpan(
              text: label,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedContributionPanel extends StatelessWidget {
  final OpenSourceContribution contribution;

  const _FeaturedContributionPanel({required this.contribution});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.isMobile ? 18 : 24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: contribution.accentColor.withValues(alpha: 0.18),
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: contribution.accentColor.withValues(
              alpha: context.isDarkMode ? 0.08 : 0.05,
            ),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusChip(label: 'Featured', color: contribution.accentColor),
              _ContributionChip(label: contribution.reference),
              _ContributionChip(label: contribution.repository),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            contribution.title,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            contribution.summary,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _ContributionChip(label: contribution.dateLabel),
              _ContributionChip(label: contribution.area),
              ...contribution.tags
                  .take(3)
                  .map((tag) => _ContributionChip(label: tag)),
            ],
          ),
          const SizedBox(height: 18),
          SecondaryButton(
            text: 'Open Pull Request',
            icon: Icons.open_in_new_rounded,
            fullWidth: context.isMobile,
            width: context.isMobile ? null : 210,
            height: 52,
            onPressed: () => UrlLauncherUtils.launchURL(contribution.url),
          ),
        ],
      ),
    );
  }
}

class _RepositoryLedgerGroup extends StatelessWidget {
  final String repository;
  final List<OpenSourceContribution> contributions;

  const _RepositoryLedgerGroup({
    required this.repository,
    required this.contributions,
  });

  @override
  Widget build(BuildContext context) {
    final mergedCount = contributions
        .where((item) => item.status == ContributionStatus.merged)
        .length;
    final areas = contributions.map((item) => item.area).toSet().toList();
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.source_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      repository,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              _ContributionChip(label: '${contributions.length} entries'),
              _ContributionChip(label: '$mergedCount merged'),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: areas
                .map((area) => _ContributionChip(label: area))
                .toList(),
          ),
          const SizedBox(height: 14),
          ...List.generate(contributions.length, (index) {
            final contribution = contributions[index];
            final isLast = index == contributions.length - 1;

            return Column(
              children: [
                _ContributionLedgerRow(contribution: contribution),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: context.colorScheme.outline.withValues(alpha: 0.1),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ContributionLedgerRow extends StatelessWidget {
  final OpenSourceContribution contribution;

  const _ContributionLedgerRow({required this.contribution});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final titleStyle = context.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w800,
      height: 1.3,
    );
    final summaryStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.colorScheme.onSurfaceVariant,
      height: 1.7,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => UrlLauncherUtils.launchURL(contribution.url),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 4 : 6,
            vertical: isMobile ? 14 : 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _StatusChip(
                    label: contribution.status == ContributionStatus.merged
                        ? 'Merged'
                        : 'Recent PR',
                    color: contribution.accentColor,
                  ),
                  _ContributionChip(label: contribution.reference),
                  _ContributionChip(label: contribution.dateLabel),
                ],
              ),
              const SizedBox(height: 12),
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contribution.title, style: titleStyle),
                    const SizedBox(height: 8),
                    Text(
                      contribution.summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: summaryStyle,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ContributionChip(label: contribution.area),
                        ...contribution.tags
                            .take(2)
                            .map((tag) => _ContributionChip(label: tag)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _ExternalArrow(
                        accentColor: contribution.accentColor,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contribution.title, style: titleStyle),
                          const SizedBox(height: 8),
                          Text(
                            contribution.summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: summaryStyle,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _ContributionChip(label: contribution.area),
                              ...contribution.tags
                                  .take(3)
                                  .map((tag) => _ContributionChip(label: tag)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _ExternalArrow(accentColor: contribution.accentColor),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExternalArrow extends StatelessWidget {
  final Color accentColor;

  const _ExternalArrow({required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
      ),
      child: Icon(Icons.open_in_new_rounded, size: 18, color: accentColor),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ContributionChip extends StatelessWidget {
  final String label;

  const _ContributionChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: context.isDarkMode ? 0.4 : 0.5,
        ),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
