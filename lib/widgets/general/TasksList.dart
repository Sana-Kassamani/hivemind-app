import 'package:flutter/material.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/TaskExpansionTile.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:provider/provider.dart';

class TasksListOwner extends StatelessWidget {
  const TasksListOwner({super.key, required this.tasks});
  final tasks;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: ListView.separated(
          itemCount: tasks!.length,
          itemBuilder: (context, index) {
            return TaskExpansionTileOwner(task: tasks![index]);
          },
          separatorBuilder: (context, index) => addVerticalSpace(10),
        ),
      ),
    );
  }
}

class TasksListBeekeeper extends StatelessWidget {
  const TasksListBeekeeper({super.key, this.tasks});
  final tasks;
  @override
  Widget build(BuildContext context) {
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
