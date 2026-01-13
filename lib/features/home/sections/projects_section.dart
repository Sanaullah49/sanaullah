import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../router/route_names.dart';
import '../../projects/data/projects_data.dart';
import '../../projects/widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final featuredProjects = ProjectsData.featuredProjects;

    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: SectionWrapper(
        sectionId: 'projects',
        child: Column(
          children: [
            const SectionTitle(
              tag: 'PORTFOLIO',
              title: 'Featured Projects',
              subtitle:
                  'A selection of my best work showcasing expertise in Flutter, mobile development, and software architecture',
            ),

            SizedBox(height: isMobile ? 48 : 80),

            _buildProjectsGrid(context, featuredProjects),

            SizedBox(height: isMobile ? 48 : 64),

            _buildViewAllButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List<dynamic> projects) {
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: isMobile ? 0.85 : (isTablet ? 0.9 : 1.1),
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 500 + (index * 150)),
              opacity: _isVisible ? 1.0 : 0.0,
              child: AnimatedSlide(
                duration: Duration(milliseconds: 500 + (index * 150)),
                offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
                curve: Curves.easeOutCubic,
                child: ProjectCard(project: projects[index], index: index),
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
          text: 'View All Projects',
          icon: Icons.arrow_forward_rounded,
          onPressed: () => context.go(RouteNames.projects),
        ),
      ],
    );
  }
}
