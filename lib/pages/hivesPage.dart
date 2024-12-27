import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/CenterTitle.dart';
import 'package:hivemind_app/widgets/FilledBtn.dart';
import 'package:hivemind_app/widgets/HivesList.dart';
import 'package:hivemind_app/widgets/LocationCard.dart';
import 'package:hivemind_app/widgets/SegmentedTab.dart';

class HivesPage extends StatefulWidget {
  const HivesPage({super.key});

  @override
  State<HivesPage> createState() => _HivesPageState();
}

class _HivesPageState extends State<HivesPage> {
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
          ),
          addVerticalSpace(24),
          LocationCard(),
          addVerticalSpace(24),
          if (selectedControl == 0)
            HivesList()
          else if (selectedControl == 1)
            Center(
              child: Image.asset("assets/icons/apiary_icon.png"),
            ),
          FilledBtn(
            text: "Add a New Hive",
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
