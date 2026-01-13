import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryLight = Color(0xFF6366F1);
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryDark = Color(0xFF4338CA);

  static const Color accentLight = Color(0xFF22D3EE);
  static const Color accent = Color(0xFF06B6D4);
  static const Color accentDark = Color(0xFF0891B2);

  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);

  static const Color darkBg = Color(0xFF0A0A0A);
  static const Color darkBgSecondary = Color(0xFF111111);
  static const Color darkBgTertiary = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF141414);
  static const Color darkCardHover = Color(0xFF1E1E1E);
  static const Color darkBorder = Color(0xFF262626);
  static const Color darkBorderLight = Color(0xFF333333);

  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color lightBgSecondary = Color(0xFFF5F5F5);
  static const Color lightBgTertiary = Color(0xFFEEEEEE);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardHover = Color(0xFFF9FAFB);
  static const Color lightBorder = Color(0xFFE5E5E5);
  static const Color lightBorderDark = Color(0xFFD4D4D4);

  static const Color darkTextPrimary = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFA3A3A3);
  static const Color darkTextTertiary = Color(0xFF737373);
  static const Color darkTextMuted = Color(0xFF525252);

  static const Color lightTextPrimary = Color(0xFF0A0A0A);
  static const Color lightTextSecondary = Color(0xFF525252);
  static const Color lightTextTertiary = Color(0xFF737373);
  static const Color lightTextMuted = Color(0xFFA3A3A3);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary, accentDark],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentDark],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A0A0A), Color(0xFF0F0F1A), Color(0xFF0A0A0A)],
  );

  static const LinearGradient cardGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
  );

  static const LinearGradient ctaGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary, accentDark],
  );

  static const LinearGradient glowGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x336366F1), Color(0x00000000)],
  );

  static const Color flutterBlue = Color(0xFF02569B);
  static const Color dartBlue = Color(0xFF0175C2);
  static const Color firebaseOrange = Color(0xFFFFCA28);
  static const Color figmaPurple = Color(0xFFA259FF);
  static const Color gitOrange = Color(0xFFF05032);

  static const Color github = Color(0xFF181717);
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color buyMeACoffee = Color(0xFFFFDD00);
}

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
