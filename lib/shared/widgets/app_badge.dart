import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// AppBadge — Notification / count badge
// =============================================================================

enum AppBadgeVariant { primary, success, warning, error, info, neutral }

/// A small badge for counts, labels, or status indicators.
///
/// ```dart
/// // Count badge on icon
/// Stack(children: [
///   Icon(Icons.notifications),
///   Positioned(right: 0, top: 0, child: AppBadge(count: 3)),
/// ])
///
/// // Status badge
/// AppBadge(label: 'New', variant: AppBadgeVariant.success)
/// ```
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    this.count,
    this.label,
    this.variant = AppBadgeVariant.primary,
    this.maxCount = 99,
    this.size = 18,
    this.backgroundColor,
    this.textColor,
    this.isVisible = true,
    this.isPulsing = false,
    this.isDot = false,
  }) : assert(count != null || label != null || isDot,
            'Provide count, label, or set isDot = true');

  /// Numeric count (will show 99+ if > maxCount)
  final int? count;

  /// Text label (ignored if count is set)
  final String? label;

  final AppBadgeVariant variant;
  final int maxCount;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isVisible;

  /// Adds a pulsing animation (for live/alert status)
  final bool isPulsing;

  /// Shows only a small dot (no text)
  final bool isDot;

  Color get _bg {
    if (backgroundColor != null) return backgroundColor!;
    switch (variant) {
      case AppBadgeVariant.primary:
        return AppColors.primary;
      case AppBadgeVariant.success:
        return AppColors.success;
      case AppBadgeVariant.warning:
        return AppColors.warning;
      case AppBadgeVariant.error:
        return AppColors.error;
      case AppBadgeVariant.info:
        return AppColors.info;
      case AppBadgeVariant.neutral:
        return AppColors.textSecondary;
    }
  }

  String get _displayText {
    if (count != null) {
      return count! > maxCount ? '$maxCount+' : '$count';
    }
    return label ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    Widget badge;
    if (isDot) {
      badge = Container(
        width: size * 0.55,
        height: size * 0.55,
        decoration: BoxDecoration(
          color: _bg,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.surface, width: 1.5),
        ),
      );
    } else {
      final text = _displayText;
      final isShort = text.length <= 2;
      badge = AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: size,
        constraints: BoxConstraints(minWidth: size),
        padding: EdgeInsets.symmetric(horizontal: isShort ? 0 : size * 0.3),
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(color: AppColors.surface, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.textOnPrimary,
            fontSize: size * 0.58,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      );
    }

    if (isPulsing) {
      return _PulsingWrapper(color: _bg, child: badge);
    }

    return badge;
  }
}

class _PulsingWrapper extends StatefulWidget {
  const _PulsingWrapper({required this.child, required this.color});
  final Widget child;
  final Color color;

  @override
  State<_PulsingWrapper> createState() => _PulsingWrapperState();
}

class _PulsingWrapperState extends State<_PulsingWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 1.0).animate(
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
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withValues(alpha: _anim.value * 0.35),
            ),
            width: 20,
            height: 20,
          ),
          child!,
        ],
      ),
      child: widget.child,
    );
  }
}

// =============================================================================
// AppChip — Versatile chip / tag widget
// =============================================================================

enum AppChipVariant { filled, outlined, soft }

/// A flexible chip/tag widget with icon, avatar, delete button, and selection.
///
/// ```dart
/// AppChip(label: 'Flutter', prefixIcon: Icons.flutter_dash)
/// AppChip(label: 'Remove me', onDelete: () {})
/// AppChip(label: 'Selected', isSelected: true, onTap: () {})
/// ```
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.prefixIcon,
    this.avatar,
    this.onTap,
    this.onDelete,
    this.variant = AppChipVariant.soft,
    this.color,
    this.isSelected = false,
    this.isDisabled = false,
    this.textStyle,
    this.padding,
    this.height = 32,
    this.borderRadius,
  });

  final String label;
  final IconData? prefixIcon;

  /// Small widget shown before label (e.g. Avatar)
  final Widget? avatar;

  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final AppChipVariant variant;

  /// Base color (default: primary blue)
  final Color? color;

  final bool isSelected;
  final bool isDisabled;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double height;
  final BorderRadius? borderRadius;

  Color get _baseColor => color ?? AppColors.primary;

  Color get _backgroundColor {
    if (isDisabled) return AppColors.border;
    if (isSelected) {
      switch (variant) {
        case AppChipVariant.filled:
          return _baseColor;
        case AppChipVariant.outlined:
          return _baseColor.withValues(alpha: 0.1);
        case AppChipVariant.soft:
          return _baseColor;
      }
    }
    switch (variant) {
      case AppChipVariant.filled:
        return _baseColor.withValues(alpha: 0.15);
      case AppChipVariant.outlined:
        return Colors.transparent;
      case AppChipVariant.soft:
        return _baseColor.withValues(alpha: 0.1);
    }
  }

  Color get _textColor {
    if (isDisabled) return AppColors.textDisabled;
    if (isSelected && variant == AppChipVariant.filled) {
      return AppColors.textOnPrimary;
    }
    return _baseColor;
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppSpacing.borderRadiusFull;

    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: height,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: avatar != null ? AppSpacing.sm : AppSpacing.md,
                vertical: 0,
              ),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: radius,
            border: variant == AppChipVariant.outlined
                ? Border.all(
                    color: isSelected ? _baseColor : AppColors.border,
                    width: isSelected ? 1.5 : 1,
                  )
                : isSelected
                    ? Border.all(color: _baseColor, width: 1.5)
                    : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (avatar != null) ...[
                SizedBox(
                  width: height - 8,
                  height: height - 8,
                  child: avatar,
                ),
                const SizedBox(width: 6),
              ] else if (prefixIcon != null) ...[
                Icon(prefixIcon, size: 14, color: _textColor),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: (textStyle ?? AppTextStyles.labelMedium)
                    .copyWith(color: _textColor),
              ),
              if (isSelected && onDelete == null) ...[
                const SizedBox(width: 4),
                Icon(Icons.check_rounded, size: 14, color: _textColor),
              ],
              if (onDelete != null) ...[
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: isDisabled ? null : onDelete,
                  child: Icon(Icons.close_rounded, size: 14, color: _textColor),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// AppStatusBadge — semantic status indicator
// =============================================================================

/// Quick semantic status badge (Active, Pending, Cancelled, etc.)
///
/// ```dart
/// AppStatusBadge(status: 'Active')
/// AppStatusBadge(status: 'Rejected', isError: true)
/// ```
class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.status,
    this.color,
    this.backgroundColor,
    this.dotColor,
    this.showDot = true,
  });

  final String status;
  final Color? color;
  final Color? backgroundColor;
  final Color? dotColor;
  final bool showDot;

  static Color _colorFor(String status) {
    final s = status.toLowerCase();
    if (['active', 'success', 'completed', 'approved', 'verified']
        .any((k) => s.contains(k))) {
      return AppColors.success;
    }
    if (['pending', 'processing', 'in progress', 'waiting']
        .any((k) => s.contains(k))) {
      return AppColors.warning;
    }
    if (['rejected', 'failed', 'error', 'cancelled', 'blocked', 'banned']
        .any((k) => s.contains(k))) {
      return AppColors.error;
    }
    if (['info', 'review', 'draft'].any((k) => s.contains(k))) {
      return AppColors.info;
    }
    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final c = color ?? _colorFor(status);
    final bg = backgroundColor ?? c.withValues(alpha: 0.1);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppSpacing.borderRadiusFull,
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor ?? c,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            status,
            style: AppTextStyles.labelSmall.copyWith(
              color: c,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
