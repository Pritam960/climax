import 'package:flutter/material.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// AppAvatar
// =============================================================================

enum AppAvatarSize { xs, sm, md, lg, xl }

enum AppAvatarShape { circular, rounded }

/// A versatile avatar widget showing image, initials, or icon fallback.
///
/// ```dart
/// // Image avatar
/// AppAvatar(imageUrl: 'https://...', size: AppAvatarSize.lg)
///
/// // Initials avatar
/// AppAvatar(name: 'Pritam Sisodiya', size: AppAvatarSize.md)
///
/// // Icon fallback
/// AppAvatar(icon: Icons.person_rounded, size: AppAvatarSize.sm)
/// ```
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.icon,
    this.size = AppAvatarSize.md,
    this.shape = AppAvatarShape.circular,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.onTap,
    this.badge,
    this.boxShadow,
  });

  final String? imageUrl;

  /// Used to generate initials (first letter of each word, max 2)
  final String? name;

  /// Shown when no imageUrl or name is provided
  final IconData? icon;

  final AppAvatarSize size;
  final AppAvatarShape shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  /// Optional badge overlay (e.g., online dot, notification count)
  final Widget? badge;
  final List<BoxShadow>? boxShadow;

  double get _dimension {
    switch (size) {
      case AppAvatarSize.xs:
        return 28;
      case AppAvatarSize.sm:
        return 36;
      case AppAvatarSize.md:
        return 48;
      case AppAvatarSize.lg:
        return 64;
      case AppAvatarSize.xl:
        return 88;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 10;
      case AppAvatarSize.sm:
        return 13;
      case AppAvatarSize.md:
        return 18;
      case AppAvatarSize.lg:
        return 24;
      case AppAvatarSize.xl:
        return 32;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 14;
      case AppAvatarSize.sm:
        return 18;
      case AppAvatarSize.md:
        return 24;
      case AppAvatarSize.lg:
        return 32;
      case AppAvatarSize.xl:
        return 44;
    }
  }

  BorderRadius get _radius {
    if (shape == AppAvatarShape.circular) {
      return AppSpacing.borderRadiusFull;
    }
    switch (size) {
      case AppAvatarSize.xs:
      case AppAvatarSize.sm:
        return AppSpacing.borderRadiusSm;
      case AppAvatarSize.md:
        return AppSpacing.borderRadiusMd;
      case AppAvatarSize.lg:
        return AppSpacing.borderRadiusLg;
      case AppAvatarSize.xl:
        return AppSpacing.borderRadiusXl;
    }
  }

  String _initials() {
    if (name == null || name!.trim().isEmpty) return '?';
    final parts = name!.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  Color _resolveBackground() {
    if (backgroundColor != null) return backgroundColor!;
    if (name != null) return _colorFromName(name!);
    return AppColors.primaryContainer;
  }

  Color _colorFromName(String n) {
    final colors = [
      AppColors.primary,
      AppColors.success,
      AppColors.warning,
      AppColors.error,
      AppColors.info,
      AppColors.primaryDark,
      AppColors.accent,
    ];
    int code = n.codeUnits.fold(0, (a, b) => a + b);
    return colors[code % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final bg = _resolveBackground();
    final fg = foregroundColor ??
        (name != null ? AppColors.textOnPrimary : AppColors.primary);

    Widget content;
    if (imageUrl != null) {
      content = Image.network(
        imageUrl!,
        width: _dimension,
        height: _dimension,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _buildFallback(bg, fg),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return _buildFallback(bg, fg);
        },
      );
    } else {
      content = _buildFallback(bg, fg);
    }

    Widget avatar = Container(
      width: _dimension,
      height: _dimension,
      decoration: BoxDecoration(
        borderRadius: _radius,
        border: borderWidth > 0
            ? Border.all(
                color: borderColor ?? AppColors.surface,
                width: borderWidth,
              )
            : null,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: _radius,
        child: content,
      ),
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    if (badge != null) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: badge!,
          ),
        ],
      );
    }

    return avatar;
  }

  Widget _buildFallback(Color bg, Color fg) {
    return Container(
      color: bg,
      alignment: Alignment.center,
      child: name != null
          ? Text(
              _initials(),
              style: TextStyle(
                color: fg,
                fontSize: _fontSize,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            )
          : Icon(icon ?? Icons.person_rounded, color: fg, size: _iconSize),
    );
  }
}

// =============================================================================
// AppAvatarGroup — overlapping row of avatars
// =============================================================================

/// Shows a group of overlapping avatars with a +N overflow badge.
///
/// ```dart
/// AppAvatarGroup(
///   names: ['Alice', 'Bob', 'Charlie', 'David'],
///   maxVisible: 3,
///   size: AppAvatarSize.sm,
/// )
/// ```
class AppAvatarGroup extends StatelessWidget {
  const AppAvatarGroup({
    super.key,
    this.names = const [],
    this.imageUrls = const [],
    this.maxVisible = 4,
    this.size = AppAvatarSize.sm,
    this.overlap = 10,
  });

  final List<String> names;
  final List<String> imageUrls;
  final int maxVisible;
  final AppAvatarSize size;
  final double overlap;

  double get _dim {
    switch (size) {
      case AppAvatarSize.xs:
        return 28;
      case AppAvatarSize.sm:
        return 36;
      case AppAvatarSize.md:
        return 48;
      case AppAvatarSize.lg:
        return 64;
      case AppAvatarSize.xl:
        return 88;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = (names.isNotEmpty ? names.length : imageUrls.length);
    final visible = total.clamp(0, maxVisible);
    final overflow = total - visible;

    return SizedBox(
      height: _dim,
      width: visible * (_dim - overlap) + (overflow > 0 ? _dim - overlap : 0),
      child: Stack(
        children: [
          for (int i = 0; i < visible; i++)
            Positioned(
              left: i * (_dim - overlap),
              child: AppAvatar(
                name: names.isNotEmpty ? names[i] : null,
                imageUrl: imageUrls.isNotEmpty ? imageUrls[i] : null,
                size: size,
                borderColor: AppColors.surface,
                borderWidth: 2,
              ),
            ),
          if (overflow > 0)
            Positioned(
              left: visible * (_dim - overlap),
              child: Container(
                width: _dim,
                height: _dim,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+$overflow',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: _dim * 0.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// AppOnlineBadge — small green dot badge for avatar
// =============================================================================

/// Online/offline indicator dot for use as AppAvatar badge.
///
/// ```dart
/// AppAvatar(
///   name: 'John',
///   badge: AppOnlineBadge(isOnline: true),
/// )
/// ```
class AppOnlineBadge extends StatelessWidget {
  const AppOnlineBadge({
    super.key,
    this.isOnline = true,
    this.size = 12,
    this.borderWidth = 2,
  });

  final bool isOnline;
  final double size;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isOnline ? AppColors.success : AppColors.textTertiary,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.surface,
          width: borderWidth,
        ),
      ),
    );
  }
}
