import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/AlertsPage.dart';
import 'package:hivemind_app/pages/LoginPage.dart';
import 'package:hivemind_app/pages/SettingsPage.dart';
import 'package:hivemind_app/pages/beekeeper/ApiaryPage.dart';
import 'package:hivemind_app/pages/beekeeper/TasksPage.dart';
import 'package:hivemind_app/pages/owner/ApiariesPage.dart';
import 'package:hivemind_app/pages/placesPage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/utils/themes/theme.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';
import 'package:provider/provider.dart';

bool ISOWNER = true;
void main() {
  final theme = ThemeManager();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Apiaries()),
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Beekeepers())
      ],
      child: MaterialApp(
        title: 'My app', // used by the OS task switcher
        // home: LoginPage(),
        theme: theme.lightTheme,
        routes: {
          '/': (context) => LoginPage(),
          // '/': (context) => GoogleMapSearchPlacesApi(),
          '/home': (context) => MainScreenOwner(),
        },
      ),
    ),
  );
}

class MainScreenOwner extends StatefulWidget {
  const MainScreenOwner({super.key});

  @override
  State<MainScreenOwner> createState() => _MainScreenOwnerState();
}

class _MainScreenOwnerState extends State<MainScreenOwner> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ApiariesPage(),
    Center(
      child: Text("DashBoard"),
    ),
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
        bottomNavigationBar: NavbarOwner(
          selectedIndex: _selectedIndex,
          onItemSelected: _onItemSelected,
        ));
  }
}

class MainScreenBeekeeper extends StatefulWidget {
  const MainScreenBeekeeper({super.key});

  @override
  State<MainScreenBeekeeper> createState() => _MainScreenBeekeeperState();
}

class _MainScreenBeekeeperState extends State<MainScreenBeekeeper> {
  int _selectedIndex = 0;

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
