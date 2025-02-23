import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/widgets/general/ClearTextBtn.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/TasksList.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:hivemind_app/widgets/owner/add.task.dialogue.dart';
import 'package:provider/provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  void _showDialog(apiaryId) {
    showDialog(
        context: context,
        builder: (context) {
          return AddTask(
            apiaryId: apiaryId,
          );
        });
  }

  void clearCompletedTasks({required apiaryId}) {
    Provider.of<Tasks>(context, listen: false)
        .clearCompletedTasks(apiaryId: apiaryId);
  }

  @override
  Widget build(BuildContext context) {
    String apiaryId = ModalRoute.of(context)!.settings.arguments as String;
    return Expanded(
      child: Consumer<Tasks>(
          builder: (BuildContext context, Tasks value, Widget? child) {
        return Column(
          children: [
            value.tasks[apiaryId]!.isEmpty
                ? Expanded(child: EmptyState(context: context))
                : Expanded(
                    child: Column(
                      children: [
                        ClearTextBtn(context, "Clear Completed",
                            () => clearCompletedTasks(apiaryId: apiaryId)),
                        TasksListOwner(
                          tasks: value.tasks[apiaryId],
                        ),
                      ],
                    ),
                  ),
            FilledBtn(
              text: "Add a New Task",
              icon: Icon(Icons.add),
              onPress: () {
                _showDialog(apiaryId);
              },
            )
          ],
        );
      }),
    );
  }
}
