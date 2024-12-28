import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/CenterTitle.dart';
import 'package:hivemind_app/widgets/general/HivesList.dart';
import 'package:hivemind_app/widgets/general/LocationCard.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';
import 'package:hivemind_app/widgets/general/SegmentedTab.dart';
import 'package:hivemind_app/widgets/owner/HivesTab.dart';
import 'package:hivemind_app/widgets/owner/TasksTab.dart';

class ApiaryPageBeekeeper extends StatefulWidget {
  const ApiaryPageBeekeeper({super.key});

  @override
  State<ApiaryPageBeekeeper> createState() => _ApiaryPageBeekeeperState();
}

class _ApiaryPageBeekeeperState extends State<ApiaryPageBeekeeper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hives"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          addVerticalSpace(24),
          CenterTitle(titleText: "Apiary 1"),
          addVerticalSpace(24),
          LocationCard(),
          addVerticalSpace(24),
          HivesList()
        ],
      ),
      bottomNavigationBar: NavbarBeekeeper(),
    );
  }
}
