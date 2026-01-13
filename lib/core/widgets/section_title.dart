import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/theme_provider.dart';
import '../utils/responsive_utils.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? tag;
  final bool centerAlign;
  final Color? accentColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.tag,
    this.centerAlign = true,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final isMobile = context.isMobile;
    final accent = accentColor ?? AppColors.primary;

    return Column(
      crossAxisAlignment: centerAlign
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (tag != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: accent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              tag!,
              style: textTheme.labelMedium?.copyWith(
                color: accent,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],

        Text(
          title,
          style: isMobile ? textTheme.headlineMedium : textTheme.headlineLarge,
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
        ),

        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              subtitle!,
              style: textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: centerAlign ? TextAlign.center : TextAlign.start,
            ),
          ),
        ],

        const SizedBox(height: 32),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent, accent.withValues(alpha: 0.5)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
