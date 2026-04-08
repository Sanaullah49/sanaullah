import 'package:flutter/material.dart';
import 'app_colors.dart';

class DarkColorScheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: Colors.white,
    secondary: AppColors.accent,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.accentDark,
    onSecondaryContainer: Colors.white,
    tertiary: AppColors.success,
    onTertiary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.darkCard,
    onSurface: AppColors.darkTextPrimary,
    surfaceContainerHighest: AppColors.darkBgSecondary,
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: AppColors.darkBorder,
    outlineVariant: AppColors.darkBorderLight,
    shadow: Colors.black,
    scrim: Colors.black54,
    inverseSurface: AppColors.lightBg,
    onInverseSurface: AppColors.lightTextPrimary,
    inversePrimary: AppColors.primaryDark,
  );
}

class LightColorScheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: Colors.white,
    secondary: AppColors.accent,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.accentLight,
    onSecondaryContainer: AppColors.darkTextPrimary,
    tertiary: AppColors.success,
    onTertiary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.lightCard,
    onSurface: AppColors.lightTextPrimary,
    surfaceContainerHighest: AppColors.lightBgSecondary,
    onSurfaceVariant: AppColors.lightTextSecondary,
    outline: AppColors.lightBorder,
    outlineVariant: AppColors.lightBorderDark,
    shadow: Colors.black26,
    scrim: Colors.black38,
    inverseSurface: AppColors.darkBg,
    onInverseSurface: AppColors.darkTextPrimary,
    inversePrimary: AppColors.primaryLight,
  );
}
