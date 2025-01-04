import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/HivesList.dart';
import 'package:hivemind_app/widgets/general/LocationCard.dart';
import 'package:provider/provider.dart';

class HivesTab extends StatefulWidget {
  const HivesTab({super.key});

  @override
  State<HivesTab> createState() => _HivesTabState();
}

class _HivesTabState extends State<HivesTab> {
  @override
  Widget build(BuildContext context) {
    String apiaryId = ModalRoute.of(context)!.settings.arguments as String;
    return Expanded(
      child: Consumer<Apiaries>(
          builder: (BuildContext context, Apiaries value, Widget? child) {
        return Column(
          spacing: 24,
          children: [
            LocationCard(apiary: value.getById(apiaryId: apiaryId)),
            HivesList(
              apiaryId: apiaryId,
            ),
            FilledBtn(
              text: "Add a New Hive",
              icon: Icon(Icons.add),
              onPress: () {},
            )
          ],
        );
      }),
    );
  }
}
