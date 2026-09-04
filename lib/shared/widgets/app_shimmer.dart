import 'package:flutter/material.dart';

import 'app_loader.dart';

/// AppShimmer is an alias for AppSkeletonLoader or a wrapper for shimmer effects.
///
/// Usage:
/// ```dart
/// AppShimmer(width: 100, height: 20);
/// ```
class AppShimmer extends StatelessWidget {
  final double? width;

  final double height;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final EdgeInsetsGeometry? margin;
  const AppShimmer({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.isCircle = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return AppSkeletonLoader(
      width: width,
      height: height,
      borderRadius: borderRadius,
      isCircle: isCircle,
      margin: margin,
    );
  }
}
