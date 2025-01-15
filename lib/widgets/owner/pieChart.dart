import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';

class Piechart extends StatelessWidget {
  const Piechart({super.key, this.parts});

  final parts;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.CARD_BG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hives / Apiary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            addVerticalSpace(20),
            Center(
              child: Container(
                width: 250,
                height: 250,
                child: PieChart(PieChartData(sections: [
                  for (var part in parts)
                    PieChartSectionData(
                        radius: 70,
                        value: part["count"].toDouble(),
                        title: part["label"],
                        titleStyle: Theme.of(context).textTheme.titleMedium,
                        color: Theme.of(context).colorScheme.primary),
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
