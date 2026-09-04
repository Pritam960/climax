import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.padding,
    this.margin,
  });

  final String message;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withValues(alpha: 0.92),
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      textStyle: AppTextStyles.caption.copyWith(color: AppColors.surface),
      child: child,
    );
  }
}
