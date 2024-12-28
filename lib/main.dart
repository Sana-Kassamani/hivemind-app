import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/AlertsPage.dart';
import 'package:hivemind_app/pages/SettingsPage.dart';
import 'package:hivemind_app/pages/beekeeper/ApiaryPage.dart';
import 'package:hivemind_app/pages/beekeeper/HivePage.dart';
import 'package:hivemind_app/pages/beekeeper/TasksPage.dart';
import 'package:hivemind_app/pages/owner/ApiariesPage.dart';
import 'package:hivemind_app/pages/owner/ApiaryPage.dart';
import 'package:hivemind_app/pages/owner/HivePage.dart';
import 'package:hivemind_app/utils/themes/theme.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';

const ISOWNER = false;
void main() {
  final theme = ThemeManager();
  runApp(
    MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: MainScreen(),
      theme: theme.lightTheme,
    ),
  );
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // final List<Widget> _screens = [
  //   ApiariesPage(),
  //   Center(
  //     child: Text("DashBoard"),
  //   ),
  //   AlertsPage(),
  //   SettingsPage(),
  // ];
  final List<Widget> _screens = [
    ApiaryPageBeekeeper(),
    TasksPage(),
    AlertsPage(),
    SettingsPage(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen.
      bottomNavigationBar: NavbarBeekeeper(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}
