import 'dart:typed_data';

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
    const List<Map<String, String>> tasks = [
      {
        "title": "Task #1",
        "status": "Pending",
        "content": "check this and that hive",
        "comment": "",
        "date": "Nov 13, 2024"
      },
      {
        "title": "Task #2",
        "status": "Done",
        "content": "check this and that hive",
        "comment": "No comment",
        "date": "Nov 13, 2024"
      },
      {
        "title": "Task #3",
        "status": "Pending",
        "content": "check this and that hive",
        "comment": "",
        "date": "Nov 13, 2024"
      },
      {
        "title": "Task #4",
        "status": "Done",
        "content": "check this and that hive",
        "comment": "hey this is a comment",
        "date": "Nov 13, 2024"
      },
    ];
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: ListView.separated(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              leading: tasks[index]["status"] == "Pending"
                  ? iconBox(Icons.circle_outlined,
                      Theme.of(context).colorScheme.secondary)
                  : iconBox(Icons.check_circle,
                      Theme.of(context).colorScheme.secondary),
              title: Text(
                tasks[index]["title"]!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              subtitle: Text(
                tasks[index]["date"]!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              children: [
                tasks[index]["status"] == "Pending"
                    ? Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status: ${tasks[index]["status"]!}",
                              style: Theme.of(context).textTheme.labelMedium),
                          Text(
                            tasks[index]["content"]!,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      )
                    : Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status: ${tasks[index]["status"]!}",
                              style: Theme.of(context).textTheme.labelMedium),
                          Text(
                            tasks[index]["content"]!,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            "Comment: ${tasks[index]["comment"]}",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      )
              ],
            );
          },
          separatorBuilder: (context, index) => addVerticalSpace(10),
        ),
      ),
    );
  }
}
