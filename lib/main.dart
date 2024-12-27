import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/owner/ApiariesPage.dart';
import 'package:hivemind_app/pages/owner/ApiaryPage.dart';
import 'package:hivemind_app/utils/themes/theme.dart';

void main() {
  final theme = ThemeManager();
  runApp(
    MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: ApiaryPage(),
      theme: theme.lightTheme,
    ),
  );
}
