import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// Climax App — Main Light ThemeData
///
/// Based on Material 3 with custom psychology-driven tokens.
/// Primary: Blue (Trust & Confidence)
/// Accent: Amber (Action & Energy)
/// Background: Cool Off-White (Calm & Spacious)
abstract final class AppTheme {
  // ---------------------------------------------------------------------------
  // ColorScheme — Material 3
  // ---------------------------------------------------------------------------
  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.light,
    // Primary
    primary: AppColors.primary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.primaryDark,
    // Secondary (Teal info tones)
    secondary: AppColors.info,
    onSecondary: AppColors.textOnPrimary,
    secondaryContainer: AppColors.infoContainer,
    onSecondaryContainer: AppColors.info,
    // Tertiary (Amber accent)
    tertiary: AppColors.accent,
    onTertiary: AppColors.textOnPrimary,
    tertiaryContainer: AppColors.accentContainer,
    onTertiaryContainer: AppColors.accent,
    // Error
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.error,
    // Surface
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.backgroundAlt,
    onSurfaceVariant: AppColors.textSecondary,
    // Outline
    outline: AppColors.border,
    outlineVariant: AppColors.divider,
    // Shadow & scrim
    shadow: AppColors.textPrimary,
    scrim: AppColors.scrim,
    // Inverse
    inverseSurface: AppColors.textPrimary,
    onInverseSurface: AppColors.surface,
    inversePrimary: AppColors.primaryLight,
  );

  // ---------------------------------------------------------------------------
  // Light Theme
  // ---------------------------------------------------------------------------
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme,
        scaffoldBackgroundColor: AppColors.background,
        splashColor: AppColors.ripple,
        highlightColor: AppColors.overlay,
        dividerColor: AppColors.divider,

        // ---- AppBar ----
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 1,
          shadowColor: AppColors.border,
          centerTitle: false,
          titleTextStyle: AppTextStyles.appBarTitle,
          iconTheme: IconThemeData(
            color: AppColors.textPrimary,
            size: AppSpacing.iconLg,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.textSecondary,
            size: AppSpacing.iconLg,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.surface,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          toolbarHeight: AppSpacing.appBarHeight,
          surfaceTintColor: AppColors.transparent,
        ),

        // ---- Elevated Button ----
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            disabledBackgroundColor: AppColors.border,
            disabledForegroundColor: AppColors.textDisabled,
            elevation: 0,
            shadowColor: AppColors.transparent,
            minimumSize: const Size(AppSpacing.buttonMinWidth, AppSpacing.buttonHeight),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusLg,
            ),
            textStyle: AppTextStyles.button,
          ),
        ),

        // ---- Filled Button ----
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size(AppSpacing.buttonMinWidth, AppSpacing.buttonHeight),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusLg,
            ),
            textStyle: AppTextStyles.button,
          ),
        ),

        // ---- Outlined Button ----
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            disabledForegroundColor: AppColors.textDisabled,
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            minimumSize: const Size(AppSpacing.buttonMinWidth, AppSpacing.buttonHeight),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusLg,
            ),
            textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
          ),
        ),

        // ---- Text Button ----
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.sm,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            textStyle: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
          ),
        ),

        // ---- Input Decoration ----
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.md,
          ),
          hintStyle: AppTextStyles.inputHint,
          labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          floatingLabelStyle: AppTextStyles.labelMedium.copyWith(
            color: AppColors.primary,
          ),
          errorStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          prefixIconColor: AppColors.textSecondary,
          suffixIconColor: AppColors.textSecondary,
          // Border — rest
          border: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.borderFocus, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            borderSide: const BorderSide(color: AppColors.divider, width: 1),
          ),
        ),

        // ---- Card ----
        cardTheme: const CardThemeData(
          color: AppColors.surface,
          surfaceTintColor: AppColors.transparent,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusLg,
            side: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),

        // ---- Chip ----
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.primaryContainer,
          selectedColor: AppColors.primary,
          disabledColor: AppColors.divider,
          labelStyle: AppTextStyles.labelMedium,
          selectedShadowColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          elevation: 0,
          pressElevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          shape: const StadiumBorder(
            side: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),

        // ---- Bottom Navigation Bar ----
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textTertiary,
          selectedLabelStyle: AppTextStyles.labelSmall,
          unselectedLabelStyle: AppTextStyles.labelSmall,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),

        // ---- Navigation Bar (Material 3) ----
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primaryContainer,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: AppColors.primary,
                size: AppSpacing.iconLg,
              );
            }
            return const IconThemeData(
              color: AppColors.textTertiary,
              size: AppSpacing.iconLg,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppTextStyles.labelSmall.copyWith(color: AppColors.primary);
            }
            return AppTextStyles.labelSmall;
          }),
          elevation: 0,
          height: 72,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),

        // ---- Navigation Rail ----
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: AppColors.surface,
          selectedIconTheme: const IconThemeData(
            color: AppColors.primary,
            size: AppSpacing.iconLg,
          ),
          unselectedIconTheme: const IconThemeData(
            color: AppColors.textTertiary,
            size: AppSpacing.iconLg,
          ),
          selectedLabelTextStyle:
              AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
          unselectedLabelTextStyle: AppTextStyles.labelSmall,
          indicatorColor: AppColors.primaryContainer,
          elevation: 0,
          groupAlignment: -1,
        ),

        // ---- Floating Action Button ----
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 4,
          focusElevation: 6,
          hoverElevation: 6,
          highlightElevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusXl,
          ),
        ),

        // ---- Dialog ----
        dialogTheme: const DialogThemeData(
          backgroundColor: AppColors.surface,
          surfaceTintColor: AppColors.transparent,
          elevation: 8,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusXxl,
          ),
          titleTextStyle: AppTextStyles.titleLarge,
          contentTextStyle: AppTextStyles.bodyMedium,
        ),

        // ---- Bottom Sheet ----
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surface,
          surfaceTintColor: AppColors.transparent,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusXxl),
            ),
          ),
          showDragHandle: true,
          dragHandleColor: AppColors.border,
          dragHandleSize: Size(48, 4),
          modalElevation: 16,
          clipBehavior: Clip.antiAlias,
        ),

        // ---- Snackbar ----
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimary,
          contentTextStyle:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.surface),
          actionTextColor: AppColors.primaryLight,
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 4,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.sm,
          ),
        ),

        // ---- Switch ----
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textOnPrimary;
            }
            return AppColors.textTertiary;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.border;
          }),
          trackOutlineColor: WidgetStateProperty.all(AppColors.transparent),
        ),

        // ---- Checkbox ----
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.transparent;
          }),
          checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
          side: const BorderSide(color: AppColors.border, width: 1.5),
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusXs,
          ),
        ),

        // ---- Radio ----
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.textTertiary;
          }),
        ),

        // ---- Slider ----
        sliderTheme: const SliderThemeData(
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: AppColors.primaryLighter,
          thumbColor: AppColors.primary,
          overlayColor: AppColors.overlay,
          valueIndicatorColor: AppColors.primary,
          valueIndicatorTextStyle:
              TextStyle(color: AppColors.textOnPrimary, fontSize: 12),
        ),

        // ---- Progress Indicator ----
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.primaryLighter,
          circularTrackColor: AppColors.primaryLighter,
          refreshBackgroundColor: AppColors.surface,
        ),

        // ---- Tab Bar ----
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTextStyles.labelLarge,
          unselectedLabelStyle: AppTextStyles.labelLarge,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: AppColors.divider,
        ),

        // ---- Tooltip ----
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.textPrimary.withValues(alpha: 0.92),
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          textStyle:
              AppTextStyles.caption.copyWith(color: AppColors.surface),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          waitDuration: const Duration(milliseconds: 500),
        ),

        // ---- Popup Menu ----
        popupMenuTheme: const PopupMenuThemeData(
          color: AppColors.surface,
          surfaceTintColor: AppColors.transparent,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            side: BorderSide(color: AppColors.border, width: 0.5),
          ),
          textStyle: AppTextStyles.bodyMedium,
          labelTextStyle: WidgetStatePropertyAll(AppTextStyles.bodyMedium),
        ),

        // ---- Drawer ----
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.surface,
          surfaceTintColor: AppColors.transparent,
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(AppSpacing.radiusXxl),
            ),
          ),
          width: 300,
        ),

        // ---- List Tile ----
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.base,
            vertical: AppSpacing.xs,
          ),
          titleTextStyle: AppTextStyles.bodyLarge,
          subtitleTextStyle: AppTextStyles.bodySmall,
          leadingAndTrailingTextStyle: AppTextStyles.labelMedium,
          iconColor: AppColors.textSecondary,
          selectedColor: AppColors.primary,
          selectedTileColor: AppColors.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          minLeadingWidth: AppSpacing.iconLg,
          horizontalTitleGap: AppSpacing.md,
        ),

        // ---- Text Theme ----
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.displayLarge,
          displayMedium: AppTextStyles.displayMedium,
          displaySmall: AppTextStyles.displaySmall,
          headlineLarge: AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          headlineSmall: AppTextStyles.headlineSmall,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
          titleSmall: AppTextStyles.titleSmall,
          labelLarge: AppTextStyles.labelLarge,
          labelMedium: AppTextStyles.labelMedium,
          labelSmall: AppTextStyles.labelSmall,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
        ),

        // ---- Icon Theme ----
        iconTheme: const IconThemeData(
          color: AppColors.textSecondary,
          size: AppSpacing.iconLg,
        ),

        // ---- Divider ----
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 0,
        ),
      );
}
