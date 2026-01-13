import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../theme/app_spacing.dart';
import '../utils/responsive_utils.dart';

class SectionWrapper extends StatefulWidget {
  final String sectionId;
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final bool enableAnimation;
  final bool centerContent;

  const SectionWrapper({
    super.key,
    required this.sectionId,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.maxWidth,
    this.enableAnimation = true,
    this.centerContent = true,
  });

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 40),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (!widget.enableAnimation) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!widget.enableAnimation || _hasAnimated) return;

    if (info.visibleFraction > 0.15) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.horizontalPadding;
    final verticalPadding = context.sectionPadding;
    final maxWidth = widget.maxWidth ?? AppSpacing.maxContentWidth;

    Widget content = Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding:
          widget.padding ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
      child: widget.child,
    );

    if (widget.centerContent) {
      content = Center(child: content);
    }

    Widget section = Container(
      width: double.infinity,
      color: widget.backgroundColor,
      child: content,
    );

    if (widget.enableAnimation) {
      section = VisibilityDetector(
        key: Key(widget.sectionId),
        onVisibilityChanged: _onVisibilityChanged,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _slideAnimation.value,
              child: Opacity(opacity: _fadeAnimation.value, child: child),
            );
          },
          child: section,
        ),
      );
    }

    return section;
  }
}
