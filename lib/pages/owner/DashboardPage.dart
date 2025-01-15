import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/owner/dashboardCard.dart';
import 'package:hivemind_app/widgets/owner/pieChart.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

List<Map<String, dynamic>> getSections({required apiaries, required hives}) {
  List<Map<String, dynamic>> parts = [];
  for (var apiary in apiaries) {
    final apiaryId = apiary.id;
    final apiaryLabel = apiary.label;
    final hiveCount = hives[apiaryId]?.length ?? 0;
    parts.add({"label": apiaryLabel, "count": hiveCount});
  }
  return parts;
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Dashboard"),
      ),
      body: Consumer<Apiaries>(
          builder: (BuildContext context, Apiaries apiaries, Widget? child) {
        return Consumer<Hives>(
            builder: (BuildContext context, Hives hives, Widget? child) {
          return Consumer<Beekeepers>(builder:
              (BuildContext context, Beekeepers beekeepers, Widget? child) {
            final apiariesCount = apiaries.getApiariesCount();
            final hivesCount = hives.getHivesCount();
            final keepersCount = beekeepers.getBeekeepersCount(
                apiaries: apiaries.apiariesList.map((a) => a.getId()));
            final parts = getSections(
                apiaries: apiaries.apiariesList, hives: hives.hives);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Column(
                children: [
                  addVerticalSpace(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DashboardCard(
                        number: apiariesCount,
                        title: apiariesCount == 1 ? "Apiary" : "Apiaries",
                      ),
                      DashboardCard(
                        number: hivesCount,
                        title: hivesCount == 1 ? "Hive" : "Hives",
                      ),
                      DashboardCard(
                        number: keepersCount,
                        title: keepersCount == 1 ? "Beekeeper" : "Beekeepers",
                      )
                    ],
                  ),
                  addVerticalSpace(24),
                  Piechart(
                    parts: parts,
                  )
                ],
              ),
            );
          });
        });
      }),
    );
  }
}
