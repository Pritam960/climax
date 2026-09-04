import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// AppSnackbar — Static helper for showing styled snackbars
// =============================================================================

/// A static helper to show consistently styled snackbars.
///
/// All methods are static — no widget needed.
///
/// ```dart
/// AppSnackbar.success(context, 'Profile saved successfully!')
/// AppSnackbar.error(context, 'Login failed. Check credentials.')
/// AppSnackbar.warning(context, 'Your session will expire in 5 minutes.')
/// AppSnackbar.info(context, 'Update available. Restart to apply.')
/// AppSnackbar.show(
///   context,
///   message: 'Custom message',
///   icon: Icons.star_rounded,
///   backgroundColor: Colors.purple,
///   action: SnackBarAction(label: 'UNDO', onPressed: undo),
/// )
/// ```
abstract final class AppSnackbar {
  // ---- Success ----
  static void success(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior? behavior,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_rounded,
      iconColor: AppColors.success,
      accentColor: AppColors.success,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      behavior: behavior,
    );
  }

  // ---- Error ----
  static void error(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior? behavior,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.error_rounded,
      iconColor: AppColors.errorLight,
      accentColor: AppColors.errorLight,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      behavior: behavior,
    );
  }

  // ---- Warning ----
  static void warning(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior? behavior,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.warning_rounded,
      iconColor: AppColors.warningLight,
      accentColor: AppColors.warningLight,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      behavior: behavior,
    );
  }

  // ---- Info ----
  static void info(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior? behavior,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.info_rounded,
      iconColor: AppColors.primaryLight,
      accentColor: AppColors.primaryLight,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      behavior: behavior,
    );
  }

  // ---- Custom ----
  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    Color? accentColor,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior? behavior,
  }) {
    _show(
      context,
      message: message,
      icon: icon,
      iconColor: iconColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      behavior: behavior,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Color? iconColor,
    Color? accentColor,
    Color? backgroundColor,
    String? actionLabel,
    VoidCallback? onAction,
    required Duration duration,
    SnackBarBehavior? behavior,
  }) {
    // Dismiss any existing snackbar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: behavior ?? SnackBarBehavior.floating,
        backgroundColor: backgroundColor ?? AppColors.textPrimary,
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          side: accentColor != null
              ? BorderSide(color: accentColor.withValues(alpha: 0.4), width: 1)
              : BorderSide.none,
        ),
        padding: EdgeInsets.zero,
        content: _SnackbarContent(
          message: message,
          icon: icon,
          iconColor: iconColor,
          accentColor: accentColor,
        ),
        action: (actionLabel != null && onAction != null)
            ? SnackBarAction(
                label: actionLabel,
                textColor: accentColor ?? AppColors.primaryLight,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }
}

class _SnackbarContent extends StatelessWidget {
  const _SnackbarContent({
    required this.message,
    this.icon,
    this.iconColor,
    this.accentColor,
  });

  final String message;
  final IconData? icon;
  final Color? iconColor;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: accentColor != null
            ? Border(
                left: BorderSide(
                  color: accentColor!,
                  width: 3,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? AppColors.surface, size: AppSpacing.iconMd),
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.surface),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
