import 'package:flutter/material.dart';
import 'package:hivemind_app/models/iotDetail.model.dart';
import 'package:hivemind_app/pages/AlertsPage.dart';
import 'package:hivemind_app/pages/LoginPage.dart';
import 'package:hivemind_app/pages/SettingsPage.dart';
import 'package:hivemind_app/pages/beekeeper/ApiaryPage.dart';
import 'package:hivemind_app/pages/beekeeper/HivePage.dart';
import 'package:hivemind_app/pages/beekeeper/TasksPage.dart';
import 'package:hivemind_app/pages/owner/ApiariesPage.dart';
import 'package:hivemind_app/pages/owner/ApiaryPage.dart';
import 'package:hivemind_app/pages/owner/HivePage.dart';
import 'package:hivemind_app/pages/placesPage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/themes/theme.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';
import 'package:provider/provider.dart';

bool ISOWNER = true;
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Apiaries()),
        ChangeNotifierProvider(create: (context) => Beekeepers()),
        ChangeNotifierProvider(create: (context) => Hives()),
        ChangeNotifierProvider(create: (context) => IotDetails()),
        ChangeNotifierProvider(create: (context) => Tasks()),
      ],
      child: MaterialApp(
        title: 'My app', // used by the OS task switcher
        // home: LoginPage(),
        theme: theme.lightTheme,
        routes: {
          "/": (context) => LoginPage(),
          "/home": (context) => MainScreenOwner(),
          "/apiary": (context) => ApiaryPageOwner(),
          "/hiveOwner": (context) => HivePageOwner(),
          "/hiveBeekeeper": (context) => HivePageBeekeeper(),
        },
      ),
    );
  }
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
