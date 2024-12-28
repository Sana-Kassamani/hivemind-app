import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/CenterTitle.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';
import 'package:hivemind_app/widgets/general/HiveGrid.dart';
import 'package:hivemind_app/widgets/general/SegmentedTab.dart';

class HivePage extends StatefulWidget {
  const HivePage({super.key});

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
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
          children: [
            addVerticalSpace(24),
            CenterTitle(titleText: "Hive 1 Label"),
            addVerticalSpace(24),
            SegmentedTab(
              selectedControl: selectedControl,
              onValueChanged: onSegmentChanged,
              tabs: ["General", "History"],
            ),
            addVerticalSpace(24),
            if (selectedControl == 0)
              HiveGrid()
            else if (selectedControl == 1)
              Center()
          ],
        ));
  }
}
