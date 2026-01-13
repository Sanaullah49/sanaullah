import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/theme_toggle.dart';
import '../../../router/route_names.dart';
import 'mobile_drawer.dart';
import 'nav_item.dart';

class Navbar extends ConsumerStatefulWidget {
  final String currentPath;
  final ScrollController? scrollController;

  const Navbar({super.key, required this.currentPath, this.scrollController});

  @override
  ConsumerState<Navbar> createState() => _NavbarState();
}

class _NavbarState extends ConsumerState<Navbar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    final scrolled = (widget.scrollController?.offset ?? 0) > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _openDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MobileDrawer(currentPath: widget.currentPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isDark = context.isDarkMode;
    final screenWidth = MediaQuery.of(context).size.width;

    final showFullNav = screenWidth >= 900;
    final showCompactNav = screenWidth >= 600 && screenWidth < 900;
    final showMobileNav = screenWidth < 600;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isScrolled
            ? (isDark
                  ? AppColors.darkBg.withValues(alpha: 0.95)
                  : AppColors.lightBg.withValues(alpha: 0.95))
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled
                ? colorScheme.outline.withValues(alpha: 0.1)
                : Colors.transparent,
            width: 1,
          ),
        ),
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: _isScrolled
              ? ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.1),
                  BlendMode.srcOver,
                )
              : ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
          child: SafeArea(
            bottom: false,
            child: Container(
              height: showMobileNav ? 70 : 80,
              padding: EdgeInsets.symmetric(
                horizontal: showMobileNav ? 16 : (showCompactNav ? 24 : 40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLogo(context),

                  if (showFullNav) ...[
                    _buildDesktopNav(context),
                    _buildDesktopActions(context),
                  ],

                  if (showCompactNav) _buildTabletActions(context),

                  if (showMobileNav) _buildMobileMenuButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(RouteNames.home),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: isMobile ? 36 : 40,
              height: isMobile ? 36 : 40,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'S',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              AppConstants.name.split(' ')[0],
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                fontSize: isMobile ? 18 : 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        NavItem(
          label: 'Home',
          path: RouteNames.home,
          isActive: widget.currentPath == RouteNames.home,
        ),
        const SizedBox(width: 8),
        NavItem(
          label: 'About',
          path: RouteNames.about,
          isActive: widget.currentPath == RouteNames.about,
        ),
        const SizedBox(width: 8),
        NavItem(
          label: 'Projects',
          path: RouteNames.projects,
          isActive: widget.currentPath.startsWith(RouteNames.projects),
        ),
        const SizedBox(width: 8),
        NavItem(
          label: 'Blog',
          path: RouteNames.blog,
          isActive: widget.currentPath.startsWith(RouteNames.blog),
        ),
      ],
    );
  }

  Widget _buildDesktopActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ThemeToggle(size: 44),
        const SizedBox(width: 16),
        _NavbarHireButton(onPressed: () => context.go(RouteNames.hireMe)),
      ],
    );
  }

  Widget _buildTabletActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ThemeToggle(size: 40),
        const SizedBox(width: 12),
        _CompactHireButton(onPressed: () => context.go(RouteNames.hireMe)),
        const SizedBox(width: 8),
        _buildMobileMenuButton(context),
      ],
    );
  }

  Widget _buildMobileMenuButton(BuildContext context) {
    final colorScheme = context.colorScheme;

    return IconButton(
      onPressed: _openDrawer,
      icon: const Icon(Icons.menu_rounded),
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        padding: const EdgeInsets.all(12),
        minimumSize: const Size(44, 44),
      ),
    );
  }
}

class _CompactHireButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _CompactHireButton({required this.onPressed});

  @override
  State<_CompactHireButton> createState() => _CompactHireButtonState();
}

class _CompactHireButtonState extends State<_CompactHireButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  )
                : AppColors.ctaGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                'Hire Me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavbarHireButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _NavbarHireButton({required this.onPressed});

  @override
  State<_NavbarHireButton> createState() => _NavbarHireButtonState();
}

class _NavbarHireButtonState extends State<_NavbarHireButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  )
                : AppColors.ctaGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                'Hire Me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
