import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/detailsList.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';
import 'package:provider/provider.dart';

class DatesRow extends StatefulWidget {
  const DatesRow({super.key});

  @override
  State<DatesRow> createState() => _DatesRowState();
}

class _DatesRowState extends State<DatesRow> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String apiaryId = arg?["apiaryId"];
    String hiveId = arg?["hiveId"];

    return Container(
      child: Consumer<Hives>(
          builder: (BuildContext context, Hives hiveValue, Widget? child) {
        return Consumer<IotDetails>(
            builder: (BuildContext context, IotDetails value, Widget? child) {
          final dates = datesList(
            hive: hiveValue.getById(apiaryId: apiaryId, hiveId: hiveId),
            detail: value.iotDetails[hiveId]![0],
          );
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              for (int i = 0; i < dates.length; i++)
                DateCard(context, dates[i]["title"], dates[i]["date"]),
            ],
          );
        });
      }),
    );
  }
}
