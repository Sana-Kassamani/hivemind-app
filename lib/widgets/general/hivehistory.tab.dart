import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/enums/ChartType.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:hivemind_app/widgets/general/lineChart.dart';
import 'package:provider/provider.dart';

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
                    Theme(
                      data: Theme.of(context).copyWith(
                        radioTheme: RadioThemeData(
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            // active
                            if (states.contains(WidgetState.selected)) {
                              return Theme.of(context).colorScheme.primary;
                            }
                            // inactive
                            return Theme.of(context).colorScheme.tertiary;
                          }),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio(
                                overlayColor: WidgetStatePropertyAll(
                                    Theme.of(context).colorScheme.tertiary),
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
                    ),
                    if (selectedType == ChartType.temperature)
                      Column(
                        children: [
                          Text(
                            "Temperature (°C)",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          addVerticalSpace(10),
                          CustomLineChart(
                            hiveId: hiveId,
                            chartType: ChartType.temperature,
                            yRange: [10.0, 50.0],
                            unit: "°C",
                          )
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
                          CustomLineChart(
                            hiveId: hiveId,
                            chartType: ChartType.humidity,
                            yRange: [0.0, 90.0],
                            unit: "%",
                          )
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
                          CustomLineChart(
                            hiveId: hiveId,
                            chartType: ChartType.mass,
                            yRange: [-5.0, 90.0],
                            unit: "kg",
                          ),
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
