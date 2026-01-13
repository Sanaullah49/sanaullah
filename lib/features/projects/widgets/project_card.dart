import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/url_launcher_utils.dart';
import '../../../core/widgets/tech_badge.dart';
import '../../../router/route_names.dart';
import '../models/project_model.dart';
import 'phone_mockup.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;
  final bool showFullDescription;

  const ProjectCard({
    super.key,
    required this.project,
    this.index = 0,
    this.showFullDescription = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(RouteNames.projectDetail(project.slug)),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _scaleAnimation.value, child: child);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? project.accentColor.withValues(alpha: 0.5)
                    : colorScheme.outline.withValues(alpha: 0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? project.accentColor.withValues(alpha: 0.15)
                      : Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                  blurRadius: _isHovered ? 40 : 20,
                  offset: Offset(0, _isHovered ? 15 : 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _buildMockupSection(context)),

                Expanded(flex: 4, child: _buildContentSection(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMockupSection(BuildContext context) {
    final project = widget.project;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            project.accentColor.withValues(alpha: 0.1),
            project.accentColor.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPatternPainter(
                color: project.accentColor.withValues(alpha: 0.05),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.identity()
                  ..translateByDouble(0.0, _isHovered ? -10.0 : 0.0, 0.0, 0.0),
                child: PhoneMockup(
                  imagePath: project.mockupImage,
                  accentColor: project.accentColor,
                  isHovered: _isHovered,
                ),
              ),
            ),
          ),

          Positioned(top: 16, left: 16, child: _buildCategoryBadge(context)),

          if (project.status != ProjectStatus.completed)
            Positioned(top: 16, right: 16, child: _buildStatusBadge(context)),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge(BuildContext context) {
    final project = widget.project;
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkCard : AppColors.lightCard).withValues(
          alpha: 0.9,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: project.category.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(project.category.icon, size: 14, color: project.category.color),
          const SizedBox(width: 6),
          Text(
            project.category.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: project.category.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final project = widget.project;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: project.status.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: project.status.color.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Text(
        project.status.label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: project.status.color,
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final project = widget.project;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: _isHovered ? project.accentColor : colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Text(
              project.shortDescription,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 12),

          TechBadgeRow(
            technologies: project.technologies.take(4).toList(),
            spacing: 6,
            runSpacing: 6,
          ),

          const SizedBox(height: 16),

          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final project = widget.project;

    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: 'View Details',
            icon: Icons.arrow_forward_rounded,
            color: project.accentColor,
            isHovered: _isHovered,
            onTap: () => context.go(RouteNames.projectDetail(project.slug)),
          ),
        ),

        const SizedBox(width: 12),

        if (project.hasLinks)
          _IconActionButton(
            icon: project.githubUrl != null
                ? Icons.code_rounded
                : Icons.open_in_new_rounded,
            tooltip: project.primaryLinkLabel,
            onTap: () {
              if (project.primaryLink != null) {
                UrlLauncherUtils.launchURL(project.primaryLink!);
              }
            },
          ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isHovered;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isHovered,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isButtonHovered = true),
      onExit: (_) => setState(() => _isButtonHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isButtonHovered || widget.isHovered
                ? widget.color.withValues(alpha: 0.15)
                : (isDark
                      ? AppColors.darkBgTertiary
                      : AppColors.lightBgSecondary),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isButtonHovered || widget.isHovered
                  ? widget.color.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _isButtonHovered || widget.isHovered
                      ? widget.color
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                widget.icon,
                size: 16,
                color: _isButtonHovered || widget.isHovered
                    ? widget.color
                    : context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconActionButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _IconActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_IconActionButton> createState() => _IconActionButtonState();
}

class _IconActionButtonState extends State<_IconActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _isHovered
                  ? colorScheme.primary.withValues(alpha: 0.15)
                  : (isDark
                        ? AppColors.darkBgTertiary
                        : AppColors.lightBgSecondary),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isHovered
                    ? colorScheme.primary.withValues(alpha: 0.5)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Icon(
              widget.icon,
              size: 18,
              color: _isHovered
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  final Color color;

  _GridPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    const spacing = 25.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
