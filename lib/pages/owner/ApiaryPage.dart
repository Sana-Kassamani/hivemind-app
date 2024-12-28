import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/CenterTitle.dart';
import 'package:hivemind_app/widgets/general/SegmentedTab.dart';
import 'package:hivemind_app/widgets/owner/HivesTab.dart';
import 'package:hivemind_app/widgets/owner/TasksTab.dart';

class ApiaryPage extends StatefulWidget {
  const ApiaryPage({super.key});

  @override
  State<ApiaryPage> createState() => _ApiaryPageState();
}

class _ApiaryPageState extends State<ApiaryPage> {
  int? selectedControl = 0; // track the selected control value

  // update the selectedControl
  void onSegmentChanged(int? value) {
    setState(() {
      selectedControl = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("My Apiaries"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          addVerticalSpace(24),
          CenterTitle(titleText: "Apiary 1"),
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
      ),
    );
  }
}
