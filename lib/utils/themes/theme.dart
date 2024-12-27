import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class ThemeManager {
  ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorManager.COLOR_PRIMARY,
      primary: ColorManager.COLOR_PRIMARY,
      onPrimary: ColorManager.COLOR_SECONDARY,
      secondary: ColorManager.COLOR_SECONDARY,
    ),
    scaffoldBackgroundColor: ColorManager.SCAFFOLD_BG,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 24,
        color: ColorManager.COLOR_SECONDARY,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: ColorManager.APPBAR_BG,
    ),
    iconTheme: IconThemeData(size: 24, color: ColorManager.COLOR_SECONDARY),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          color: ColorManager.COLOR_SECONDARY,
          fontFamily: 'Tomorrow',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: ColorManager.COLOR_SECONDARY,
        ),
        labelLarge: TextStyle(
          color: ColorManager.COLOR_SECONDARY,
          fontSize: 16,
          fontFamily: 'Comme',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: ColorManager.COLOR_SECONDARY,
          fontSize: 16,
          fontFamily: 'Comme',
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: ColorManager.COLOR_SECONDARY,
          fontSize: 11,
          fontFamily: 'Comme',
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: ColorManager.SUBTITLE_COLOR,
          fontSize: 12,
          fontFamily: 'Comme',
          fontWeight: FontWeight.w500,
        )),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(ColorManager.COLOR_PRIMARY),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Set border radius here
          ),
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ColorManager.CARD_BG,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: ColorManager.COLOR_SECONDARY,
          fontSize: 12,
          fontFamily: 'Comme',
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: WidgetStatePropertyAll(IconThemeData(
        size: 24.0,
        color: ColorManager.COLOR_SECONDARY,
      )),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
