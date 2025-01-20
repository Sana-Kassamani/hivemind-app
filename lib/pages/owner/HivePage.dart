import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/CenterTitle.dart';
import 'package:hivemind_app/widgets/general/DatesRow.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsTab.dart';
import 'package:hivemind_app/widgets/general/HiveGrid.dart';
import 'package:hivemind_app/widgets/general/SegmentedTab.dart';
import 'package:hivemind_app/widgets/general/hivehistory.tab.dart';
import 'package:provider/provider.dart';

class HivePageOwner extends StatefulWidget {
  const HivePageOwner({super.key});

  @override
  State<HivePageOwner> createState() => _HivePageOwnerState();
}

class _HivePageOwnerState extends State<HivePageOwner> {
  int? selectedControl = 0; // track the selected control value

  // update the selectedControl
  void onSegmentChanged(int? value) {
    setState(() {
      selectedControl = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String apiaryId = arg?["apiaryId"];
    String hiveId = arg?["hiveId"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("My Apiaries"),
      ),
      body: Column(
        children: [
          addVerticalSpace(24),
          Consumer<Hives>(
              builder: (BuildContext context, Hives value, Widget? child) {
            return CenterTitle(
                titleText:
                    value.getById(apiaryId: apiaryId, hiveId: hiveId).label);
          }),
          addVerticalSpace(24),
          SegmentedTab(
            selectedControl: selectedControl,
            onValueChanged: onSegmentChanged,
            tabs: ["General", "History"],
          ),
          addVerticalSpace(24),
          if (selectedControl == 0)
            HiveDetailsTab()
          else if (selectedControl == 1)
            HistoryTab(),
        ],
      ),
    );
  }
}
