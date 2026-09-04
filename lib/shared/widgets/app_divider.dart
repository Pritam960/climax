import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// AppDivider — Horizontal divider
// =============================================================================

/// A styled horizontal divider with optional label in the center.
///
/// ```dart
/// AppDivider()
/// AppDivider(label: 'OR')
/// AppDivider(label: 'Continue with', thickness: 1.5)
/// ```
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.label,
    this.labelStyle,
    this.color,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.labelPadding = AppSpacing.base,
    this.margin,
  });

  final String? label;
  final TextStyle? labelStyle;
  final Color? color;
  final double thickness;
  final double indent;
  final double endIndent;
  final double labelPadding;
  final EdgeInsetsGeometry? margin;

  Widget _line() => Expanded(
        child: Container(
          height: thickness,
          color: color ?? AppColors.divider,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget divider;

    if (label != null) {
      divider = Row(
        children: [
          SizedBox(width: indent),
          _line(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: labelPadding),
            child: Text(
              label!,
              style: labelStyle ??
                  AppTextStyles.labelSmall
                      .copyWith(color: AppColors.textTertiary),
            ),
          ),
          _line(),
          SizedBox(width: endIndent),
        ],
      );
    } else {
      divider = Divider(
        color: color ?? AppColors.divider,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        height: thickness,
      );
    }

    if (margin != null) {
      return Padding(padding: margin!, child: divider);
    }
    return divider;
  }
}

// =============================================================================
// AppVerticalDivider — Vertical divider
// =============================================================================

/// A styled vertical divider for use in rows.
///
/// ```dart
/// Row(children: [
///   Text('Left'),
///   AppVerticalDivider(),
///   Text('Right'),
/// ])
/// ```
class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({
    super.key,
    this.height = 24,
    this.thickness = 1,
    this.color,
    this.indent = 0,
    this.margin,
  });

  final double height;
  final double thickness;
  final Color? color;
  final double indent;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    Widget divider = Container(
      height: height - indent * 2,
      width: thickness,
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: indent,
      ),
      color: color ?? AppColors.divider,
    );

    if (margin != null) {
      return Padding(padding: margin!, child: divider);
    }
    return divider;
  }
}

// =============================================================================
// AppSectionHeader — Section label with optional action
// =============================================================================

/// A consistent section header with title and optional trailing action button.
///
/// ```dart
/// AppSectionHeader(
///   title: 'Recent Orders',
///   actionLabel: 'View All',
///   onAction: () => navigateToAll(),
/// )
/// ```
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.titleStyle,
    this.padding,
    this.leadingIcon,
    this.leadingColor,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final IconData? leadingIcon;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.sm,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              size: AppSpacing.iconMd,
              color: leadingColor ?? AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: titleStyle ?? AppTextStyles.titleSmall,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: AppTextStyles.caption),
                ],
              ],
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(actionLabel!,
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.primary)),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 10,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// AppSpacer — Semantic spacing helper
// =============================================================================

/// Shorthand spacing widgets.
///
/// ```dart
/// AppSpacer.sm()    // SizedBox(height: 8)
/// AppSpacer.md()    // SizedBox(height: 12)
/// AppSpacer.base()  // SizedBox(height: 16)
/// AppSpacer.h(24)   // SizedBox(height: 24)
/// AppSpacer.w(16)   // SizedBox(width: 16)
/// ```
class AppSpacer extends StatelessWidget {
  const AppSpacer._({this.h, this.w});

  factory AppSpacer.xs() => const AppSpacer._(h: AppSpacing.xs);
  factory AppSpacer.sm() => const AppSpacer._(h: AppSpacing.sm);
  factory AppSpacer.md() => const AppSpacer._(h: AppSpacing.md);
  factory AppSpacer.base() => const AppSpacer._(h: AppSpacing.base);
  factory AppSpacer.lg() => const AppSpacer._(h: AppSpacing.lg);
  factory AppSpacer.xl() => const AppSpacer._(h: AppSpacing.xl);
  factory AppSpacer.xxl() => const AppSpacer._(h: AppSpacing.xxl);
  factory AppSpacer.h(double height) => AppSpacer._(h: height);
  factory AppSpacer.w(double width) => AppSpacer._(w: width);

  final double? h;
  final double? w;

  @override
  Widget build(BuildContext context) => SizedBox(height: h, width: w);
}
