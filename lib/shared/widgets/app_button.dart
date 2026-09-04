import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// ENUMS
// =============================================================================

enum AppButtonType { primary, secondary, outlined, text, danger, success, warning }

enum AppButtonSize { sm, md, lg }

// =============================================================================
// AppButton
// =============================================================================

/// A fully customizable, production-grade button widget.
///
/// Supports 7 visual variants, 3 sizes, optional icons, loading state,
/// gradient override, and full-width mode.
///
/// ### Basic Usage
/// ```dart
/// AppButton(label: 'Submit', onPressed: () {})
/// ```
///
/// ### CTA with gradient + icon
/// ```dart
/// AppButton(
///   label: 'Get Started',
///   onPressed: () {},
///   type: AppButtonType.primary,
///   prefixIcon: Icons.rocket_launch_rounded,
///   gradient: AppColors.accentGradient,
///   isFullWidth: true,
/// )
/// ```
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.md,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isDisabled = false,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.elevation,
    this.tooltip,
    this.splashColor,
    this.iconSize,
    this.gap,
  });

  /// Button label text
  final String label;

  /// Tap callback — set null to disable
  final VoidCallback? onPressed;

  /// Visual variant
  final AppButtonType type;

  /// Size preset
  final AppButtonSize size;

  /// Optional leading icon
  final IconData? prefixIcon;

  /// Optional trailing icon
  final IconData? suffixIcon;

  /// Shows a CircularProgressIndicator and disables tap when true
  final bool isLoading;

  /// Stretch to parent width
  final bool isFullWidth;

  /// Disable interaction (also triggered when onPressed is null)
  final bool isDisabled;

  /// Override background with a gradient (only for filled types)
  final Gradient? gradient;

  /// Override corner radius
  final BorderRadius? borderRadius;

  /// Override internal padding
  final EdgeInsetsGeometry? padding;

  /// Override label text style
  final TextStyle? textStyle;

  /// Override background color
  final Color? backgroundColor;

  /// Override text/icon color
  final Color? foregroundColor;

  /// Override border color (outlined type only)
  final Color? borderColor;

  /// Override elevation
  final double? elevation;

  /// Tooltip message on long press
  final String? tooltip;

  /// Override splash/ripple color
  final Color? splashColor;

  /// Override icon size
  final double? iconSize;

  /// Gap between icon and label
  final double? gap;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      lowerBound: 0.97,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _scaleController.drive(CurveTween(curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  bool get _effectivelyDisabled =>
      widget.isDisabled || widget.isLoading || widget.onPressed == null;

  // ---- Size tokens ----
  double get _height {
    switch (widget.size) {
      case AppButtonSize.sm:
        return AppSpacing.buttonHeightSm;
      case AppButtonSize.lg:
        return AppSpacing.buttonHeightLg;
      case AppButtonSize.md:
        return AppSpacing.buttonHeight;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case AppButtonSize.sm:
        return 13;
      case AppButtonSize.lg:
        return 17;
      case AppButtonSize.md:
        return 15;
    }
  }

  double get _iconSize => widget.iconSize ?? (widget.size == AppButtonSize.sm ? 16 : 20);

  EdgeInsetsGeometry get _padding =>
      widget.padding ??
      EdgeInsets.symmetric(
        horizontal: widget.size == AppButtonSize.sm
            ? AppSpacing.md
            : widget.size == AppButtonSize.lg
                ? AppSpacing.xxl
                : AppSpacing.xl,
        vertical: 0,
      );

  BorderRadius get _radius =>
      widget.borderRadius ??
      (widget.size == AppButtonSize.sm
          ? AppSpacing.borderRadiusSm
          : AppSpacing.borderRadiusLg);

  // ---- Color tokens by type ----
  _ButtonColors get _colors {
    if (_effectivelyDisabled) {
      return _ButtonColors(
        background: AppColors.border,
        foreground: AppColors.textDisabled,
        border: Colors.transparent,
        shadow: [],
      );
    }
    switch (widget.type) {
      case AppButtonType.primary:
        return _ButtonColors(
          background: widget.backgroundColor ?? AppColors.primary,
          foreground: widget.foregroundColor ?? AppColors.textOnPrimary,
          border: Colors.transparent,
          shadow: AppShadows.primaryButton,
        );
      case AppButtonType.secondary:
        return _ButtonColors(
          background: widget.backgroundColor ?? AppColors.primaryContainer,
          foreground: widget.foregroundColor ?? AppColors.primary,
          border: Colors.transparent,
          shadow: AppShadows.sm,
        );
      case AppButtonType.outlined:
        return _ButtonColors(
          background: widget.backgroundColor ?? Colors.transparent,
          foreground: widget.foregroundColor ?? AppColors.primary,
          border: widget.borderColor ?? AppColors.primary,
          shadow: [],
        );
      case AppButtonType.text:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: widget.foregroundColor ?? AppColors.primary,
          border: Colors.transparent,
          shadow: [],
        );
      case AppButtonType.danger:
        return _ButtonColors(
          background: widget.backgroundColor ?? AppColors.error,
          foreground: widget.foregroundColor ?? AppColors.textOnPrimary,
          border: Colors.transparent,
          shadow: [
            BoxShadow(
              color: AppColors.error.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
      case AppButtonType.success:
        return _ButtonColors(
          background: widget.backgroundColor ?? AppColors.success,
          foreground: widget.foregroundColor ?? AppColors.textOnPrimary,
          border: Colors.transparent,
          shadow: [
            BoxShadow(
              color: AppColors.success.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
      case AppButtonType.warning:
        return _ButtonColors(
          background: widget.backgroundColor ?? AppColors.warning,
          foreground: widget.foregroundColor ?? AppColors.textOnPrimary,
          border: Colors.transparent,
          shadow: [
            BoxShadow(
              color: AppColors.warning.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
    }
  }

  void _onTapDown(_) {
    if (!_effectivelyDisabled) _scaleController.reverse();
  }

  void _onTapUp(_) {
    if (!_effectivelyDisabled) _scaleController.forward();
  }

  void _onTapCancel() {
    if (!_effectivelyDisabled) _scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colors;
    final gap = widget.gap ?? (widget.size == AppButtonSize.sm ? 6.0 : 8.0);

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(colors.foreground),
            ),
          ),
          SizedBox(width: gap),
        ] else if (widget.prefixIcon != null) ...[
          Icon(widget.prefixIcon, size: _iconSize, color: colors.foreground),
          SizedBox(width: gap),
        ],
        Text(
          widget.label,
          style: (widget.textStyle ??
                  AppTextStyles.button.copyWith(fontSize: _fontSize))
              .copyWith(color: colors.foreground),
        ),
        if (!widget.isLoading && widget.suffixIcon != null) ...[
          SizedBox(width: gap),
          Icon(widget.suffixIcon, size: _iconSize, color: colors.foreground),
        ],
      ],
    );

    final bool hasGradient = widget.gradient != null && !_effectivelyDisabled;

    Widget button = GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (_, child) => Transform.scale(scale: _scaleAnim.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _height,
          decoration: BoxDecoration(
            color: hasGradient ? null : colors.background,
            gradient: hasGradient ? widget.gradient : null,
            borderRadius: _radius,
            border: colors.border == Colors.transparent
                ? null
                : Border.all(color: colors.border, width: 1.5),
            boxShadow: _effectivelyDisabled ? [] : colors.shadow,
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: _radius,
            child: InkWell(
              onTap: _effectivelyDisabled ? null : widget.onPressed,
              borderRadius: _radius,
              splashColor:
                  widget.splashColor ?? colors.foreground.withValues(alpha: 0.12),
              highlightColor: colors.foreground.withValues(alpha: 0.06),
              child: Padding(
                padding: _padding,
                child: buttonChild,
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    return button;
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    required this.border,
    required this.shadow,
  });
  final Color background;
  final Color foreground;
  final Color border;
  final List<BoxShadow> shadow;
}

// =============================================================================
// AppIconButton — standalone icon-only button
// =============================================================================

/// Circular / square icon-only button with variants.
///
/// ```dart
/// AppIconButton(
///   icon: Icons.favorite_rounded,
///   onPressed: () {},
///   variant: AppIconButtonVariant.filled,
///   color: AppColors.error,
/// )
/// ```
enum AppIconButtonVariant { plain, filled, tonal, outlined }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppIconButtonVariant.plain,
    this.size = 40,
    this.iconSize,
    this.color,
    this.backgroundColor,
    this.tooltip,
    this.borderRadius,
    this.isCircular = true,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final double size;
  final double? iconSize;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;
  final BorderRadius? borderRadius;
  final bool isCircular;

  Color get _iconColor {
    if (color != null) return color!;
    switch (variant) {
      case AppIconButtonVariant.plain:
        return AppColors.textSecondary;
      case AppIconButtonVariant.filled:
        return AppColors.textOnPrimary;
      case AppIconButtonVariant.tonal:
        return AppColors.primary;
      case AppIconButtonVariant.outlined:
        return AppColors.primary;
    }
  }

  Color get _bgColor {
    if (backgroundColor != null) return backgroundColor!;
    switch (variant) {
      case AppIconButtonVariant.plain:
        return Colors.transparent;
      case AppIconButtonVariant.filled:
        return color ?? AppColors.primary;
      case AppIconButtonVariant.tonal:
        return AppColors.primaryContainer;
      case AppIconButtonVariant.outlined:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ??
        (isCircular
            ? AppSpacing.borderRadiusFull
            : AppSpacing.borderRadiusMd);

    Widget btn = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: radius,
        border: variant == AppIconButtonVariant.outlined
            ? Border.all(color: color ?? AppColors.primary, width: 1.5)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onPressed,
          borderRadius: radius,
          child: Center(
            child: Icon(icon, size: iconSize ?? size * 0.5, color: _iconColor),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      btn = Tooltip(message: tooltip!, child: btn);
    }

    return btn;
  }
}
