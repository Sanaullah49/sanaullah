import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LoadingWidget extends StatefulWidget {
  final double size;
  final Color? color;

  const LoadingWidget({super.key, this.size = 40, this.color});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 6.28319,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  color.withValues(alpha: 0.0),
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.5),
                  color,
                ],
                stops: const [0.0, 0.25, 0.5, 1.0],
              ),
            ),
            child: Center(
              child: Container(
                width: widget.size * 0.7,
                height: widget.size * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final String? message;

  const LoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoadingWidget(size: 50),
            if (message != null) ...[
              const SizedBox(height: 20),
              Text(
                message!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
