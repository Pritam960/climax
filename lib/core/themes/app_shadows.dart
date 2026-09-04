import 'package:flutter/material.dart';

/// Climax App — Shadow & Elevation System
///
/// Shadows use the primary blue color for a cohesive, premium feel.
/// Each level corresponds to a visual elevation.
abstract final class AppShadows {
  // ---------------------------------------------------------------------------
  // None
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> none = [];

  // ---------------------------------------------------------------------------
  // Level 1 — Subtle (Cards, inputs at rest)
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D1565C0), // Blue 5%
      blurRadius: 4,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A000000), // Black 4%
      blurRadius: 2,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Level 2 — Default (Elevated cards, dropdowns)
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x141565C0), // Blue 8%
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x0A000000), // Black 4%
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Level 3 — Floating (FAB, modals, popovers)
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x1E1565C0), // Blue 12%
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color(0x14000000), // Black 8%
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: -1,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Level 4 — Prominent (Dialogs, bottom sheets)
  // ---------------------------------------------------------------------------
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x291565C0), // Blue 16%
      blurRadius: 32,
      offset: Offset(0, 16),
      spreadRadius: -8,
    ),
    BoxShadow(
      color: Color(0x1A000000), // Black 10%
      blurRadius: 16,
      offset: Offset(0, 8),
      spreadRadius: -2,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Special Shadows
  // ---------------------------------------------------------------------------

  /// CTA Button — Amber glow effect
  static const List<BoxShadow> accentButton = [
    BoxShadow(
      color: Color(0x33FF6F00), // Amber 20%
      blurRadius: 16,
      offset: Offset(0, 6),
      spreadRadius: -2,
    ),
  ];

  /// Primary Button — Blue glow
  static const List<BoxShadow> primaryButton = [
    BoxShadow(
      color: Color(0x331565C0), // Blue 20%
      blurRadius: 16,
      offset: Offset(0, 6),
      spreadRadius: -2,
    ),
  ];

  /// Bottom Navigation — top soft shadow
  static const List<BoxShadow> bottomNav = [
    BoxShadow(
      color: Color(0x141565C0),
      blurRadius: 16,
      offset: Offset(0, -4),
      spreadRadius: 0,
    ),
  ];

  /// Input focused state
  static const List<BoxShadow> inputFocus = [
    BoxShadow(
      color: Color(0x331565C0), // Blue 20%
      blurRadius: 0,
      offset: Offset(0, 0),
      spreadRadius: 2,
    ),
  ];
}
