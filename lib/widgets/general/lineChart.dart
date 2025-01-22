import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/enums/ChartType.dart';
import 'package:provider/provider.dart';

class CustomLineChart extends StatefulWidget {
  const CustomLineChart(
      {super.key,
      required this.hiveId,
      required this.chartType,
      required this.yRange,
      this.unit});
  final chartType;
  final hiveId;
  final yRange;
  final unit;
  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<(DateTime, double)>? _details;
  late TransformationController _transformationController;

  @override
  void initState() {
    _transformationController = TransformationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const leftReservedSize = 52.0;
    return Column(spacing: 16, children: [
      LayoutBuilder(builder: (context, constraints) {
        return Consumer<IotDetails>(builder:
            (BuildContext context, IotDetails detailsValue, Widget? child) {
          _details = fill(
              details: detailsValue.iotDetails[widget.hiveId],
              type: widget.chartType);

          return AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                right: 18.0,
              ),
              child: LineChart(
                transformationConfig: FlTransformationConfig(
                  scaleAxis: FlScaleAxis.horizontal,
                  minScale: 2.0,
                  maxScale: 25.0,
                  panEnabled: true,
                  scaleEnabled: true,
                  transformationController: _transformationController,
                ),
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _details?.asMap().entries.map((e) {
                            final index = e.key;
                            final item = e.value;
                            final value = item.$2;
                            return FlSpot(index.toDouble(), value);
                          }).toList() ??
                          [],
                      dotData: const FlDotData(show: false),
                      color: Colors.yellow,
                      barWidth: 1,
                      shadow: const Shadow(
                        color: Colors.amberAccent,
                        blurRadius: 2,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow.shade100,
                            Colors.yellow.shade400,
                          ],
                          stops: const [0.5, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  minY: widget.yRange[0],
                  maxY: widget.yRange[1],
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  lineTouchData: LineTouchData(
                    touchSpotThreshold: 5,
                    getTouchLineStart: (_, __) => -double.infinity,
                    getTouchLineEnd: (_, __) => double.infinity,
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((spotIndex) {
                        return TouchedSpotIndicatorData(
                          const FlLine(
                            color: Colors.redAccent,
                            strokeWidth: 1.5,
                            dashArray: [8, 2],
                          ),
                          FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: Colors.yellow,
                                strokeWidth: 0,
                                strokeColor: Colors.yellowAccent,
                              );
                            },
                          ),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final date = _details![barSpot.x.toInt()].$1;
                          return LineTooltipItem(
                            '',
                            TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${date.year}/${date.month}/${date.day} \n ${date.hour}:${date.minute}',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: '\n${barSpot.y} ${widget.unit}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 209, 190, 24),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          );
                        }).toList();
                      },
                      getTooltipColor: (LineBarSpot barSpot) =>
                          Colors.yellow.shade50,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: leftReservedSize,
                        maxIncluded: false,
                        minIncluded: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        minIncluded: true,
                        maxIncluded: false,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final date = _details![value.toInt()].$1;
                          return SideTitleWidget(
                            space: 29,
                            meta: meta,
                            child: Transform.rotate(
                              angle: -45 * 3.14 / 180,
                              child: Text(
                                '${date.month}/${date.day} \t ${date.hour}:${date.minute}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                duration: Duration.zero,
              ),
            ),
          );
        });
      }),
    ]);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }
}

List<(DateTime, double)>? fillTemperature({required details}) {
  List<(DateTime, double)>? tempList = [];
  // .map((detail) {
  //   return (detail.dateTime, detail.temperature);
  // })
  // .toList()
  // .reversed
  // .toList();
  for (int i = details.length - 1; i >= 0; i--) {
    tempList.add((details[i].dateTime, details[i].temperature));
  }
  return tempList;
}

List<(DateTime, double)>? fillHumidity({required details}) {
  List<(DateTime, double)>? humidList = [];
  // .map((detail) {
  //   return (detail.dateTime, detail.humidity);
  // })
  // .toList()
  // .reversed
  // .toList();
  for (int i = details.length - 1; i >= 0; i--) {
    humidList.add((details[i].dateTime, details[i].humidity));
  }

  return humidList;
}

List<(DateTime, double)>? fillMass({required details}) {
  List<(DateTime, double)>? massList = [];
  // .map((detail) {
  //   return (detail.dateTime, detail.mass);
  // })
  // .toList()
  // .reversed
  // .toList();
  for (int i = details.length - 1; i >= 0; i--) {
    massList.add((details[i].dateTime, details[i].mass));
  }

  return massList;
}

List<(DateTime, double)>? fill({required type, required details}) {
  if (type == ChartType.temperature) {
    return fillTemperature(details: details);
  } else if (type == ChartType.humidity) {
    return fillHumidity(details: details);
  } else if (type == ChartType.mass) {
    return fillMass(details: details);
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
