import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/AlertsPage.dart';
import 'package:hivemind_app/pages/LoginPage.dart';
import 'package:hivemind_app/pages/SettingsPage.dart';
import 'package:hivemind_app/pages/beekeeper/ApiaryPage.dart';
import 'package:hivemind_app/pages/beekeeper/TasksPage.dart';
import 'package:hivemind_app/pages/owner/ApiariesPage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/utils/themes/theme.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';
import 'package:provider/provider.dart';

const ISOWNER = true;
void main() {
  final theme = ThemeManager();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Apiaries()),
        ChangeNotifierProvider(create: (context) => Auth())
      ],
      child: MaterialApp(
        title: 'My app', // used by the OS task switcher
        home: LoginPage(),
        theme: theme.lightTheme,
      ),
    ),
  );
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = ISOWNER
      ? [
          ApiariesPage(),
          Center(
            child: Text("DashBoard"),
          ),
          AlertsPage(),
          SettingsPage(),
        ]
      : [
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
      bottomNavigationBar: ISOWNER
          ? NavbarOwner(
              selectedIndex: _selectedIndex,
              onItemSelected: _onItemSelected,
            )
          : NavbarBeekeeper(
              selectedIndex: _selectedIndex,
              onItemSelected: _onItemSelected,
            ),
    );
  }
}
