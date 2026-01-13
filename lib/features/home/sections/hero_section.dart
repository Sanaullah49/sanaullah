import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/gradient_text.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/social_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../router/route_names.dart';
import '../widgets/floating_tech_badges.dart';
import '../widgets/hero_background.dart';
import '../widgets/hero_image.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        final screenHeight = MediaQuery.of(context).size.height;
        final minHeight = screenHeight > 600 ? screenHeight : 600.0;

        return Stack(
          children: [
            const Positioned.fill(child: HeroBackground()),

            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: minHeight),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 80,
                  vertical: 80,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: isMobile
                        ? _buildMobileLayout(context)
                        : _buildDesktopLayout(context),
                  ),
                ),
              ),
            ),

            if (!isMobile && screenHeight > 700)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: IgnorePointer(child: _buildScrollIndicator(context)),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    const imageSize = 500.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildHeroContent(context),
            ),
          ),
        ),

        const SizedBox(width: 40),

        Expanded(
          flex: 5,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: SizedBox(
                width: imageSize,
                height: imageSize,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    const Positioned.fill(child: Center(child: HeroImage())),
                    Positioned.fill(
                      child: FloatingTechBadges(
                        size: imageSize,
                        isMobile: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    const imageSize = 320.0;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            SizedBox(
              width: imageSize,
              height: imageSize,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const Positioned.fill(
                    child: Center(child: HeroImage(isMobile: true)),
                  ),
                  const Positioned.fill(
                    child: FloatingTechBadges(size: imageSize, isMobile: true),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            _buildHeroContent(context, centerAlign: true),

            const SizedBox(height: 40),

            _buildScrollIndicator(context),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, {bool centerAlign = false}) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: centerAlign
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const StatusBadge(),
        const SizedBox(height: 24),

        Text(
          AppConstants.heroGreeting,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 8),

        AnimatedGradientText(
          text: AppConstants.name,
          style: isMobile
              ? textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)
              : textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: isMobile ? 40 : 50,
          child: _buildAnimatedRoleText(context, centerAlign),
        ),
        const SizedBox(height: 24),

        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: centerAlign ? 500 : 550),
          child: Text(
            AppConstants.heroDescription,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
            textAlign: centerAlign ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: 36),

        _buildCTAButtons(context, centerAlign),

        const SizedBox(height: 40),

        Text(
          'Find me on',
          style: context.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        const SocialButtonRow(),
      ],
    );
  }

  Widget _buildAnimatedRoleText(BuildContext context, bool centerAlign) {
    final textTheme = context.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Row(
      mainAxisSize: centerAlign ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: centerAlign
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Text(
          '> ',
          style: (isMobile ? textTheme.headlineSmall : textTheme.headlineMedium)
              ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
        ),
        Flexible(
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(milliseconds: 1500),
            animatedTexts: [
              TypewriterAnimatedText(
                'Flutter Developer',
                textStyle:
                    (isMobile
                            ? textTheme.headlineSmall
                            : textTheme.headlineMedium)
                        ?.copyWith(fontWeight: FontWeight.w600),
                speed: const Duration(milliseconds: 80),
              ),
              TypewriterAnimatedText(
                'Mobile App Specialist',
                textStyle:
                    (isMobile
                            ? textTheme.headlineSmall
                            : textTheme.headlineMedium)
                        ?.copyWith(fontWeight: FontWeight.w600),
                speed: const Duration(milliseconds: 80),
              ),
              TypewriterAnimatedText(
                'Open Source Contributor',
                textStyle:
                    (isMobile
                            ? textTheme.headlineSmall
                            : textTheme.headlineMedium)
                        ?.copyWith(fontWeight: FontWeight.w600),
                speed: const Duration(milliseconds: 80),
              ),
            ],
          ),
        ),
        const _BlinkingCursor(),
      ],
    );
  }

  Widget _buildCTAButtons(BuildContext context, bool centerAlign) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Wrap(
      alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
      spacing: 16,
      runSpacing: 12,
      children: [
        PrimaryButton(
          text: 'View Projects',
          icon: Icons.work_rounded,
          onPressed: () => context.go(RouteNames.projects),
          width: isMobile ? double.infinity : null,
        ),
        SecondaryButton(
          text: 'Hire Me',
          icon: Icons.rocket_launch_rounded,
          onPressed: () => context.go(RouteNames.hireMe),
          width: isMobile ? double.infinity : null,
        ),
      ],
    );
  }

  Widget _buildScrollIndicator(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Scroll to explore',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        const _ScrollDownArrow(),
      ],
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Container(
            width: 3,
            height: 30,
            margin: const EdgeInsets.only(left: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      },
    );
  }
}

class _ScrollDownArrow extends StatefulWidget {
  const _ScrollDownArrow();

  @override
  State<_ScrollDownArrow> createState() => _ScrollDownArrowState();
}

class _ScrollDownArrowState extends State<_ScrollDownArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 12,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
