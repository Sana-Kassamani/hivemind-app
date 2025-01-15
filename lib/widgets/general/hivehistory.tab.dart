import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:hivemind_app/widgets/general/charts.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:provider/provider.dart';

enum ChartType { temperature, humidity, mass }

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});
  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  var selectedType = ChartType.temperature;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String hiveId = arg?["hiveId"];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<IotDetails>(
            builder: (BuildContext context, IotDetails value, Widget? child) {
          if (value.iotDetails[hiveId]!.isEmpty) {
            return Column(children: [
              Text(
                  "No hive history in the meantime!\nHistory will be updated in 24 hours."),
              Expanded(child: EmptyState(context: context)),
            ]);
          } else {
            return ListView(
              children: [
                Column(
                  spacing: 24,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio(
                              toggleable: true,
                              value: ChartType.temperature,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value!;
                                });
                              },
                            ),
                            Text("Temperature"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              toggleable: true,
                              value: ChartType.humidity,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value!;
                                });
                              },
                            ),
                            Text("Humidity"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              toggleable: true,
                              value: ChartType.mass,
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value!;
                                });
                              },
                            ),
                            Text("Mass"),
                          ],
                        )
                      ],
                    ),
                    if (selectedType == ChartType.temperature)
                      Column(
                        children: [
                          Text(
                            "Temperature (°C)",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          addVerticalSpace(10),
                          DetailLineChart(
                            hiveId: hiveId,
                            label: "Temperature (°C)",
                            chartType: ChartType.temperature,
                            yRange: [10.0, 50.0],
                          ),
                        ],
                      )
                    else if (selectedType == ChartType.humidity)
                      Column(
                        children: [
                          Text(
                            "Humidity (%)",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          addVerticalSpace(20),
                          DetailLineChart(
                            hiveId: hiveId,
                            label: "Humidity (%)",
                            chartType: ChartType.humidity,
                            yRange: [0.0, 90.0],
                          ),
                        ],
                      )
                    else if (selectedType == ChartType.mass)
                      Column(
                        children: [
                          Text(
                            "Mass (kg)",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          addVerticalSpace(20),
                          DetailLineChart(
                            hiveId: hiveId,
                            label: "Mass (kg)",
                            chartType: ChartType.mass,
                            yRange: [0.0, 90.0],
                          )
                        ],
                      ),
                  ],
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
