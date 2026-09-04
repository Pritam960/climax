import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

enum AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  labelLarge,
  labelMedium,
  labelSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  });

  final String text;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  TextStyle get _style {
    TextStyle baseStyle;
    switch (variant) {
      case AppTextVariant.displayLarge:
        baseStyle = AppTextStyles.displayLarge;
        break;
      case AppTextVariant.displayMedium:
        baseStyle = AppTextStyles.displayMedium;
        break;
      case AppTextVariant.displaySmall:
        baseStyle = AppTextStyles.displaySmall;
        break;
      case AppTextVariant.headlineLarge:
        baseStyle = AppTextStyles.headlineLarge;
        break;
      case AppTextVariant.headlineMedium:
        baseStyle = AppTextStyles.headlineMedium;
        break;
      case AppTextVariant.headlineSmall:
        baseStyle = AppTextStyles.headlineSmall;
        break;
      case AppTextVariant.titleLarge:
        baseStyle = AppTextStyles.titleLarge;
        break;
      case AppTextVariant.titleMedium:
        baseStyle = AppTextStyles.titleMedium;
        break;
      case AppTextVariant.titleSmall:
        baseStyle = AppTextStyles.titleSmall;
        break;
      case AppTextVariant.labelLarge:
        baseStyle = AppTextStyles.labelLarge;
        break;
      case AppTextVariant.labelMedium:
        baseStyle = AppTextStyles.labelMedium;
        break;
      case AppTextVariant.labelSmall:
        baseStyle = AppTextStyles.labelSmall;
        break;
      case AppTextVariant.bodyLarge:
        baseStyle = AppTextStyles.bodyLarge;
        break;
      case AppTextVariant.bodyMedium:
        baseStyle = AppTextStyles.bodyMedium;
        break;
      case AppTextVariant.bodySmall:
        baseStyle = AppTextStyles.bodySmall;
        break;
    }

    if (color != null || fontWeight != null) {
      return baseStyle.copyWith(color: color, fontWeight: fontWeight);
    }
    return baseStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
