import 'package:flutter/material.dart';

class NavbarOwner extends StatelessWidget {
  const NavbarOwner({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });
  final selectedIndex;
  final onItemSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Theme.of(context).cardColor,
      indicatorColor: Theme.of(context).colorScheme.primaryFixed,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.hive_outlined),
          selectedIcon: Icon(Icons.hive),
          label: "Apiary",
        ),
        NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map),
          label: "Map",
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_active_outlined),
          selectedIcon: Icon(Icons.notifications_active),
          label: "Alerts",
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemSelected,
    );
  }
}

class NavbarBeekeeper extends StatelessWidget {
  const NavbarBeekeeper({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });
  final selectedIndex;
  final onItemSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.hive_outlined),
            selectedIcon: Icon(Icons.hive),
            label: "Hives",
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: "Tasks",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_active_outlined),
            selectedIcon: Icon(Icons.notifications_active),
            label: "Alerts",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemSelected);
  }
}
