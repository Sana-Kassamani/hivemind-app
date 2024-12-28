import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

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
      backgroundColor: ColorManager.CARD_BG,
      indicatorColor: ColorManager.ICON_BG,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.hive),
          label: "Apiary",
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart),
          label: "Dashboard",
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_active_outlined),
          label: "Alerts",
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
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
        backgroundColor: ColorManager.CARD_BG,
        indicatorColor: ColorManager.ICON_BG,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.hive),
            label: "Hives",
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            label: "Tasks",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_active_outlined),
            label: "Alerts",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: onItemSelected);
  }
}
