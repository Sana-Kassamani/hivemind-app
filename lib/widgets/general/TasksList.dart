import 'package:flutter/material.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/TaskExpansionTile.dart';

class TasksListOwner extends StatelessWidget {
  const TasksListOwner({super.key});

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
            return TaskExpansionTileOwner(task: tasks[index]);
          },
          separatorBuilder: (context, index) => addVerticalSpace(10),
        ),
      ),
    );
  }
}

class TasksListBeekeeper extends StatelessWidget {
  const TasksListBeekeeper({super.key});

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
            return TaskExpansionTileBeekeeper(task: tasks[index]);
          },
          separatorBuilder: (context, index) => addVerticalSpace(10),
        ),
      ),
    );
  }
}
