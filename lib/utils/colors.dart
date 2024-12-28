import 'package:flutter/material.dart';

class ColorManager {
  static Color convertColor({required String hexString, double? opacity}) {
    StringBuffer buffer = StringBuffer();
    if (opacity != null) {
      final alpha =
          ((opacity / 100) * 255).round().toRadixString(16).padLeft(2, '0');
      buffer.write(alpha);
    } else {
      buffer.write('ff'); // Default to fully opaque
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static final COLOR_PRIMARY = ColorManager.convertColor(hexString: "FAD02C");
  static final COLOR_SECONDARY = ColorManager.convertColor(hexString: "4F1308");
  static final APPBAR_BG = ColorManager.convertColor(hexString: "FBDB5E");
  static final ICON_BG = ColorManager.convertColor(hexString: "FEF6D6");
  static final SCAFFOLD_BG = ColorManager.convertColor(hexString: "EEEEEE");
  static final CARD_BG = ColorManager.convertColor(hexString: "FFFFFF");
  static final SUBTITLE_COLOR = ColorManager.convertColor(hexString: "B3B3B3");
  static final INPUT_COLOR = ColorManager.convertColor(hexString: "494747");
  static final TEMP_COLOR = ColorManager.convertColor(hexString: "FF59AF");
  static final TEMP_BG = ColorManager.convertColor(hexString: "FFEDF6");
  static final HUMIDITY_COLOR = ColorManager.convertColor(hexString: "4CACEF");
  static final HUMIDITY_BG = ColorManager.convertColor(hexString: "E4F0F8");
  static final MASS_COLOR = ColorManager.convertColor(hexString: "55AE8F");
  static final MASS_BG = ColorManager.convertColor(hexString: "D7F4EB");
  static final WEATHER_COLOR = ColorManager.convertColor(hexString: "FFC901");
  static final WEATHER_BG = ColorManager.convertColor(hexString: "FFF6DB");
  static final HONEY_COLOR = ColorManager.convertColor(hexString: "EBA937");
  static final HONEY_BG = ColorManager.convertColor(hexString: "FFE6BA");
  static final FRAME_COLOR = ColorManager.convertColor(hexString: "B95745");
  static final FRAME_BG = ColorManager.convertColor(hexString: "EECCC4");
  static final DISEASES_COLOR = ColorManager.convertColor(hexString: "000000");
  static final DISEASES_BG = ColorManager.convertColor(hexString: "B3B3B3");
}
