/// Climax App — Shared Widgets Barrel Export
///
/// Import this single file to access ALL shared widgets:
/// ```dart
/// import 'package:climax_app/shared/widgets/widgets.dart';
/// ```
///
/// ## Available Widgets
///
/// ### Buttons
/// - [AppButton]        → Primary, Secondary, Outlined, Text, Danger, Success, Warning
/// - [AppIconButton]    → Icon-only button with 4 variants
///
/// ### Text Fields
/// - [AppTextField]     → All input types (password, phone, number, email, search, OTP...)
/// - [AppOtpField]      → Row of styled OTP digit boxes
///
/// ### Cards
/// - [AppCard]          → 5 variants: flat, elevated, outlined, gradient, tinted
/// - [AppInfoCard]      → Pre-built info/stat card with icon + title + subtitle
///
/// ### Avatars
/// - [AppAvatar]        → Image, initials, or icon; 5 sizes, 2 shapes
/// - [AppAvatarGroup]   → Overlapping avatar row with +N overflow
/// - [AppOnlineBadge]   → Online/offline indicator dot
///
/// ### Badges & Chips
/// - [AppBadge]         → Count, label, or dot badge; optional pulsing animation
/// - [AppChip]          → Filled, outlined, soft chip with delete/selection
/// - [AppStatusBadge]   → Auto-colored semantic status (Active, Pending, Error...)
///
/// ### Loaders
/// - [AppLoader]        → Circular progress indicator (sm/md/lg)
/// - [AppLinearLoader]  → Linear progress bar with label and percentage
/// - [AppLoadingOverlay]→ Transparent overlay with centered spinner
/// - [AppSkeletonLoader]→ Shimmer skeleton placeholder
/// - [AppSkeletonListItem] → Pre-built skeleton list item
///
/// ### Dividers & Layout
/// - [AppDivider]       → Horizontal divider with optional center label
/// - [AppVerticalDivider] → Vertical divider for rows
/// - [AppSectionHeader] → Section title + optional "View All" action
/// - [AppSpacer]        → Semantic spacing widgets (xs/sm/md/base/lg/xl/xxl/h/w)
///
/// ### States
/// - [AppEmptyState]    → Empty, error, no-internet, no-results, unauthorized
///
/// ### Overlays
/// - [AppSnackbar]      → Static: success/error/warning/info/custom snackbars
/// - [AppDialog]        → Static: alert/confirm/loading/custom dialogs
/// - [AppBottomSheet]   → Static: styled modal bottom sheets
library;

export 'app_button.dart';
export 'app_text_field.dart';
export 'app_card.dart';
export 'app_avatar.dart';
export 'app_badge.dart';
export 'app_loader.dart' hide AppCard, AppCardVariant;
export 'app_divider.dart';
export 'app_empty_state.dart';
export 'app_snackbar.dart';
export 'app_dialog.dart';

export 'app_shimmer.dart';
export 'app_text.dart';
export 'app_tooltip.dart';
