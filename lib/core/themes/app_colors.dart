import 'package:flutter/material.dart';

/// Climax App — Psychology-Based Color System
///
/// Blue  → Trust, Reliability, Confidence
/// Amber → Energy, Action, Urgency (CTA)
/// Green → Growth, Positivity, Safety
/// Red   → Alert, Stop, Danger
/// Grey  → Neutral, Balance, Support
abstract final class AppColors {
  // ---------------------------------------------------------------------------
  // Primary — Blue Family (Trust & Professionalism)
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF1565C0);       // Deep Blue
  static const Color primaryLight = Color(0xFF42A5F5);  // Sky Blue
  static const Color primaryLighter = Color(0xFFBBDEFB); // Pale Blue
  static const Color primaryDark = Color(0xFF0D47A1);   // Navy Blue
  static const Color primaryContainer = Color(0xFFE3F2FD); // Soft Blue BG

  // ---------------------------------------------------------------------------
  // Accent / CTA — Amber (Energy & Action)
  // ---------------------------------------------------------------------------
  static const Color accent = Color(0xFFFF6F00);        // Deep Amber
  static const Color accentLight = Color(0xFFFFCA28);   // Warm Yellow
  static const Color accentContainer = Color(0xFFFFF8E1); // Cream

  // ---------------------------------------------------------------------------
  // Semantic Colors
  // ---------------------------------------------------------------------------
  // Success — Green (Growth, Safety)
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF66BB6A);
  static const Color successContainer = Color(0xFFE8F5E9);

  // Warning — Deep Amber (Caution)
  static const Color warning = Color(0xFFF57F17);
  static const Color warningLight = Color(0xFFFFCC02);
  static const Color warningContainer = Color(0xFFFFF9C4);

  // Error — Deep Red (Danger, Alert)
  static const Color error = Color(0xFFC62828);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorContainer = Color(0xFFFFEBEE);

  // Info — Teal (Knowledge, Clarity)
  static const Color info = Color(0xFF00838F);
  static const Color infoLight = Color(0xFF4DD0E1);
  static const Color infoContainer = Color(0xFFE0F7FA);

  // ---------------------------------------------------------------------------
  // Background & Surface (Clean, Spacious, Calm)
  // ---------------------------------------------------------------------------
  static const Color background = Color(0xFFF5F7FA);    // Cool Off-White
  static const Color backgroundAlt = Color(0xFFEEF2F7); // Slightly deeper
  static const Color surface = Color(0xFFFFFFFF);        // Pure White
  static const Color surfaceVariant = Color(0xFFF8FAFC); // Near-white card
  static const Color surfaceTint = Color(0xFFE8F1FD);   // Light blue tint

  // ---------------------------------------------------------------------------
  // Text Colors (Readability optimized)
  // ---------------------------------------------------------------------------
  static const Color textPrimary = Color(0xFF1A1A2E);   // Dark Navy (Authority)
  static const Color textSecondary = Color(0xFF546E7A); // Blue Grey (Support)
  static const Color textTertiary = Color(0xFF90A4AE);  // Light Grey (Hint)
  static const Color textDisabled = Color(0xFFB0BEC5);  // Muted
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White on blue
  static const Color textOnAccent = Color(0xFFFFFFFF);  // White on amber

  // ---------------------------------------------------------------------------
  // Border & Divider
  // ---------------------------------------------------------------------------
  static const Color border = Color(0xFFDDE3EA);        // Soft border
  static const Color borderFocus = Color(0xFF1565C0);   // Blue focus ring
  static const Color divider = Color(0xFFECF0F4);       // Light divider

  // ---------------------------------------------------------------------------
  // Overlay & Scrim
  // ---------------------------------------------------------------------------
  static const Color overlay = Color(0x1A1565C0);       // Blue overlay 10%
  static const Color scrim = Color(0x801A1A2E);         // Dark scrim 50%

  // ---------------------------------------------------------------------------
  // Gradient Presets
  // ---------------------------------------------------------------------------
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6F00), Color(0xFFFFCA28)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFE3F2FD), Color(0xFFF5F7FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F7FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ---------------------------------------------------------------------------
  // Misc / Utility
  // ---------------------------------------------------------------------------
  static const Color transparent = Colors.transparent;
  static const Color shimmerBase = Color(0xFFE8EDF2);
  static const Color shimmerHighlight = Color(0xFFF5F7FA);
  static const Color ripple = Color(0x1A1565C0); // Blue ripple
}
