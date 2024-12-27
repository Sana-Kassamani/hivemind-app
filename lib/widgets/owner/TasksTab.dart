import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          ExpansionTile(
            leading: iconBox(
                Icons.check_circle, Theme.of(context).colorScheme.secondary),
            title: Text(
              "Task #1",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            subtitle: Text(
              "Nov 14, 2023",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            children: [
              Text("Heyyy"),
            ],
          )
        ],
      ),
    );
  }
}
