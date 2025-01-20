import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';

class AlertsList extends StatefulWidget {
  const AlertsList({super.key, required this.alerts});

  final alerts;

  @override
  State<AlertsList> createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: ListView.separated(
          itemCount: widget.alerts.length,
          itemBuilder: (context, index) {
            return AlertListItem(context, widget.alerts[index]);
          },
          separatorBuilder: (context, index) => addVerticalSpace(10),
        ),
      ),
    );
  }
}
