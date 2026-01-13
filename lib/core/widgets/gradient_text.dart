import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient? gradient;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    this.gradient,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => (gradient ?? AppColors.primaryGradient)
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final List<Color>? colors;
  final Duration duration;

  const AnimatedGradientText({
    super.key,
    required this.text,
    this.style,
    this.colors,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors =
        widget.colors ??
        [
          AppColors.primaryLight,
          AppColors.accent,
          AppColors.primary,
          AppColors.primaryLight,
        ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: colors,
              stops: const [0.0, 0.33, 0.66, 1.0],
              begin: Alignment(-1.0 + (2 * _controller.value), 0),
              end: Alignment(1.0 + (2 * _controller.value), 0),
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Text(widget.text, style: widget.style),
    );
  }
}
