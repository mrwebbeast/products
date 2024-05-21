import "package:flutter/material.dart";
import "package:mrwebbeast/core/config/app_fonts.dart";
import "package:mrwebbeast/utils/theme/colors.dart";

class AppThemes {
  ///1) Light Theme...

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryColor,
      canvasColor: Colors.white,
      brightness: Brightness.light,
      dividerTheme: DividerThemeData(color: Colors.grey.shade200),
      useMaterial3: false,
      fontFamily: AppFonts.defaultFontFamily,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: createMaterialColor(primaryColor),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.grey.shade700),
    );
  }

  ///2) Dark Theme...
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      useMaterial3: false,
      fontFamily: AppFonts.defaultFontFamily,
      canvasColor: Colors.white,
      dividerTheme: DividerThemeData(color: Colors.grey.shade800, thickness: 1),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: createMaterialColor(primaryColor),
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey.shade900,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  ///3) Text Theme...
  static TextTheme textTheme(BuildContext context) {
    TextTheme defaultTheme = Theme.of(context).textTheme; // Get the default theme

    return TextTheme(
      displayLarge: defaultTheme.displayLarge?.copyWith(fontSize: 32),
      displayMedium: defaultTheme.displayMedium?.copyWith(fontSize: 24),
      displaySmall: defaultTheme.displaySmall?.copyWith(fontSize: 20),
      headlineLarge: defaultTheme.headlineLarge?.copyWith(fontSize: 28),
      headlineMedium: defaultTheme.headlineMedium?.copyWith(fontSize: 24),
      headlineSmall: defaultTheme.headlineSmall?.copyWith(fontSize: 20),
      titleLarge: defaultTheme.titleLarge?.copyWith(fontSize: 24),
      titleMedium: defaultTheme.titleMedium?.copyWith(fontSize: 20),
      titleSmall: defaultTheme.titleSmall?.copyWith(fontSize: 18),
      bodyLarge: defaultTheme.bodyLarge?.copyWith(fontSize: 18),
      bodyMedium: defaultTheme.bodyMedium?.copyWith(fontSize: 16),
      bodySmall: defaultTheme.bodySmall?.copyWith(fontSize: 14),
      labelLarge: defaultTheme.labelLarge?.copyWith(fontSize: 16),
      labelMedium: defaultTheme.labelMedium?.copyWith(fontSize: 14),
      labelSmall: defaultTheme.labelSmall?.copyWith(fontSize: 12),
    );
  }
}
