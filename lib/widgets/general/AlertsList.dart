import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';

class AlertsList extends StatefulWidget {
  const AlertsList({super.key});

  @override
  State<AlertsList> createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> alerts = [
      {
        "title": "Temperature high",
        "message": "Check hive #3 for temperature",
        "time": "15:09"
      },
      {
        "title": "Temperature high",
        "message": "Check hive #3 for temperature",
        "time": "15:09"
      },
      {
        "title": "Temperature high",
        "message": "Check hive #3 for temperature",
        "time": "15:09"
      },
      {
        "title": "Temperature high",
        "message": "Check hive #3 for temperature",
        "time": "15:09"
      },
      {
        "title": "Temperature high",
        "message": "Check hive #3 for temperature",
        "time": "15:09"
      },
    ];
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: ListView.separated(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            return AlertListItem(context, alerts[index]);
          },
          separatorBuilder: (context, index) => addVerticalSpace(10),
        ),
      ),
    );
  }
}
