import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

/// Climax App — Typography System
///
/// Font: Inter (Google Fonts standard)
/// Scale: Responsive — font sizes adjust per screen
/// Weight system: Regular(400), Medium(500), SemiBold(600), Bold(700)
abstract final class AppTextStyles {
  // ---------------------------------------------------------------------------
  // Display (Hero headings, splash)
  // ---------------------------------------------------------------------------
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.22,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------------
  // Headline (Screen titles, section headers)
  // ---------------------------------------------------------------------------
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.28,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.33,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------------
  // Title (Card titles, dialog titles, list headers)
  // ---------------------------------------------------------------------------
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------------
  // Label (Button labels, tags, chips, nav items)
  // ---------------------------------------------------------------------------
  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
  );

  // ---------------------------------------------------------------------------
  // Body (Main content, paragraphs)
  // ---------------------------------------------------------------------------
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  // ---------------------------------------------------------------------------
  // Special Purpose Styles
  // ---------------------------------------------------------------------------

  /// App Bar title
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
  );

  /// Caption / timestamp / meta
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.4,
    color: AppColors.textTertiary,
  );

  /// Overline (category labels, breadcrumbs)
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.6,
    letterSpacing: 1.5,
    color: AppColors.textSecondary,
  );

  /// Button text
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
  );

  /// Button text (small)
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.5,
    color: AppColors.textOnPrimary,
  );

  /// Input field text
  static const TextStyle input = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  /// Input hint
  static const TextStyle inputHint = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.1,
    color: AppColors.textTertiary,
  );

  /// Price / numeric (bold, monospace feel)
  static const TextStyle price = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.primary,
  );

  /// Badge / chip count
  static const TextStyle badge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0.2,
    color: AppColors.textOnPrimary,
  );

  // ---------------------------------------------------------------------------
  // Responsive Helpers
  // ---------------------------------------------------------------------------

  /// Returns a responsive headline — scales up on tablet/desktop
  static TextStyle responsiveHeadline(BuildContext context) {
    return responsiveValue<TextStyle>(
      context,
      mobile: headlineSmall,
      tablet: headlineMedium,
      desktop: headlineLarge,
    );
  }

  /// Returns a responsive body text size
  static TextStyle responsiveBody(BuildContext context) {
    return responsiveValue<TextStyle>(
      context,
      mobile: bodyMedium,
      tablet: bodyLarge,
      desktop: bodyLarge,
    );
  }

  /// Returns a responsive title
  static TextStyle responsiveTitle(BuildContext context) {
    return responsiveValue<TextStyle>(
      context,
      mobile: titleMedium,
      tablet: titleLarge,
      desktop: headlineSmall,
    );
  }
}
