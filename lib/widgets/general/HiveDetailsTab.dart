import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/general/DatesRow.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';
import 'package:hivemind_app/widgets/general/HiveGrid.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:provider/provider.dart';

class HiveDetailsTab extends StatefulWidget {
  const HiveDetailsTab({super.key});

  @override
  State<HiveDetailsTab> createState() => _HiveDetailsTabState();
}

class _HiveDetailsTabState extends State<HiveDetailsTab> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String apiaryId = arg?["apiaryId"];
    String hiveId = arg?["hiveId"];
    return Expanded(
      child: Consumer<IotDetails>(
          builder: (BuildContext context, IotDetails value, Widget? child) {
        if (value.iotDetails[hiveId]!.isEmpty) {
          return Column(children: [
            Text(
                "No hive details in the meantime!\nDetails will be updated in 24 hours."),
            Expanded(child: EmptyState(context: context)),
          ]);
        } else {
          return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HiveGrid(),
                    addVerticalSpace(12),
                    DatesRow(),
                    addVerticalSpace(12),
                    Consumer<Hives>(builder:
                        (BuildContext context, Hives value, Widget? child) {
                      return diseasesCard(
                          context: context,
                          diseasesList: value
                              .getById(hiveId: hiveId, apiaryId: apiaryId)
                              .diseases);
                    }),
                  ],
                ),
              ]);
        }
      }),
    );
  }
}
