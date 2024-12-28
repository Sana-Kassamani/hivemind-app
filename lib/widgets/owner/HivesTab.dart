import 'package:flutter/material.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/HivesList.dart';
import 'package:hivemind_app/widgets/general/LocationCard.dart';

class HivesTab extends StatefulWidget {
  const HivesTab({super.key});

  @override
  State<HivesTab> createState() => _HivesTabState();
}

class _HivesTabState extends State<HivesTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 24,
        children: [
          LocationCard(),
          HivesList(),
          FilledBtn(
            text: "Add a New Hive",
            icon: Icon(Icons.add),
            onPress: () {},
          )
        ],
      ),
    );
  }
}
