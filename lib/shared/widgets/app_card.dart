import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// ENUMS
// =============================================================================

enum AppCardVariant {
  /// White card with subtle border (default)
  flat,

  /// White card with blue-tinted shadow
  elevated,

  /// Transparent with border only
  outlined,

  /// Blue gradient background
  gradient,

  /// Primary container color background (soft blue)
  tinted,
}

// =============================================================================
// AppCard
// =============================================================================

/// A fully customizable card widget with 5 visual variants.
///
/// Supports tap, long-press, selection state, custom padding,
/// gradient, border radius, and any child widget.
///
/// ### Usage
/// ```dart
/// AppCard(
///   variant: AppCardVariant.elevated,
///   onTap: () => navigate(),
///   child: ListTile(title: Text('Hello')),
/// )
/// ```
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.flat,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.gradient,
    this.borderColor,
    this.borderWidth = 1,
    this.shadow,
    this.width,
    this.height,
    this.isSelected = false,
    this.clipBehavior = Clip.antiAlias,
    this.semanticLabel,
  });

  final Widget child;
  final AppCardVariant variant;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? shadow;
  final double? width;
  final double? height;

  /// Highlights the card with primary color border when true
  final bool isSelected;
  final Clip clipBehavior;
  final String? semanticLabel;

  // ---- Resolve colors by variant ----
  Color? _resolveColor() {
    if (backgroundColor != null) return backgroundColor;
    switch (variant) {
      case AppCardVariant.flat:
        return AppColors.surface;
      case AppCardVariant.elevated:
        return AppColors.surface;
      case AppCardVariant.outlined:
        return AppColors.transparent;
      case AppCardVariant.gradient:
        return null; // gradient handles it
      case AppCardVariant.tinted:
        return AppColors.primaryContainer;
    }
  }

  Gradient? _resolveGradient() {
    if (gradient != null) return gradient;
    if (variant == AppCardVariant.gradient) return AppColors.cardGradient;
    return null;
  }

  List<BoxShadow> _resolveShadow() {
    if (shadow != null) return shadow!;
    switch (variant) {
      case AppCardVariant.flat:
        return AppShadows.sm;
      case AppCardVariant.elevated:
        return AppShadows.md;
      case AppCardVariant.outlined:
        return [];
      case AppCardVariant.gradient:
        return AppShadows.md;
      case AppCardVariant.tinted:
        return [];
    }
  }

  Border? _resolveBorder() {
    if (isSelected) {
      return Border.all(color: AppColors.primary, width: 2);
    }
    if (borderColor != null) {
      return Border.all(color: borderColor!, width: borderWidth);
    }
    switch (variant) {
      case AppCardVariant.outlined:
        return Border.all(color: AppColors.border, width: borderWidth);
      case AppCardVariant.flat:
        return Border.all(color: AppColors.border.withValues(alpha: 0.5), width: 0.5);
      case AppCardVariant.tinted:
        return Border.all(color: AppColors.primaryLighter, width: 0.5);
      default:
        return null;
    }
  }

  BorderRadius get _radius =>
      borderRadius ?? AppSpacing.borderRadiusLg;

  @override
  Widget build(BuildContext context) {
    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: _resolveColor(),
        gradient: _resolveGradient(),
        borderRadius: _radius,
        border: _resolveBorder(),
        boxShadow: _resolveShadow(),
      ),
      child: ClipRRect(
        borderRadius: _radius,
        clipBehavior: clipBehavior,
        child: padding != null
            ? Padding(padding: padding!, child: child)
            : child,
      ),
    );

    if (onTap != null || onLongPress != null) {
      card = Semantics(
        label: semanticLabel,
        button: onTap != null,
        child: Material(
          color: Colors.transparent,
          borderRadius: _radius,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: _radius,
            splashColor: AppColors.ripple,
            highlightColor: AppColors.overlay,
            child: card,
          ),
        ),
      );
    }

    return card;
  }
}

// =============================================================================
// AppInfoCard — pre-built info card with icon + title + subtitle
// =============================================================================

/// Quick info/stat card with icon, title, subtitle, and optional trailing.
///
/// ```dart
/// AppInfoCard(
///   icon: Icons.people_rounded,
///   title: '1,240',
///   subtitle: 'Total Users',
///   trailing: Icon(Icons.trending_up, color: AppColors.success),
///   variant: AppCardVariant.tinted,
/// )
/// ```
class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.iconColor,
    this.iconBackgroundColor,
    this.variant = AppCardVariant.flat,
    this.onTap,
    this.padding,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final AppCardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: variant,
      onTap: onTap,
      padding: padding ?? AppSpacing.cardPadding,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? AppColors.primaryContainer,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.primary,
              size: AppSpacing.iconXl,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppTextStyles.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}
