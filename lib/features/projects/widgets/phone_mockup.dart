import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';

class PhoneMockup extends StatelessWidget {
  final String imagePath;
  final Color accentColor;
  final bool isHovered;
  final double? width;
  final double? height;

  const PhoneMockup({
    super.key,
    required this.imagePath,
    this.accentColor = AppColors.primary,
    this.isHovered = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return LayoutBuilder(
      builder: (context, constraints) {
        final mockupWidth = width ?? constraints.maxWidth * 0.6;
        final mockupHeight = height ?? constraints.maxHeight * 0.95;
        final aspectRatio = 0.48;

        final actualWidth = mockupWidth.clamp(120.0, 200.0);
        final actualHeight = actualWidth / aspectRatio;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: actualWidth,
          height: actualHeight.clamp(0.0, mockupHeight),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.1),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? accentColor.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: isHovered ? 40 : 25,
                offset: Offset(0, isHovered ? 20 : 15),
              ),
              if (isHovered)
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.2),
                  blurRadius: 60,
                  spreadRadius: -10,
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: _buildScreenContent(context),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: actualWidth * 0.35,
                      height: 25,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black : const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: actualWidth * 0.35,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScreenContent(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholderContent(context);
      },
    );
  }

  Widget _buildPlaceholderContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.8),
            accentColor.withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_android_rounded,
            size: 48,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Preview',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneMockupLarge extends StatefulWidget {
  final String imagePath;
  final Color accentColor;
  final List<String>? screenshots;

  const PhoneMockupLarge({
    super.key,
    required this.imagePath,
    this.accentColor = AppColors.primary,
    this.screenshots,
  });

  @override
  State<PhoneMockupLarge> createState() => _PhoneMockupLargeState();
}

class _PhoneMockupLargeState extends State<PhoneMockupLarge> {
  int _currentIndex = 0;
  bool _isHovered = false;

  List<String> get _allImages {
    final images = [widget.imagePath];
    if (widget.screenshots != null) {
      images.addAll(widget.screenshots!);
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 280,
            height: 580,
            transform: Matrix4.identity()
              ..translateByDouble(0.0, _isHovered ? -10.0 : 0.0, 0.0, 0.0),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(45),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.1),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.accentColor.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.25),
                  blurRadius: _isHovered ? 50 : 35,
                  offset: Offset(0, _isHovered ? 25 : 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(41),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(37),
                        child: _buildScreenContent(),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 12,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.black
                              : const Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 5,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.3)
                              : Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_allImages.length > 1) ...[
            const SizedBox(height: 24),
            _buildIndicators(),
          ],
        ],
      ),
    );
  }

  Widget _buildScreenContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Image.asset(
        _allImages[_currentIndex],
        key: ValueKey(_currentIndex),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.accentColor.withValues(alpha: 0.8),
            widget.accentColor.withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_android_rounded,
            size: 80,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          const SizedBox(height: 16),
          Text(
            'App Preview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_allImages.length, (index) {
        final isActive = index == _currentIndex;

        return GestureDetector(
          onTap: () => setState(() => _currentIndex = index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? widget.accentColor
                  : widget.accentColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
