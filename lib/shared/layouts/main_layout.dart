import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme_provider.dart';
import '../../core/utils/responsive_utils.dart';
import '../widgets/footer/footer.dart';
import '../widgets/navbar/navbar.dart';
import '../widgets/scroll_to_top_button.dart';

class MainLayout extends ConsumerStatefulWidget {
  final Widget child;
  final String currentPath;

  const MainLayout({super.key, required this.child, required this.currentPath});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;
  bool _isNavbarVisible = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentOffset = _scrollController.offset;

    if (currentOffset > 500 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (currentOffset <= 500 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }

    if (context.isMobile) {
      if (currentOffset > _lastScrollOffset && currentOffset > 100) {
        if (_isNavbarVisible) {
          setState(() => _isNavbarVisible = false);
        }
      } else {
        if (!_isNavbarVisible) {
          setState(() => _isNavbarVisible = true);
        }
      }
    }

    _lastScrollOffset = currentOffset;
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: context.isMobile ? 70 : 80),
              ),

              SliverToBoxAdapter(child: widget.child),

              const SliverToBoxAdapter(child: Footer()),
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              offset: _isNavbarVisible ? Offset.zero : const Offset(0, -1),
              child: Navbar(
                currentPath: widget.currentPath,
                scrollController: _scrollController,
              ),
            ),
          ),

          Positioned(
            right: 24,
            bottom: 24,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showScrollToTop ? 1.0 : 0.0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: _showScrollToTop ? 1.0 : 0.8,
                child: ScrollToTopButton(onPressed: _scrollToTop),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
