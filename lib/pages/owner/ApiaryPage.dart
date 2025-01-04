import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/CenterTitle.dart';
import 'package:hivemind_app/widgets/general/SegmentedTab.dart';
import 'package:hivemind_app/widgets/owner/HivesTab.dart';
import 'package:hivemind_app/widgets/owner/TasksTab.dart';
import 'package:provider/provider.dart';

class ApiaryPageOwner extends StatefulWidget {
  const ApiaryPageOwner({super.key});

  @override
  State<ApiaryPageOwner> createState() => _ApiaryPageOwnerState();
}

class _ApiaryPageOwnerState extends State<ApiaryPageOwner> {
  int? selectedControl = 0; // track the selected control value

  // update the selectedControl
  void onSegmentChanged(int? value) {
    setState(() {
      selectedControl = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String apiaryId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("My Apiaries"),
      ),
      body: Consumer<Apiaries>(
          builder: (BuildContext context, Apiaries value, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(24),
            CenterTitle(
                titleText: value.getById(apiaryId: apiaryId).getLabel()),
            addVerticalSpace(24),
            SegmentedTab(
              selectedControl: selectedControl,
              onValueChanged: onSegmentChanged,
              tabs: ["Hives", "Tasks"],
            ),
            addVerticalSpace(24),
            if (selectedControl == 0)
              HivesTab()
            else if (selectedControl == 1)
              TasksTab()
          ],
        );
      }),
    );
  }
}
