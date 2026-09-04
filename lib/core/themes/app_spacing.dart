import 'package:flutter/material.dart';

/// Climax App — Responsive Spacing & Layout Tokens
///
/// Breakpoints:
///   mobile  → width < 600
///   tablet  → 600 <= width < 1024
///   desktop → width >= 1024
abstract final class AppSpacing {
  // ---------------------------------------------------------------------------
  // Base Spacing Scale (4pt grid)
  // ---------------------------------------------------------------------------
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double base = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 40.0;
  static const double huge = 48.0;
  static const double massive = 64.0;

  // ---------------------------------------------------------------------------
  // Responsive Horizontal Page Padding
  // ---------------------------------------------------------------------------
  static double pagePadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 1024) return 80.0;
    if (w >= 600) return 40.0;
    return base;
  }

  static EdgeInsets pageInsets(BuildContext context) => EdgeInsets.symmetric(
        horizontal: pagePadding(context),
        vertical: base,
      );

  static EdgeInsets pagePaddingH(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: pagePadding(context));

  // ---------------------------------------------------------------------------
  // Border Radius
  // ---------------------------------------------------------------------------
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;
  static const double radiusFull = 999.0; // Pill / circle

  static const BorderRadius borderRadiusXs =
      BorderRadius.all(Radius.circular(radiusXs));
  static const BorderRadius borderRadiusSm =
      BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderRadiusMd =
      BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderRadiusLg =
      BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderRadiusXl =
      BorderRadius.all(Radius.circular(radiusXl));
  static const BorderRadius borderRadiusXxl =
      BorderRadius.all(Radius.circular(radiusXxl));
  static const BorderRadius borderRadiusFull =
      BorderRadius.all(Radius.circular(radiusFull));

  // ---------------------------------------------------------------------------
  // Icon Sizes
  // ---------------------------------------------------------------------------
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconLg = 24.0;
  static const double iconXl = 32.0;
  static const double iconXxl = 48.0;

  // ---------------------------------------------------------------------------
  // Button Dimensions
  // ---------------------------------------------------------------------------
  static const double buttonHeight = 52.0;
  static const double buttonHeightSm = 40.0;
  static const double buttonHeightLg = 60.0;
  static const double buttonMinWidth = 120.0;

  // ---------------------------------------------------------------------------
  // AppBar
  // ---------------------------------------------------------------------------
  static const double appBarHeight = 60.0;

  // ---------------------------------------------------------------------------
  // Card
  // ---------------------------------------------------------------------------
  static const EdgeInsets cardPadding =
      EdgeInsets.symmetric(horizontal: base, vertical: md);

  // ---------------------------------------------------------------------------
  // Breakpoints
  // ---------------------------------------------------------------------------
  static const double mobileMax = 600.0;
  static const double tabletMax = 1024.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletMax;
}

/// Responsive Layout Builder Widget
///
/// Usage:
/// ```dart
/// ResponsiveLayout(
///   mobile: MobileView(),
///   tablet: TabletView(),   // optional
///   desktop: DesktopView(), // optional
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppSpacing.tabletMax) {
          return desktop ?? tablet ?? mobile;
        }
        if (constraints.maxWidth >= AppSpacing.mobileMax) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}

/// Responsive Value Helper — returns different values per screen size
///
/// Usage:
/// ```dart
/// double size = responsiveValue(context, mobile: 14, tablet: 16, desktop: 18);
/// ```
T responsiveValue<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  T? desktop,
}) {
  final w = MediaQuery.sizeOf(context).width;
  if (w >= AppSpacing.tabletMax && desktop != null) return desktop;
  if (w >= AppSpacing.mobileMax && tablet != null) return tablet;
  return mobile;
}

/// Adaptive Grid Delegate based on screen width
SliverGridDelegate adaptiveGridDelegate(
  BuildContext context, {
  int mobileColumns = 1,
  int tabletColumns = 2,
  int desktopColumns = 3,
  double childAspectRatio = 1.0,
  double spacing = AppSpacing.base,
}) {
  final columns = responsiveValue<int>(
    context,
    mobile: mobileColumns,
    tablet: tabletColumns,
    desktop: desktopColumns,
  );
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    crossAxisSpacing: spacing,
    mainAxisSpacing: spacing,
    childAspectRatio: childAspectRatio,
  );
}
