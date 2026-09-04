import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// AppLoader — Circular loading indicator
// =============================================================================

enum AppLoaderSize { sm, md, lg }

/// A styled circular progress indicator.
///
/// ```dart
/// AppLoader()
/// AppLoader(size: AppLoaderSize.sm, color: AppColors.success)
/// ```
class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size = AppLoaderSize.md,
    this.color,
    this.strokeWidth,
    this.label,
  });

  final AppLoaderSize size;
  final Color? color;
  final double? strokeWidth;
  final String? label;

  double get _dimension {
    switch (size) {
      case AppLoaderSize.sm:
        return 18;
      case AppLoaderSize.md:
        return 32;
      case AppLoaderSize.lg:
        return 48;
    }
  }

  double get _stroke {
    if (strokeWidth != null) return strokeWidth!;
    switch (size) {
      case AppLoaderSize.sm:
        return 2;
      case AppLoaderSize.md:
        return 3;
      case AppLoaderSize.lg:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget indicator = SizedBox(
      width: _dimension,
      height: _dimension,
      child: CircularProgressIndicator(
        strokeWidth: _stroke,
        valueColor: AlwaysStoppedAnimation(color ?? AppColors.primary),
        strokeCap: StrokeCap.round,
      ),
    );

    if (label != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          const SizedBox(height: AppSpacing.sm),
          Text(label!, style: AppTextStyles.bodySmall),
        ],
      );
    }

    return indicator;
  }
}

// =============================================================================
// AppLinearLoader — Linear progress bar
// =============================================================================

/// A linear progress bar — determinate or indeterminate.
///
/// ```dart
/// // Indeterminate
/// AppLinearLoader()
///
/// // Determinate 60%
/// AppLinearLoader(value: 0.6, label: 'Uploading...')
/// ```
class AppLinearLoader extends StatelessWidget {
  const AppLinearLoader({
    super.key,
    this.value,
    this.color,
    this.trackColor,
    this.height = 6,
    this.borderRadius,
    this.label,
    this.showPercentage = false,
  });

  /// null = indeterminate, 0.0–1.0 = progress
  final double? value;
  final Color? color;
  final Color? trackColor;
  final double height;
  final BorderRadius? borderRadius;
  final String? label;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ??
        BorderRadius.circular(height / 2);

    Widget bar = ClipRRect(
      borderRadius: radius,
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: trackColor ?? AppColors.primaryLighter,
        valueColor: AlwaysStoppedAnimation(color ?? AppColors.primary),
        borderRadius: radius,
      ),
    );

    if (label != null || showPercentage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null || showPercentage)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (label != null)
                    Text(label!, style: AppTextStyles.bodySmall),
                  if (showPercentage && value != null)
                    Text(
                      '${(value! * 100).toInt()}%',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: color ?? AppColors.primary),
                    ),
                ],
              ),
            ),
          bar,
        ],
      );
    }

    return bar;
  }
}

// =============================================================================
// AppLoadingOverlay — Full-screen or widget-level overlay
// =============================================================================

/// Wraps a child with a loading overlay. When isLoading=true, shows a
/// semi-transparent overlay with a centered spinner.
///
/// ```dart
/// AppLoadingOverlay(
///   isLoading: _isLoading,
///   child: MyPage(),
/// )
/// ```
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.label,
    this.overlayColor,
    this.loaderColor,
    this.blurBackground = false,
  });

  final Widget child;
  final bool isLoading;
  final String? label;
  final Color? overlayColor;
  final Color? loaderColor;
  final bool blurBackground;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: isLoading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: overlayColor ??
                    AppColors.surface.withValues(alpha: 0.75),
                child: Center(
                  child: AppCard(
                    variant: AppCardVariant.elevated,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxl,
                      vertical: AppSpacing.xl,
                    ),
                    child: AppLoader(
                      size: AppLoaderSize.lg,
                      color: loaderColor,
                      label: label,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// =============================================================================
// AppSkeletonLoader — Shimmer skeleton placeholder
// =============================================================================

/// A shimmer skeleton loader for placeholder UI.
///
/// ```dart
/// // Rectangle skeleton
/// AppSkeletonLoader(width: double.infinity, height: 20)
///
/// // Circle skeleton (for avatar)
/// AppSkeletonLoader(width: 48, height: 48, isCircle: true)
///
/// // Card skeleton preset
/// AppSkeletonLoader.card()
/// ```
class AppSkeletonLoader extends StatefulWidget {
  const AppSkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.isCircle = false,
    this.margin,
  });

  /// Pre-built card skeleton
  factory AppSkeletonLoader.card({Key? key}) {
    return AppSkeletonLoader(
      key: key,
      width: double.infinity,
      height: 100,
      borderRadius: AppSpacing.borderRadiusLg,
    );
  }

  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final EdgeInsetsGeometry? margin;

  @override
  State<AppSkeletonLoader> createState() => _AppSkeletonLoaderState();
}

class _AppSkeletonLoaderState extends State<AppSkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _anim = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.isCircle
        ? AppSpacing.borderRadiusFull
        : (widget.borderRadius ?? AppSpacing.borderRadiusSm);

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, _) {
        return Container(
          width: widget.width,
          height: widget.isCircle ? widget.width : widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment(-1.5, 0),
              end: Alignment(2.5, 0),
              stops: [
                (_anim.value - 0.5).clamp(0.0, 1.0),
                _anim.value.clamp(0.0, 1.0),
                (_anim.value + 0.5).clamp(0.0, 1.0),
              ],
              colors: const [
                AppColors.shimmerBase,
                AppColors.shimmerHighlight,
                AppColors.shimmerBase,
              ],
              transform: GradientRotation(_anim.value * 0.3),
            ),
          ),
        );
      },
    );
  }
}

/// Quick skeleton list item layout helper
class AppSkeletonListItem extends StatelessWidget {
  const AppSkeletonListItem({super.key, this.hasAvatar = true});
  final bool hasAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          if (hasAvatar) ...[
            AppSkeletonLoader(width: 48, height: 48, isCircle: true),
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSkeletonLoader(width: double.infinity, height: 14),
                const SizedBox(height: 8),
                AppSkeletonLoader(width: 160, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Keep AppCardVariant accessible without circular import
// (app_loader.dart uses AppCard which is defined in app_card.dart)
// Import app_card via widgets.dart barrel
enum AppCardVariant {
  flat,
  elevated,
  outlined,
  gradient,
  tinted,
}

/// Minimal inline card used inside AppLoadingOverlay
/// (avoids circular dependency — real AppCard lives in app_card.dart)
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.flat,
    this.padding,
  });
  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusXl,
        boxShadow: AppShadows.lg,
      ),
      child: child,
    );
  }
}
