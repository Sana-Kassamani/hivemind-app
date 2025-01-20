import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/themes/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData lightMode = ThemeManager.lightTheme;
  ThemeData darkMode = ThemeManager.darkTheme;
  ThemeData _themeData = ThemeManager.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void setDark() {
    themeData = darkMode;
    notifyListeners();
  }

  void setLight() {
    themeData = lightMode;
    notifyListeners();
  }
}
