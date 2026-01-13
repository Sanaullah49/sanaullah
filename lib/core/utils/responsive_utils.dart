import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../theme/app_spacing.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static bool isMobile(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isMobile;
  }

  static bool isTablet(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isTablet;
  }

  static bool isDesktop(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isDesktop;
  }

  static bool isLargerThanMobile(BuildContext context) {
    return ResponsiveBreakpoints.of(context).largerThan(MOBILE);
  }

  static bool isLargerThanTablet(BuildContext context) {
    return ResponsiveBreakpoints.of(context).largerThan(TABLET);
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? desktop;
    return desktop;
  }

  static double getHorizontalPadding(BuildContext context) {
    return responsiveValue<double>(
      context,
      mobile: AppSpacing.pagePaddingMobile,
      tablet: AppSpacing.pagePaddingTablet,
      desktop: AppSpacing.pagePaddingDesktop,
    );
  }

  static double getSectionPadding(BuildContext context) {
    return responsiveValue<double>(
      context,
      mobile: AppSpacing.sectionVerticalMobile,
      desktop: AppSpacing.sectionVertical,
    );
  }

  static double getCardPadding(BuildContext context) {
    return responsiveValue<double>(
      context,
      mobile: AppSpacing.cardPaddingMobile,
      desktop: AppSpacing.cardPadding,
    );
  }

  static int getGridColumns(
    BuildContext context, {
    int? mobile,
    int? tablet,
    int? desktop,
  }) {
    return responsiveValue<int>(
      context,
      mobile: mobile ?? 1,
      tablet: tablet ?? 2,
      desktop: desktop ?? 3,
    );
  }

  static double getGridAspectRatio(BuildContext context) {
    return responsiveValue<double>(
      context,
      mobile: 0.9,
      tablet: 0.85,
      desktop: 0.8,
    );
  }

  static bool is4K(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1921;
  }

  static bool isSmallMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 380;
  }

  static double getAdaptiveFontScale(BuildContext context) {
    if (isSmallMobile(context)) return 0.9;
    if (isMobile(context)) return 1.0;
    if (isTablet(context)) return 1.05;
    if (is4K(context)) return 1.2;
    return 1.1;
  }
}

extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isLargerThanMobile => ResponsiveUtils.isLargerThanMobile(this);

  double get screenWidth => ResponsiveUtils.screenWidth(this);
  double get screenHeight => ResponsiveUtils.screenHeight(this);
  double get horizontalPadding => ResponsiveUtils.getHorizontalPadding(this);
  double get sectionPadding => ResponsiveUtils.getSectionPadding(this);

  T responsive<T>({required T mobile, T? tablet, required T desktop}) {
    return ResponsiveUtils.responsiveValue(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
