import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';

import 'package:hivemind_app/utils/detailsList.dart';

import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';
import 'package:provider/provider.dart';

class HiveGrid extends StatefulWidget {
  const HiveGrid({super.key});

  @override
  State<HiveGrid> createState() => _HiveGridState();
}

class _HiveGridState extends State<HiveGrid> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String apiaryId = arg?["apiaryId"];
    String hiveId = arg?["hiveId"];
    return Consumer<Hives>(
        builder: (BuildContext context, Hives hiveValue, Widget? child) {
      return SizedBox(
        child: Consumer<IotDetails>(
            builder: (BuildContext context, IotDetails value, Widget? child) {
          final details = detailsList(
            hive: hiveValue.getById(apiaryId: apiaryId, hiveId: hiveId),
            detail: value.iotDetails[hiveId]![0],
          );
          return GridView.builder(
            itemCount: details.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.7,
              // mainAxisExtent: 100,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return HiveDetailsCard(
                  context: context,
                  iconColor: details[index]["iconColor"],
                  circleColor: details[index]["circleColor"],
                  imagePath: details[index]["imagePath"],
                  title: details[index]["title"],
                  content: details[index]["content"]);
            },
          );
        }),
      );
    });
  }
}
