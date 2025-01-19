import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/models/iotDetail.model.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:provider/provider.dart';

class LineChartSample12 extends StatefulWidget {
  const LineChartSample12({super.key, required this.hiveId});

  final hiveId;

  @override
  State<LineChartSample12> createState() => _LineChartSample12State();
}

class _LineChartSample12State extends State<LineChartSample12> {
  List<(DateTime, double)>? _bitcoinPriceHistory;
  late TransformationController _transformationController;
  bool _isPanEnabled = true;
  bool _isScaleEnabled = true;

  @override
  void initState() {
    _transformationController = TransformationController();
    super.initState();
  }

  // void _reloadData() {
  //   setState(() {
  //     Map<String, List<IotDetail>> detailsMap =
  //         Provider.of<IotDetails>(context).iotDetails;
  //     _bitcoinPriceHistory = detailsMap[widget.hiveId]!.map((detail) {
  //       return (detail.dateTime, detail.temperature);
  //     }).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    const leftReservedSize = 52.0;
    return Column(spacing: 16, children: [
      LayoutBuilder(builder: (context, constraints) {
        return Consumer<IotDetails>(builder:
            (BuildContext context, IotDetails detailsValue, Widget? child) {
          _bitcoinPriceHistory = detailsValue.iotDetails[widget.hiveId]!
              .map((detail) {
                return (detail.dateTime, detail.temperature);
              })
              .toList()
              .reversed
              .toList();

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
                  panEnabled: _isPanEnabled,
                  scaleEnabled: _isScaleEnabled,
                  transformationController: _transformationController,
                ),
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _bitcoinPriceHistory?.asMap().entries.map((e) {
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
                  minY: 10,
                  maxY: 45,
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
                          final date =
                              _bitcoinPriceHistory![barSpot.x.toInt()].$1;
                          return LineTooltipItem(
                            '',
                            const TextStyle(
                              color: Colors.black,
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
                                text: '\n${barSpot.y} °C',
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
                          final date = _bitcoinPriceHistory![value.toInt()].$1;
                          return SideTitleWidget(
                            space: 29,
                            meta: meta,
                            child: Transform.rotate(
                              angle: -45 * 3.14 / 180,
                              child: Text(
                                '${date.month}/${date.day} \t ${date.hour}:${date.minute}',
                                style: const TextStyle(
                                  color: Colors.black,
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

// class _ChartTitle extends StatelessWidget {
//   const _ChartTitle();

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 14),
//         Text(
//           'Bitcoin Price History',
//           style: TextStyle(
//             color: Colors.yellow,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         Text(
//           '2023/12/19 - 2024/12/17',
//           style: TextStyle(
//             color: Colors.green,
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//         SizedBox(height: 14),
//       ],
//     );
//   }
// }

// class _TransformationButtons extends StatelessWidget {
//   const _TransformationButtons({
//     required this.controller,
//   });

//   final TransformationController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Tooltip(
//           message: 'Zoom in',
//           child: IconButton(
//             icon: const Icon(
//               Icons.add,
//               size: 16,
//             ),
//             onPressed: _transformationZoomIn,
//           ),
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Tooltip(
//               message: 'Move left',
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back_ios,
//                   size: 16,
//                 ),
//                 onPressed: _transformationMoveLeft,
//               ),
//             ),
//             Tooltip(
//               message: 'Reset zoom',
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.refresh,
//                   size: 16,
//                 ),
//                 onPressed: _transformationReset,
//               ),
//             ),
//             Tooltip(
//               message: 'Move right',
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                 ),
//                 onPressed: _transformationMoveRight,
//               ),
//             ),
//           ],
//         ),
//         Tooltip(
//           message: 'Zoom out',
//           child: IconButton(
//             icon: const Icon(
//               Icons.minimize,
//               size: 16,
//             ),
//             onPressed: _transformationZoomOut,
//           ),
//         ),
//       ],
//     );
//   }

//   void _transformationReset() {
//     controller.value = Matrix4.identity();
//   }

//   void _transformationZoomIn() {
//     controller.value *= Matrix4.diagonal3Values(
//       1.1,
//       1.1,
//       1,
//     );
//   }

//   void _transformationMoveLeft() {
//     controller.value *= Matrix4.translationValues(
//       20,
//       0,
//       0,
//     );
//   }

//   void _transformationMoveRight() {
//     controller.value *= Matrix4.translationValues(
//       -20,
//       0,
//       0,
//     );
//   }

//   void _transformationZoomOut() {
//     controller.value *= Matrix4.diagonal3Values(
//       0.9,
//       0.9,
//       1,
//     );
//   }
// }
