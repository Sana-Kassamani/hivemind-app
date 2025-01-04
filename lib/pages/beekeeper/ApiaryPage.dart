import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/CenterTitle.dart';
import 'package:hivemind_app/widgets/general/HivesList.dart';
import 'package:hivemind_app/widgets/general/LocationCard.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';
import 'package:hivemind_app/widgets/general/SegmentedTab.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:hivemind_app/widgets/owner/HivesTab.dart';
import 'package:hivemind_app/widgets/owner/TasksTab.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<Apiaries>(
          builder: (BuildContext context, Apiaries value, Widget? child) {
        return value.apiary == null
            ? EmptyState(context: context)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addVerticalSpace(24),
                  CenterTitle(titleText: value.apiary!.getLabel()),
                  addVerticalSpace(24),
                  LocationCard(apiary: value.apiary!),
                  addVerticalSpace(24),
                  HivesList(
                    apiaryId: value.apiary!.getId(),
                  )
                ],
              );
      }),
      // bottomNavigationBar: NavbarBeekeeper(),
    );
  }
}
