import 'package:flutter/material.dart';
import 'package:hivemind_app/models/task.model.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/capitalize.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:hivemind_app/widgets/owner/alert.dialogue.dart';
import 'package:provider/provider.dart';

class TaskExpansionTileOwner extends StatelessWidget {
  const TaskExpansionTileOwner({super.key, required this.task});

  final Task task;

  Future completeTask(
      {required taskId, required context, required apiaryId}) async {
    try {
      await Provider.of<Tasks>(context, listen: false)
          .completeTask(apiaryId: apiaryId, taskId: taskId);
      print("ApiaryId $apiaryId");
      print("task completed");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Complete Task failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String apiaryId = ModalRoute.of(context)!.settings.arguments as String;
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      leading: task.status == "Pending"
          ? IconButton(
              padding: EdgeInsets.all(5),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CompleteTaskDialogue(
                          onPressComplete: () => completeTask(
                              taskId: task.id,
                              context: context,
                              apiaryId: apiaryId));
                    });
              },
              icon: Icon(
                Icons.circle_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ))
          : IconButton(
              disabledColor: Theme.of(context).colorScheme.secondary,
              icon: Icon(Icons.check_circle),
              onPressed: null,
            ),
      title: Text(
        task.title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: Text(
        task.date,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        ExpandedTile(task: task),
      ],
    );
  }
}

class ExpandedTileOwner extends StatelessWidget {
  const ExpandedTileOwner({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return task.status == "Pending"
        ? Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Status: ${task.status}",
              //     style: Theme.of(context).textTheme.labelMedium),
              Text(
                task.content,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          )
        : Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Status: ${task.status}",
              //     style: Theme.of(context).textTheme.labelMedium),
              Text(
                task.content,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                "Comment: ${task.comment}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          );
  }
}

class TaskExpansionTileBeekeeper extends StatefulWidget {
  const TaskExpansionTileBeekeeper({super.key, required this.task});

  final Task task;

  @override
  State<TaskExpansionTileBeekeeper> createState() =>
      _TaskExpansionTileBeekeeperState();
}

class _TaskExpansionTileBeekeeperState
    extends State<TaskExpansionTileBeekeeper> {
  String? comment;
  void setComment(String _comment) {
    setState(() {
      comment = _comment;
    });
  }

  Future completeTask(
      {required taskId, required context, String? comment}) async {
    try {
      final apiaryId =
          Provider.of<Apiaries>(context, listen: false).apiary!.getId();
      await Provider.of<Tasks>(context, listen: false)
          .completeTask(apiaryId: apiaryId, taskId: taskId, comment: comment);
      print("ApiaryId $apiaryId");
      print("task completed");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete Hive failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      leading: IconButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return CompleteTaskDialogue(
                  onPressComplete: () => completeTask(
                    taskId: widget.task.id,
                    context: context,
                    comment: comment,
                  ),
                  comment: comment,
                );
              });
        },
        icon: Icon(
          Icons.circle_outlined,
          color: Theme.of(context).colorScheme.secondary,
        ),
        selectedIcon: Icon(
          Icons.check_circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      title: Text(
        widget.task.title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: Text(
        widget.task.date,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        ExpandedTileBeekeeper(
            task: widget.task, comment: comment, setComment: setComment),
      ],
    );
  }
}

class ExpandedTileBeekeeper extends StatefulWidget {
  ExpandedTileBeekeeper(
      {super.key,
      required this.task,
      required this.comment,
      required this.setComment});
  String? comment;
  final Task task;
  final setComment;

  @override
  State<ExpandedTileBeekeeper> createState() => _ExpandedTileBeekeeperState();
}

class _ExpandedTileBeekeeperState extends State<ExpandedTileBeekeeper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.task.content,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        TextField(
          style: Theme.of(context).textTheme.labelSmall,
          decoration: InputDecoration(
            label:
                Text("Comment", style: Theme.of(context).textTheme.labelSmall),
          ),
          onChanged: (value) {
            widget.setComment(value);
          },
        ),
      ],
    );
  }
}
