import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_config.dart';

abstract class FluffyThemes {
  static const double columnWidth = 380.0;

  static const double maxTimelineWidth = columnWidth * 2;

  static const double navRailWidth = 80.0;

  static bool isColumnModeByWidth(double width) =>
      width > columnWidth * 2 + navRailWidth;

  static bool isColumnMode(BuildContext context) =>
      isColumnModeByWidth(MediaQuery.sizeOf(context).width);

  static bool isThreeColumnMode(BuildContext context) =>
      MediaQuery.sizeOf(context).width > FluffyThemes.columnWidth * 3.5;

  static LinearGradient backgroundGradient(
    BuildContext context,
    int alpha,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return LinearGradient(
      begin: Alignment.topCenter,
      colors: [
        colorScheme.primaryContainer.withAlpha(alpha),
        colorScheme.secondaryContainer.withAlpha(alpha),
        colorScheme.tertiaryContainer.withAlpha(alpha),
        colorScheme.primaryContainer.withAlpha(alpha),
      ],
    );
  }

  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Curve animationCurve = Curves.easeInOut;

  // Redoubt branding colors
  static const Color _bgDark = Color(0xFF0B0F14);
  static const Color _panelDark = Color(0xFF121923);
  static const Color _accentRed = Color(0xFF8B1E1E);
  static const Color _textMain = Color(0xFFE6E8EB);
  static const Color _textMuted = Color(0xFF9AA3AD);
  static const Color _linkBlue = Color(0xFF60A5FA);
  static const Color _border = Color(0xFF1F2937);
  static const Color _buttonBg = Color(0xFF374151);

  static ColorScheme _buildRedoubtDarkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: _accentRed,
      onPrimary: _textMain,
      primaryContainer: Color(0xFF3D1111),
      onPrimaryContainer: Color(0xFFFFDAD6),
      secondary: _linkBlue,
      onSecondary: Color(0xFF003258),
      secondaryContainer: Color(0xFF1A3A5C),
      onSecondaryContainer: Color(0xFFD1E4FF),
      tertiary: _buttonBg,
      onTertiary: _textMain,
      tertiaryContainer: Color(0xFF2A3441),
      onTertiaryContainer: _textMain,
      error: Color(0xFFF87171),
      onError: Color(0xFF601410),
      errorContainer: Color(0xFF8C1D18),
      onErrorContainer: Color(0xFFF9DEDC),
      surface: _bgDark,
      onSurface: _textMain,
      onSurfaceVariant: _textMuted,
      surfaceContainerLowest: Color(0xFF080C10),
      surfaceContainerLow: Color(0xFF0E1319),
      surfaceContainer: _panelDark,
      surfaceContainerHigh: Color(0xFF1A2332),
      surfaceContainerHighest: _border,
      outline: _border,
      outlineVariant: Color(0xFF16202C),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: _textMain,
      onInverseSurface: _bgDark,
      inversePrimary: Color(0xFFB34040),
    );
  }

  static ThemeData buildTheme(
    BuildContext context,
    Brightness brightness, [
    Color? seed,
  ]) {
    final colorScheme = brightness == Brightness.dark
        ? _buildRedoubtDarkScheme()
        : ColorScheme.fromSeed(
            brightness: brightness,
            seedColor:
                seed ?? AppConfig.colorSchemeSeed ?? AppConfig.primaryColor,
          );
    final isColumnMode = FluffyThemes.isColumnMode(context);
    return ThemeData(
      visualDensity: VisualDensity.standard,
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      dividerColor: brightness == Brightness.dark
          ? _border
          : colorScheme.surfaceContainer,
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainerLow,
        iconColor: colorScheme.onSurface,
        textStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          iconColor: colorScheme.onSurface,
          disabledIconColor: colorScheme.onSurface,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: colorScheme.onSurface.withAlpha(128),
        selectionHandleColor: colorScheme.secondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
      chipTheme: ChipThemeData(
        showCheckmark: false,
        backgroundColor: colorScheme.surfaceContainer,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius),
        ),
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: isColumnMode ? 72 : 56,
        shadowColor:
            isColumnMode ? colorScheme.surfaceContainer.withAlpha(128) : null,
        surfaceTintColor: isColumnMode ? colorScheme.surface : null,
        backgroundColor: isColumnMode ? colorScheme.surface : null,
        actionsPadding:
            isColumnMode ? const EdgeInsets.symmetric(horizontal: 16.0) : null,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness.reversed,
          statusBarBrightness: brightness,
          systemNavigationBarIconBrightness: brightness.reversed,
          systemNavigationBarColor: colorScheme.surface,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 1,
            color: colorScheme.primary,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: colorScheme.primary),
            borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        strokeCap: StrokeCap.round,
        color: colorScheme.primary,
        refreshBackgroundColor: colorScheme.primaryContainer,
      ),
      snackBarTheme: isColumnMode
          ? const SnackBarThemeData(
              showCloseIcon: true,
              behavior: SnackBarBehavior.floating,
              width: FluffyThemes.columnWidth * 1.5,
            )
          : const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer,
          elevation: 0,
          padding: const EdgeInsets.all(16),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

extension on Brightness {
  Brightness get reversed =>
      this == Brightness.dark ? Brightness.light : Brightness.dark;
}

extension BubbleColorTheme on ThemeData {
  Color get bubbleColor => brightness == Brightness.light
      ? colorScheme.primary
      : colorScheme.primaryContainer;

  Color get onBubbleColor => brightness == Brightness.light
      ? colorScheme.onPrimary
      : colorScheme.onPrimaryContainer;

  Color get secondaryBubbleColor => HSLColor.fromColor(
        brightness == Brightness.light
            ? colorScheme.tertiary
            : colorScheme.tertiaryContainer,
      ).withSaturation(0.5).toColor();
}
