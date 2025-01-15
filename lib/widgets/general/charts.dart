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
    return SizedBox(
      width: 1500,
      // color: ColorManager.CARD_BG,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          width: 1500,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Consumer<IotDetails>(builder:
              (BuildContext context, IotDetails detailsValue, Widget? child) {
            return LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    curveSmoothness: 0.5,
                    color: colors.primary,
                    spots: getSpots(
                        type: chartType,
                        details: detailsValue.iotDetails[hiveId],
                        hiveId: hiveId),
                    barWidth: 3,
                    gradient: LinearGradient(
                        colors: [colors.primary, colors.secondary]),
                    preventCurveOverShooting: true,
                  ),
                ],
                lineTouchData: LineTouchData(
                    touchSpotThreshold: 5,
                    getTouchLineStart: (_, __) => -double.infinity,
                    getTouchLineEnd: (_, __) => double.infinity,
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((spotIndex) {
                        return TouchedSpotIndicatorData(
                          const FlLine(
                            // color: AppColors.contentColorRed,
                            strokeWidth: 1.5,
                            dashArray: [8, 2],
                          ),
                          FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: colors.primary,
                                strokeWidth: 0,
                                // strokeColor: AppColors.contentColorYellow,
                              );
                            },
                          ),
                        );
                      }).toList();
                    },
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final data = barSpot.y;
                          int j = detailsValue.iotDetails[hiveId]!.length -
                              (barSpot.x.toInt() + 1);
                          DateTime date =
                              detailsValue.iotDetails[hiveId]![j].dateTime;
                          return LineTooltipItem(
                            '',
                            textAlign: TextAlign.center,
                            const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '$data kg',
                                style: TextStyle(
                                  color: colors.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              TextSpan(
                                text: "\n${graphDate(date: date)}",
                                style: TextStyle(
                                  color: colors.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          );
                        }).toList();
                      },

                      getTooltipColor: (LineBarSpot barSpot) => colors.primary,
                      // AppColors.contentColorBlack,
                    )),

                // minY: yRange[0],
                // maxY: yRange[1],
                minX: 0,
                maxX: detailsValue.iotDetails[hiveId]!.length - 1,
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: colors.primary),
                ),
                gridData: FlGridData(show: false),

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
                      reservedSize: 40,
                      interval: 5,
                      showTitles: true,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(
                      "Date & Time",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      interval: 1,
                      reservedSize: 30,
                      // showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int j = detailsValue.iotDetails[hiveId]!.length -
                            (value.toInt() + 1);
                        DateTime date =
                            detailsValue.iotDetails[hiveId]![j].dateTime;
                        return SideTitleWidget(
                          meta: meta,
                          child: Transform.rotate(
                            angle: -45 * 3.14 / 180,
                            child: Text(
                              graphDate(date: date),
                              style: const TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

List<FlSpot> getSpots({required type, required details, required hiveId}) {
  if (type == ChartType.temperature) {
    return temperatureSpots(details: details, hiveId: hiveId);
  } else if (type == ChartType.humidity) {
    return humiditySpots(details: details, hiveId: hiveId);
  } else if (type == ChartType.mass) {
    return massSpots(details: details, hiveId: hiveId);
  } else {
    return [];
  }
}

List<FlSpot> temperatureSpots({required details, required hiveId}) {
  List<FlSpot> list = [];
  int j = 0;
  for (int i = details.length - 1; i >= 0; i--) {
    list.add(FlSpot(j.toDouble(), details[i].temperature));
    j++;
  }
  return list;
}

List<FlSpot> humiditySpots({required details, required hiveId}) {
  List<FlSpot> list = [];
  int j = 0;
  for (int i = details.length - 1; i >= 0; i--) {
    list.add(FlSpot(j.toDouble(), details[i].humidity));
    j++;
  }

  return list;
}

List<FlSpot> massSpots({required details, required hiveId}) {
  List<FlSpot> list = [];
  int j = 0;
  for (int i = details.length - 1; i >= 0; i--) {
    list.add(FlSpot(j.toDouble(), details[i].mass));
    j++;
  }
  return list;
}
