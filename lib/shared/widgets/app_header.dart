import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/themes/themes.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// The main title (e.g. User Name or Page Title)
  final String? title;
  
  /// The subtitle (e.g. Good Morning or description). 
  /// Overrides [showGreeting] if provided.
  final String? subtitle;
  
  /// Whether to show dynamic greeting like "Good Morning" as subtitle
  final bool showGreeting;
  
  /// Custom widget for the left side. If null, a default profile icon or back button is shown.
  final Widget? leading;
  
  /// Show back button instead of profile icon? Default is false.
  final bool showBack;
  
  /// Actions for the right side. If null and showNotification is true, shows default notification icon.
  final List<Widget>? actions;
  
  /// Shortcut to show the default notification icon
  final bool showNotification;
  
  /// Callback for the default notification icon
  final VoidCallback? onNotificationTap;
  
  /// Custom background color. Defaults to [AppColors.surface].
  final Color? backgroundColor;

  const AppHeader({
    super.key,
    this.title,
    this.subtitle,
    this.showGreeting = false,
    this.leading,
    this.showBack = false,
    this.actions,
    this.showNotification = false,
    this.onNotificationTap,
    this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    // Determine subtitle
    final displaySubtitle = subtitle ?? (showGreeting ? _getGreeting() : null);

    // Determine leading widget
    Widget? leadingWidget = leading;
    if (leadingWidget == null) {
      if (showBack) {
        leadingWidget = IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        );
      } else {
        // Default Profile Icon
        leadingWidget = Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primary,
            ),
          ),
        );
      }
    }

    // Determine actions
    List<Widget>? actionWidgets = actions;
    if (actionWidgets == null && showNotification) {
      actionWidgets = [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
              border: Border.all(color: AppColors.border),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimary,
              ),
              onPressed: onNotificationTap,
            ),
          ),
        ),
      ];
    }

    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.surface,
      elevation: 0,
      toolbarHeight: 70,
      leadingWidth: (showBack && leading == null) ? 56 : 64,
      leading: leadingWidget,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (displaySubtitle != null)
            Text(
              displaySubtitle,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          if (displaySubtitle != null && title != null)
            const SizedBox(height: 2),
          if (title != null)
            Text(
              title!,
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
      actions: actionWidgets,
    );
  }
}
