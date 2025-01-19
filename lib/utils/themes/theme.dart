import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.SCAFFOLD_BG,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.amber,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 21,
        color: ColorManager.COLOR_SECONDARY,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: ColorManager.APPBAR_BG,
    ),
    iconTheme: IconThemeData(size: 24, color: ColorManager.COLOR_PRIMARY),
    sliderTheme: SliderThemeData(
        overlappingShapeStrokeColor: Colors.transparent,
        thumbShape: RoundSliderThumbShape(elevation: 0),
        overlayColor: Colors.transparent,
        overlayShape: SliderComponentShape.noOverlay),
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
      indicatorColor: ColorManager.ICON_BG,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: ColorManager.CARD_BG,
      collapsedBackgroundColor: ColorManager.CARD_BG,
      iconColor: ColorManager.COLOR_SECONDARY,
      collapsedIconColor: ColorManager.COLOR_SECONDARY,
      tilePadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      childrenPadding: EdgeInsets.all(20),
      expandedAlignment: Alignment.centerLeft,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ColorManager.INPUT_COLOR,
        fontSize: 16,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.COLOR_PRIMARY,
        primary: ColorManager.COLOR_PRIMARY,
        primaryFixed: ColorManager.ICON_BG,
        onPrimary: ColorManager.COLOR_SECONDARY,
        secondary: ColorManager.COLOR_SECONDARY,
        secondaryFixed: ColorManager.COLOR_SECONDARY,
        tertiary: Colors.black,
        tertiaryFixed: ColorManager.INPUT_COLOR),
    cardColor: ColorManager.CARD_BG,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        color: ColorManager.COLOR_SECONDARY,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: ColorManager.COLOR_SECONDARY,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w700,
      ),
      labelMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorManager.INPUT_COLOR,
        fontSize: 12,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: ColorManager.SUBTITLE_COLOR,
        fontSize: 12,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.Dark_Scaffold,
    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.Dark_MainText,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 21,
        color: ColorManager.Dark_AppBarText,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: ColorManager.Dark_Card,
    ),
    iconTheme: IconThemeData(size: 24, color: ColorManager.Dark_Icon),
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
      backgroundColor: ColorManager.Dark_Card,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: ColorManager.Dark_MainText,
          fontSize: 12,
          fontFamily: 'Comme',
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: WidgetStatePropertyAll(IconThemeData(
        size: 24.0,
        color: ColorManager.Dark_MainText,
      )),
      indicatorColor: ColorManager.Dark_ICONBG,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: ColorManager.Dark_Card,
      collapsedBackgroundColor: ColorManager.Dark_Card,
      iconColor: ColorManager.Dark_Icon,
      collapsedIconColor: ColorManager.Dark_Icon,
      tilePadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      childrenPadding: EdgeInsets.all(20),
      expandedAlignment: Alignment.centerLeft,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ColorManager.Dark_MainText,
        fontSize: 16,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w500,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.COLOR_PRIMARY,
        primary: ColorManager.COLOR_PRIMARY,
        primaryFixed: ColorManager.Dark_Scaffold,
        onPrimary: ColorManager.COLOR_SECONDARY,
        secondary: ColorManager.Dark_MainText,
        secondaryFixed: ColorManager.Dark_Card,
        tertiary: Colors.white,
        tertiaryFixed: ColorManager.Dark_SecText),
    cardColor: ColorManager.Dark_Card,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        color: ColorManager.Dark_MainText,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: ColorManager.Dark_MainText,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: ColorManager.Dark_MainText,
        fontSize: 16,
        fontFamily: 'Tomorrow',
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: ColorManager.Dark_MainText,
        fontSize: 14,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w700,
      ),
      labelMedium: TextStyle(
        color: ColorManager.Dark_MainText,
        fontSize: 14,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: ColorManager.Dark_MainText,
        fontSize: 14,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: ColorManager.Dark_MainText,
        fontSize: 16,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: ColorManager.Dark_SecText,
        fontSize: 12,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: ColorManager.Dark_SecText,
        fontSize: 12,
        fontFamily: 'Comme',
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
