import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../open_source/data/open_source_data.dart';
import '../../open_source/widgets/contribution_graph.dart';
import '../../open_source/widgets/github_repo_card.dart';
import '../../open_source/widgets/github_stats_card.dart';
import '../../open_source/widgets/pub_dev_package_card.dart';

class OpenSourceSection extends StatefulWidget {
  const OpenSourceSection({super.key});

  @override
  State<OpenSourceSection> createState() => _OpenSourceSectionState();
}

class _OpenSourceSectionState extends State<OpenSourceSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return VisibilityDetector(
      key: const Key('open-source-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: SectionWrapper(
        sectionId: 'open-source',
        child: Column(
          children: [
            const SectionTitle(
              tag: 'OPEN SOURCE',
              title: 'Contributing to the Community',
              subtitle:
                  'Building packages, sharing knowledge, and collaborating with developers worldwide',
            ),

            SizedBox(height: isMobile ? 48 : 64),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: _isVisible ? 1.0 : 0.0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 600),
                offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                curve: Curves.easeOutCubic,
                child: const GitHubStatsCard(),
              ),
            ),

            SizedBox(height: isMobile ? 48 : 64),

            _buildContributionSection(context),

            SizedBox(height: isMobile ? 48 : 64),

            _buildPackagesSection(context),

            SizedBox(height: isMobile ? 48 : 64),

            _buildReposSection(context),

            SizedBox(height: isMobile ? 48 : 64),

            _buildCTASection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContributionSection(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 800),
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        curve: Curves.easeOutCubic,
        child: Column(
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
                Icon(
                  Icons.insights_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'CONTRIBUTION ACTIVITY',
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

            const SizedBox(height: 32),

            ContributionGraph(
              contributions: OpenSourceData.generateMockContributions(),
              isVisible: _isVisible,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackagesSection(BuildContext context) {
    final textTheme = context.textTheme;
    final isMobile = context.isMobile;
    final packages = OpenSourceData.packages;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 900),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 900),
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        curve: Curves.easeOutCubic,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, AppColors.accent],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.inventory_2_rounded,
                  color: AppColors.accent,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'PUB.DEV PACKAGES',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.accent,
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
                      colors: [AppColors.accent, Colors.transparent],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: packages
                  .map(
                    (pkg) => SizedBox(
                      width: isMobile ? double.infinity : 400,
                      child: PubDevPackageCard(package: pkg),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReposSection(BuildContext context) {
    final textTheme = context.textTheme;
    final isMobile = context.isMobile;
    final repos = OpenSourceData.featuredRepos;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 1000),
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        curve: Curves.easeOutCubic,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, AppColors.success],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.folder_open_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'FEATURED REPOSITORIES',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppColors.success,
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
                      colors: [AppColors.success, Colors.transparent],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = isMobile
                    ? 1
                    : (constraints.maxWidth > 900 ? 3 : 2);

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 1.8 : 1.4,
                  ),
                  itemCount: repos.length,
                  itemBuilder: (context, index) {
                    return GitHubRepoCard(repo: repos[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1100),
      opacity: _isVisible ? 1.0 : 0.0,
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          PrimaryButton(
            text: 'View GitHub Profile',
            icon: Icons.code_rounded,
            onPressed: () => UrlLauncherUtils.openGitHub(),
          ),
          SecondaryButton(
            text: 'Browse pub.dev',
            icon: Icons.inventory_2_rounded,
            onPressed: () => UrlLauncherUtils.launchURL(AppUrls.pubDevProfile),
          ),
        ],
      ),
    );
  }
}
