import 'package:flutter/material.dart';
import 'package:hivemind_app/widgets/general/ClearTextBtn.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/TasksList.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ClearTextBtn(context, "Clear Completed", () {}),
          TasksList(),
          FilledBtn(
            text: "Add a New Task",
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
