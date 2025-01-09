import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:hivemind_app/widgets/general/hivehistory.tab.dart';
import 'package:provider/provider.dart';

class DetailLineChart extends StatelessWidget {
  const DetailLineChart({
    super.key,
    required this.hiveId,
    required this.label,
    required this.chartType,
    required this.yRange,
  });
  final hiveId;
  final label;
  final chartType;
  final yRange;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: ColorManager.CARD_BG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.55,
        child: Consumer<IotDetails>(builder:
            (BuildContext context, IotDetails detailsValue, Widget? child) {
          print(detailsValue.iotDetails[hiveId]![1].date);
          return LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  curveSmoothness: 0.5,
                  color: colors.primary,
                  spots: getSlots(
                      type: chartType,
                      details: detailsValue.iotDetails[hiveId],
                      hiveId: hiveId),
                  barWidth: 3,
                  gradient: LinearGradient(
                      colors: [colors.primary, colors.secondary]),
                  // preventCurveOverShooting: true,
                ),
              ],
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: colors.primary),
              ),
              gridData: FlGridData(show: false),
              minY: yRange[0],
              maxY: yRange[1],
              minX: 0,
              maxX: detailsValue.iotDetails[hiveId]!.length - 1,
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  // axisNameWidget: Text(
                  //   label,
                  //   style: Theme.of(context).textTheme.bodyMedium,
                  // ),
                  // axisNameSize: 20,
                  sideTitles: SideTitles(
                    minIncluded: false,
                    reservedSize: 25,
                    interval: 10,
                    showTitles: true,
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Text(
                    "Time",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  axisNameSize: 20,
                  sideTitles: SideTitles(
                    interval: 1,
                    reservedSize: 15,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int j = detailsValue.iotDetails[hiveId]!.length -
                          (value.toInt() + 1);
                      DateTime date =
                          detailsValue.iotDetails[hiveId]![j].dateTime;
                      return Text(graphDate(date: date));
                    },
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
