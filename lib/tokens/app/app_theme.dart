import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.3.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  static var textTheme = GoogleFonts.mPlus1TextTheme().copyWith(
    headlineLarge: GoogleFonts.mavenProTextTheme().headlineLarge,
    headlineMedium: GoogleFonts.mavenProTextTheme().bodyLarge,
    headlineSmall: GoogleFonts.mavenProTextTheme().headlineSmall,
  );

  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    textTheme: textTheme,
    // Using FlexColorScheme built-in FlexScheme enum based colors
    scheme: FlexScheme.green,
    // Input color modifiers.
    useMaterial3ErrorColors: true,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      scaffoldBackgroundBaseColor:
          FlexScaffoldBaseColor.surfaceContainerLow,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      appBarBackgroundSchemeColor:
          SchemeColor.surfaceContainerLow,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      applyThemeToAll: true,
    ),
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = FlexThemeData.dark(
    textTheme: textTheme,
    // Using FlexColorScheme built-in FlexScheme enum based colors.
    scheme: FlexScheme.green,
    // Input color modifiers.
    useMaterial3ErrorColors: true,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      scaffoldBackgroundBaseColor:
          FlexScaffoldBaseColor.surfaceContainerLow,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      appBarBackgroundSchemeColor:
          SchemeColor.surfaceContainerLow,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(
      applyThemeToAll: true,
    ),
  );
}
