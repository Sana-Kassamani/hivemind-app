import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class NavbarOwner extends StatefulWidget {
  const NavbarOwner({super.key});

  @override
  State<NavbarOwner> createState() => _NavbarOwnerState();
}

class _NavbarOwnerState extends State<NavbarOwner> {
  var currentPageIndex = 0;
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
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
    );
  }
}

class NavbarBeekeeper extends StatefulWidget {
  const NavbarBeekeeper({super.key});

  @override
  State<NavbarBeekeeper> createState() => _NavbarBeekeeperState();
}

class _NavbarBeekeeperState extends State<NavbarBeekeeper> {
  var currentPageIndex = 0;
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
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
    );
  }
}
