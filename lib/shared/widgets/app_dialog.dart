import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';
import 'app_button.dart';

// =============================================================================
// AppDialog — Static dialog helpers
// =============================================================================

/// Static helpers to show consistently styled dialogs.
///
/// ```dart
/// // Alert
/// AppDialog.alert(
///   context,
///   title: 'Session Expired',
///   message: 'Please log in again.',
///   onConfirm: () => logout(),
/// )
///
/// // Confirm with destructive action
/// final confirmed = await AppDialog.confirm(
///   context,
///   title: 'Delete Account',
///   message: 'This action cannot be undone.',
///   confirmLabel: 'Delete',
///   isDestructive: true,
/// );
/// if (confirmed == true) deleteAccount();
///
/// // Custom
/// AppDialog.custom(
///   context,
///   child: MyCustomWidget(),
/// )
/// ```
abstract final class AppDialog {
  // ---- Alert (single confirm button) ----
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
    VoidCallback? onConfirm,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => _AppAlertDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        onConfirm: onConfirm,
        icon: icon,
        iconColor: iconColor,
      ),
    );
  }

  // ---- Confirm (confirm + cancel) ----
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
    IconData? icon,
    bool barrierDismissible = true,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => _AppConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDestructive: isDestructive,
        icon: icon,
      ),
    );
  }

  // ---- Loading dialog ----
  static Future<void> loading(
    BuildContext context, {
    String? message,
    bool barrierDismissible = false,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.textPrimary.withValues(alpha: 0.4),
      builder: (_) => _AppLoadingDialog(message: message),
    );
  }

  // ---- Custom child ----
  static Future<T?> custom<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Color? barrierColor,
  }) async {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.xxl,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? AppSpacing.borderRadiusXxl,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
          child: child,
        ),
      ),
    );
  }

  // ---- Close any dialog ----
  static void close(BuildContext context, [dynamic result]) {
    Navigator.of(context, rootNavigator: true).pop(result);
  }
}

// =============================================================================
// _AppAlertDialog
// =============================================================================
class _AppAlertDialog extends StatelessWidget {
  const _AppAlertDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.onConfirm,
    this.icon,
    this.iconColor,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback? onConfirm;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusXxl,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.base),
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: iconColor ?? AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.base),
            ],
            Text(title, style: AppTextStyles.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: confirmLabel,
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// _AppConfirmDialog
// =============================================================================
class _AppConfirmDialog extends StatelessWidget {
  const _AppConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    required this.isDestructive,
    this.icon,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusXxl,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.base),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.errorContainer
                      : AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: isDestructive ? AppColors.error : AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.base),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.errorContainer
                      : AppColors.warningContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDestructive
                      ? Icons.delete_outline_rounded
                      : Icons.help_outline_rounded,
                  size: 28,
                  color: isDestructive ? AppColors.error : AppColors.warning,
                ),
              ),
              const SizedBox(height: AppSpacing.base),
            ],
            Text(title, style: AppTextStyles.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: cancelLabel,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      onCancel?.call();
                    },
                    type: AppButtonType.outlined,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton(
                    label: confirmLabel,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      onConfirm?.call();
                    },
                    type: isDestructive
                        ? AppButtonType.danger
                        : AppButtonType.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// _AppLoadingDialog
// =============================================================================
class _AppLoadingDialog extends StatelessWidget {
  const _AppLoadingDialog({this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.borderRadiusXxl,
          boxShadow: AppShadows.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
                strokeCap: StrokeCap.round,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.base),
              Text(
                message!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// AppBottomSheet — Static helper for showing bottom sheets
// =============================================================================

/// Static helpers for styled bottom sheets.
///
/// ```dart
/// AppBottomSheet.show(
///   context,
///   title: 'Sort By',
///   child: SortOptions(),
/// )
/// ```
abstract final class AppBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    String? subtitle,
    bool isScrollControlled = true,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    double? initialChildSize,
    double? minChildSize,
    double? maxChildSize,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AppBottomSheetContainer(
        title: title,
        subtitle: subtitle,
        showDragHandle: showDragHandle,
        padding: padding,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        child: child,
      ),
    );
  }
}

class _AppBottomSheetContainer extends StatelessWidget {
  const _AppBottomSheetContainer({
    required this.child,
    this.title,
    this.subtitle,
    this.showDragHandle = true,
    this.padding,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showDragHandle;
  final EdgeInsetsGeometry? padding;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;

  @override
  Widget build(BuildContext context) {
    final hasTitle = title != null;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDragHandle)
          Center(
            child: Container(
              width: 48,
              height: 4,
              margin: const EdgeInsets.only(
                top: AppSpacing.sm,
                bottom: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: AppSpacing.borderRadiusFull,
              ),
            ),
          ),
        if (hasTitle) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title!, style: AppTextStyles.titleLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const Divider(height: 0),
        ],
        Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.base,
              ),
          child: child,
        ),
        SizedBox(height: MediaQuery.paddingOf(context).bottom),
      ],
    );

    if (initialChildSize != null) {
      content = DraggableScrollableSheet(
        initialChildSize: initialChildSize!,
        minChildSize: minChildSize ?? 0.3,
        maxChildSize: maxChildSize ?? 0.9,
        expand: false,
        builder: (_, scrollCtrl) => SingleChildScrollView(
          controller: scrollCtrl,
          child: content,
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXxl),
        ),
      ),
      child: content,
    );
  }
}
