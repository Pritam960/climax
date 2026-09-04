import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

enum AppLogoSize { sm, md, lg, xl }

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = AppLogoSize.md,
    this.showText = true,
  });

  final AppLogoSize size;
  final bool showText;

  double get _iconSize {
    switch (size) {
      case AppLogoSize.sm:
        return 24;
      case AppLogoSize.md:
        return 32;
      case AppLogoSize.lg:
        return 48;
      case AppLogoSize.xl:
        return 64;
    }
  }

  TextStyle get _textStyle {
    switch (size) {
      case AppLogoSize.sm:
        return AppTextStyles.titleMedium;
      case AppLogoSize.md:
        return AppTextStyles.titleLarge;
      case AppLogoSize.lg:
        return AppTextStyles.headlineMedium;
      case AppLogoSize.xl:
        return AppTextStyles.displaySmall;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/main_logo.png',
          width: _iconSize,
          height: _iconSize,
          // Optional: handle error if the image isn't placed yet
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.image_not_supported_rounded,
            color: AppColors.primary,
            size: _iconSize,
          ),
        ),
        if (showText) ...[
          const SizedBox(width: AppSpacing.sm),
          Text(
            'FeeBook',
            style: _textStyle.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ],
    );
  }
}
