import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';
import 'app_button.dart';

// =============================================================================
// AppEmptyState
// =============================================================================

enum AppEmptyStateType { empty, error, noInternet, noResults, unauthorized, custom }

/// A pre-built empty / error / no-internet state widget with icon, title,
/// message, and optional action button.
///
/// ```dart
/// // No data
/// AppEmptyState(
///   type: AppEmptyStateType.empty,
///   title: 'No Orders Yet',
///   message: 'Your order list is empty. Start shopping!',
///   actionLabel: 'Browse Products',
///   onAction: () => navigate(),
/// )
///
/// // Network error with retry
/// AppEmptyState(
///   type: AppEmptyStateType.noInternet,
///   onAction: () => retry(),
/// )
///
/// // API error
/// AppEmptyState.error(message: e.toString(), onRetry: retry)
/// ```
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.type = AppEmptyStateType.empty,
    this.title,
    this.message,
    this.icon,
    this.illustration,
    this.actionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.padding,
    this.iconSize = 80,
    this.isCompact = false,
  });

  /// Quick constructor for error state
  factory AppEmptyState.error({
    Key? key,
    String? message,
    VoidCallback? onRetry,
  }) {
    return AppEmptyState(
      key: key,
      type: AppEmptyStateType.error,
      message: message,
      actionLabel: 'Try Again',
      onAction: onRetry,
    );
  }

  /// Quick constructor for no-internet state
  factory AppEmptyState.noInternet({
    Key? key,
    VoidCallback? onRetry,
  }) {
    return AppEmptyState(
      key: key,
      type: AppEmptyStateType.noInternet,
      actionLabel: 'Retry',
      onAction: onRetry,
    );
  }

  final AppEmptyStateType type;
  final String? title;
  final String? message;
  final IconData? icon;

  /// Optional custom illustration widget (e.g. Lottie, SVG)
  final Widget? illustration;

  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final EdgeInsetsGeometry? padding;
  final double iconSize;

  /// Compact mode for use inside cards or lists
  final bool isCompact;

  _EmptyStateConfig get _config {
    switch (type) {
      case AppEmptyStateType.empty:
        return _EmptyStateConfig(
          icon: icon ?? Icons.inbox_rounded,
          iconColor: AppColors.textTertiary,
          iconBg: AppColors.backgroundAlt,
          title: title ?? 'Nothing here yet',
          message: message ?? 'No data available at the moment.',
        );
      case AppEmptyStateType.error:
        return _EmptyStateConfig(
          icon: icon ?? Icons.error_outline_rounded,
          iconColor: AppColors.error,
          iconBg: AppColors.errorContainer,
          title: title ?? 'Something went wrong',
          message: message ?? 'An unexpected error occurred. Please try again.',
        );
      case AppEmptyStateType.noInternet:
        return _EmptyStateConfig(
          icon: icon ?? Icons.wifi_off_rounded,
          iconColor: AppColors.warning,
          iconBg: AppColors.warningContainer,
          title: title ?? 'No Internet Connection',
          message: message ??
              'Check your network settings and try again.',
        );
      case AppEmptyStateType.noResults:
        return _EmptyStateConfig(
          icon: icon ?? Icons.search_off_rounded,
          iconColor: AppColors.textTertiary,
          iconBg: AppColors.backgroundAlt,
          title: title ?? 'No Results Found',
          message:
              message ?? 'Try adjusting your search or filters.',
        );
      case AppEmptyStateType.unauthorized:
        return _EmptyStateConfig(
          icon: icon ?? Icons.lock_outline_rounded,
          iconColor: AppColors.primary,
          iconBg: AppColors.primaryContainer,
          title: title ?? 'Access Restricted',
          message: message ??
              'You do not have permission to view this content.',
        );
      case AppEmptyStateType.custom:
        return _EmptyStateConfig(
          icon: icon ?? Icons.info_outline_rounded,
          iconColor: AppColors.primary,
          iconBg: AppColors.primaryContainer,
          title: title ?? '',
          message: message ?? '',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cfg = _config;
    final iconContainerSize = isCompact ? iconSize * 0.75 : iconSize;

    return Center(
      child: Padding(
        padding: padding ??
            EdgeInsets.all(isCompact ? AppSpacing.base : AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration or Icon
            if (illustration != null)
              illustration!
            else
              _AnimatedIconContainer(
                size: iconContainerSize,
                backgroundColor: cfg.iconBg,
                child: Icon(
                  cfg.icon,
                  size: iconContainerSize * 0.5,
                  color: cfg.iconColor,
                ),
              ),

            SizedBox(height: isCompact ? AppSpacing.md : AppSpacing.xl),

            // Title
            if (cfg.title.isNotEmpty)
              Text(
                cfg.title,
                style: isCompact
                    ? AppTextStyles.titleSmall
                    : AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                textAlign: TextAlign.center,
              ),

            if (cfg.message.isNotEmpty) ...[
              SizedBox(height: isCompact ? AppSpacing.xs : AppSpacing.sm),
              Text(
                cfg.message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            if (onAction != null) ...[
              SizedBox(height: isCompact ? AppSpacing.md : AppSpacing.xxl),
              AppButton(
                label: actionLabel ?? 'Try Again',
                onPressed: onAction,
                type: type == AppEmptyStateType.error
                    ? AppButtonType.danger
                    : AppButtonType.primary,
                size: isCompact ? AppButtonSize.sm : AppButtonSize.md,
                prefixIcon: type == AppEmptyStateType.noInternet
                    ? Icons.refresh_rounded
                    : null,
              ),
            ],

            if (onSecondaryAction != null) ...[
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: secondaryActionLabel ?? 'Go Back',
                onPressed: onSecondaryAction,
                type: AppButtonType.outlined,
                size: isCompact ? AppButtonSize.sm : AppButtonSize.md,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyStateConfig {
  const _EmptyStateConfig({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.message,
  });
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String message;
}

class _AnimatedIconContainer extends StatefulWidget {
  const _AnimatedIconContainer({
    required this.child,
    required this.size,
    required this.backgroundColor,
  });
  final Widget child;
  final double size;
  final Color backgroundColor;

  @override
  State<_AnimatedIconContainer> createState() =>
      _AnimatedIconContainerState();
}

class _AnimatedIconContainerState extends State<_AnimatedIconContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
