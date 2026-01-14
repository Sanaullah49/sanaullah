import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/url_launcher_utils.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;
    final bool isSmallTablet = screenWidth >= 600 && screenWidth < 900;
    final bool isLargeTablet = screenWidth >= 900 && screenWidth < 1100;
    final bool isTablet = isSmallTablet || isLargeTablet;

    final borderRadius = isMobile ? 16.0 : (isTablet ? 20.0 : 24.0);

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
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: _isHovered
                    ? project.accentColor.withValues(alpha: 0.5)
                    : colorScheme.outline.withValues(alpha: 0.1),
                width: isTablet ? 2.0 : 1.5,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isSmallTablet
                        ? 6
                        : (isLargeTablet ? 5 : (isMobile ? 5 : 6)),
                    child: _buildMockupSection(
                      context,
                      isMobile: isMobile,
                      isTablet: isTablet,
                    ),
                  ),

                  _buildContentSection(
                    context,
                    isMobile: isMobile,
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMockupSection(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final project = widget.project;
    final padding = isMobile ? 16.0 : (isTablet ? 20.0 : 24.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            project.accentColor.withValues(alpha: 0.1),
            project.accentColor.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPatternPainter(
                color: project.accentColor.withValues(alpha: 0.05),
                spacing: isTablet ? 20.0 : 25.0,
              ),
            ),
          ),

          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxHeight = constraints.maxHeight * 0.88;
                final maxWidth = constraints.maxWidth * (isTablet ? 0.6 : 0.7);

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: maxHeight.clamp(140, 320),
                    maxWidth: maxWidth.clamp(90, 180),
                  ),
                  child: PhoneMockup(
                    imagePath: project.mockupImage,
                    accentColor: project.accentColor,
                    isHovered: _isHovered,
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: isTablet ? 10 : 8,
            left: isTablet ? 10 : 8,
            child: _buildCategoryBadge(context, isTablet: isTablet),
          ),

          if (project.status != ProjectStatus.completed)
            Positioned(
              top: isTablet ? 10 : 8,
              right: isTablet ? 10 : 8,
              child: _buildStatusBadge(context, isTablet: isTablet),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryBadge(BuildContext context, {required bool isTablet}) {
    final project = widget.project;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;

    final hPadding = isMobile ? 8.0 : (isTablet ? 10.0 : 12.0);
    final vPadding = isMobile ? 4.0 : (isTablet ? 5.0 : 6.0);
    final iconSize = isMobile ? 12.0 : (isTablet ? 13.0 : 14.0);
    final fontSize = isMobile ? 9.0 : (isTablet ? 10.0 : 11.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkCard : AppColors.lightCard).withValues(
          alpha: 0.95,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: project.category.color.withValues(alpha: 0.3),
          width: isTablet ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            project.category.icon,
            size: iconSize,
            color: project.category.color,
          ),
          SizedBox(width: isMobile ? 4 : (isTablet ? 5 : 6)),
          Text(
            project.category.label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: project.category.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, {required bool isTablet}) {
    final project = widget.project;
    final isMobile = context.isMobile;

    final hPadding = isMobile ? 6.0 : (isTablet ? 8.0 : 10.0);
    final vPadding = isMobile ? 3.0 : (isTablet ? 4.0 : 5.0);
    final fontSize = isMobile ? 8.0 : (isTablet ? 9.0 : 10.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
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
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: project.status.color,
        ),
      ),
    );
  }

  Widget _buildContentSection(
    BuildContext context, {
    required bool isMobile,
    required bool isTablet,
  }) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final project = widget.project;

    final padding = isMobile ? 16.0 : (isTablet ? 18.0 : 20.0);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            project.title,
            style:
                (isMobile
                        ? textTheme.titleSmall
                        : (isTablet
                              ? textTheme.titleMedium
                              : textTheme.titleMedium))
                    ?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: isTablet ? 17.0 : null,
                      color: _isHovered
                          ? project.accentColor
                          : colorScheme.onSurface,
                    ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: isMobile ? 6 : (isTablet ? 7 : 8)),

          Text(
            project.shortDescription,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
              fontSize: isMobile ? 12 : (isTablet ? 13 : 14),
            ),
            maxLines: isTablet ? 2 : (isMobile ? 2 : 3),
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: isMobile ? 10 : (isTablet ? 11 : 12)),

          Wrap(
            spacing: isTablet ? 7.0 : 6.0,
            runSpacing: isTablet ? 7.0 : 6.0,
            children: project.technologies
                .take(isTablet ? 4 : (isMobile ? 3 : 4))
                .map((tech) => _TechChip(tech: tech, isTablet: isTablet))
                .toList(),
          ),

          SizedBox(height: isMobile ? 12 : (isTablet ? 14 : 16)),

          _buildActionButtons(context, isTablet: isTablet),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, {required bool isTablet}) {
    final project = widget.project;
    final isMobile = context.isMobile;

    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: 'View Details',
            icon: Icons.arrow_forward_rounded,
            color: project.accentColor,
            isHovered: _isHovered,
            isMobile: isMobile,
            isTablet: isTablet,
            onTap: () => context.go(RouteNames.projectDetail(project.slug)),
          ),
        ),
        if (project.hasLinks) ...[
          SizedBox(width: isTablet ? 10 : 12),
          _IconActionButton(
            icon: project.githubUrl != null
                ? Icons.code_rounded
                : Icons.open_in_new_rounded,
            tooltip: project.primaryLinkLabel,
            isTablet: isTablet,
            onTap: () {
              if (project.primaryLink != null) {
                UrlLauncherUtils.launchURL(project.primaryLink!);
              }
            },
          ),
        ],
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  final String tech;
  final bool isTablet;

  const _TechChip({required this.tech, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final hPadding = isMobile ? 6.0 : (isTablet ? 7.0 : 8.0);
    final vPadding = isMobile ? 3.0 : (isTablet ? 4.0 : 4.0);
    final fontSize = isMobile ? 9.0 : (isTablet ? 10.0 : 10.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      decoration: BoxDecoration(
        color: AppColors.getTechColor(tech).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.getTechColor(tech).withValues(alpha: 0.3),
          width: isTablet ? 1.0 : 1.0,
        ),
      ),
      child: Text(
        tech,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.getTechColor(tech),
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isHovered;
  final bool isMobile;
  final bool isTablet;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isHovered,
    required this.isMobile,
    required this.isTablet,
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
    final hPadding = widget.isMobile ? 12.0 : (widget.isTablet ? 14.0 : 16.0);
    final vPadding = widget.isMobile ? 8.0 : (widget.isTablet ? 9.0 : 10.0);
    final fontSize = widget.isMobile ? 12.0 : (widget.isTablet ? 13.0 : 13.0);
    final iconSize = widget.isMobile ? 14.0 : (widget.isTablet ? 15.0 : 16.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isButtonHovered = true),
      onExit: (_) => setState(() => _isButtonHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: hPadding,
            vertical: vPadding,
          ),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: _isButtonHovered || widget.isHovered
                        ? widget.color
                        : context.colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                widget.icon,
                size: iconSize,
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
  final bool isTablet;
  final VoidCallback onTap;

  const _IconActionButton({
    required this.icon,
    required this.tooltip,
    required this.isTablet,
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
    final size = widget.isTablet ? 42.0 : 40.0;
    final iconSize = widget.isTablet ? 19.0 : 18.0;

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
            width: size,
            height: size,
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
              size: iconSize,
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
  final double spacing;

  _GridPatternPainter({required this.color, this.spacing = 25.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

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
