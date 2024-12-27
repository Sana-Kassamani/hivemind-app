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
}
