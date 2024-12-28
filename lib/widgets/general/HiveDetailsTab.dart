import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/general/DatesRow.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';
import 'package:hivemind_app/widgets/general/HiveGrid.dart';

class HiveDetailsTab extends StatefulWidget {
  const HiveDetailsTab({super.key});

  @override
  State<HiveDetailsTab> createState() => _HiveDetailsTabState();
}

class _HiveDetailsTabState extends State<HiveDetailsTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(padding: EdgeInsets.symmetric(horizontal: 20), children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HiveGrid(),
            addVerticalSpace(20),
            DatesRow(),
            addVerticalSpace(20),
            DiseasesCard(context: context),
          ],
        ),
      ]),
    );
  }
}
