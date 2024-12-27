import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
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
