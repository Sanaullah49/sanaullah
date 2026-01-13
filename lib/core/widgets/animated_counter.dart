import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final String value;
  final String? suffix;
  final String? prefix;
  final TextStyle? style;
  final Duration duration;
  final bool animate;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.suffix,
    this.prefix,
    this.style,
    this.duration = const Duration(milliseconds: 2000),
    this.animate = true,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int? _numericValue;
  String _nonNumericValue = '';

  @override
  void initState() {
    super.initState();
    _parseValue();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    if (widget.animate && _numericValue != null) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  void _parseValue() {
    final regex = RegExp(r'^(\d+)(.*)$');
    final match = regex.firstMatch(widget.value);

    if (match != null) {
      _numericValue = int.tryParse(match.group(1) ?? '');
      _nonNumericValue = match.group(2) ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_numericValue == null) {
      return Text(
        '${widget.prefix ?? ''}${widget.value}${widget.suffix ?? ''}',
        style: widget.style,
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentValue = (_animation.value * _numericValue!).round();
        return Text(
          '${widget.prefix ?? ''}$currentValue$_nonNumericValue${widget.suffix ?? ''}',
          style: widget.style,
        );
      },
    );
  }
}
