import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../model/testimonial_model.dart';
import 'testimonial_card.dart';

class TestimonialSlider extends StatefulWidget {
  final List<Testimonial> testimonials;
  final Duration autoPlayDuration;
  final bool enableAutoPlay;

  const TestimonialSlider({
    super.key,
    required this.testimonials,
    this.autoPlayDuration = const Duration(seconds: 5),
    this.enableAutoPlay = true,
  });

  @override
  State<TestimonialSlider> createState() => _TestimonialSliderState();
}

class _TestimonialSliderState extends State<TestimonialSlider> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoPlayTimer;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: _getViewportFraction(context),
      initialPage: 0,
    );

    if (widget.enableAutoPlay) {
      _startAutoPlay();
    }
  }

  double _getViewportFraction(BuildContext context) {
    return 0.85;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isMobile = context.isMobile;
    final isTablet = context.isTablet;

    final viewportFraction = isMobile
        ? 0.92
        : isTablet
        ? 0.6
        : 0.4;

    if (_pageController.viewportFraction != viewportFraction) {
      _pageController.dispose();
      _pageController = PageController(
        viewportFraction: viewportFraction,
        initialPage: _currentIndex,
      );
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(widget.autoPlayDuration, (timer) {
      if (!_isHovered && mounted) {
        _goToNext();
      }
    });
  }

  void _goToNext() {
    final nextIndex = (_currentIndex + 1) % widget.testimonials.length;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToPrevious() {
    final prevIndex = _currentIndex == 0
        ? widget.testimonials.length - 1
        : _currentIndex - 1;
    _pageController.animateToPage(
      prevIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  void _goToIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _autoPlayTimer?.cancel();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        if (widget.enableAutoPlay) {
          _startAutoPlay();
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: isMobile ? 420 : 380,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemCount: widget.testimonials.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 8 : 12,
                        vertical: 8,
                      ),
                      child: TestimonialCard(
                        testimonial: widget.testimonials[index],
                        isActive: index == _currentIndex,
                      ),
                    );
                  },
                ),

                if (!isMobile) ...[
                  _buildNavArrow(context, isLeft: true, onTap: _goToPrevious),
                  _buildNavArrow(context, isLeft: false, onTap: _goToNext),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),

          _buildIndicators(context),
        ],
      ),
    );
  }

  Widget _buildNavArrow(
    BuildContext context, {
    required bool isLeft,
    required VoidCallback onTap,
  }) {
    return Positioned(
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      top: 0,
      bottom: 0,
      child: Center(
        child: _ArrowButton(isLeft: isLeft, onTap: onTap),
      ),
    );
  }

  Widget _buildIndicators(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.testimonials.length, (index) {
        final isActive = index == _currentIndex;
        final testimonial = widget.testimonials[index];
        final color = testimonial.accentColor ?? AppColors.primary;

        return GestureDetector(
          onTap: () => _goToIndex(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 32 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: isActive ? color : color.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      }),
    );
  }
}

class _ArrowButton extends StatefulWidget {
  final bool isLeft;
  final VoidCallback onTap;

  const _ArrowButton({required this.isLeft, required this.onTap});

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _isHovered
                ? colorScheme.primary.withValues(alpha: 0.1)
                : (isDark ? AppColors.darkCard : AppColors.lightCard),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? colorScheme.primary.withValues(alpha: 0.5)
                  : colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            widget.isLeft
                ? Icons.chevron_left_rounded
                : Icons.chevron_right_rounded,
            color: _isHovered
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
