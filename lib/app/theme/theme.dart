import 'package:flutter/material.dart';
import 'package:care_connect_team3/app/theme/colors.dart';
import 'package:care_connect_team3/app/theme/radii.dart';
import 'package:care_connect_team3/app/theme/typography.dart';
import 'package:care_connect_team3/app/theme/shadows.dart';

class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.destructive,
      onError: AppColors.onDestructive,
      surface: AppColors.surface,
      onSurface: AppColors.foreground,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,

      //Typography base mapping (Material names)
      textTheme: const TextTheme(
        headlineSmall: AppTypography.h1, //page titles
        titleLarge: AppTypography.h2, //section headings
        titleMedium: AppTypography.h3,
        titleSmall: AppTypography.h4,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.bodysm,
        labelLarge: AppTypography.button,
        labelSmall: AppTypography.caption,
      ).apply(
        bodyColor: AppColors.foreground,
        displayColor: AppColors.foreground,
      ),

      //AppBar like sticky headers (white bg, gray border)
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.foreground,
        elevation: 0,
        centerTitle: false,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.gray200,
        thickness: 1,
      ),

      //Cards: rounded-xl/2xl depending on usage (default to 12)
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: const BorderSide(color: AppColors.gray200),
        ),
        margin: EdgeInsets.zero,
      ),
      //Inputs: 36px tall, filled, ring focus behavior
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintStyle: const TextStyle(color: AppColors.mutedForeground),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.ring),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.destructive),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.destructive, width: 2),
        ),
      ),
      
      //Buttons: default 36px height (h-9), rounded-md 6px
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size (0, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), //px-4 py-2
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      //Outlined buttons (your outline/secondary button)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.foreground,
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm)),
        textStyle: AppTypography.button,
      ),
    ),

    //Text buttons(ghost)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.foreground,
        minimumSize: const Size(0, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm)
        ),
        textStyle: AppTypography.button,
      ),
      ),
      );
  }

  static ThemeData dark() {
    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.onPrimaryDark,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.onSecondaryDark,
      error: AppColors.destructiveDark,
      onError: AppColors.onDestructiveDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.foregroundDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      //Typography base mapping (Material names)
      textTheme: const TextTheme(
        headlineSmall: AppTypography.h1, //page titles
        titleLarge: AppTypography.h2, //section headings
        titleMedium: AppTypography.h3,
        titleSmall: AppTypography.h4,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.bodysm,
        labelLarge: AppTypography.button,
        labelSmall: AppTypography.caption,
      ).apply(
        bodyColor: AppColors.foregroundDark,
        displayColor: AppColors.foregroundDark,
      ),

      //AppBar like sticky headers (white bg, gray border)
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.foregroundDark,
        elevation: 0,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.borderDark,
        thickness: 1,
      ),

      //Cards: rounded-xl/2xl depending on usage (default to 12)
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: const BorderSide(color: AppColors.borderDark),
        ),
        margin: EdgeInsets.zero,
      ),
      //Inputs: 36px tall, filled, ring focus behavior
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondaryDark,
        hintStyle: const TextStyle(color: AppColors.mutedForegroundDark),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.ringDark),
        ),
      ),
      
      //Buttons: default 36px height (h-9), rounded-md 6px
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.onPrimaryDark,
          minimumSize: const Size (0, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), //px-4 py-2
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      //Outlined buttons (your outline/secondary button)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.foreground,
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm)),
        textStyle: AppTypography.button,
      ),
    ),

    //Text buttons(ghost)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.foreground,
        minimumSize: const Size(0, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm)
        ),
        textStyle: AppTypography.button,
      ),
      ),
      );
  }
}

