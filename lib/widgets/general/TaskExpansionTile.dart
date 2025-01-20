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

class ExpandedTile extends StatefulWidget {
  const ExpandedTile({super.key, required this.task});
  final Task task;

  @override
  State<ExpandedTile> createState() => _ExpandedTileState();
}

class _ExpandedTileState extends State<ExpandedTile> {
  var comment = "";
  final _controller = TextEditingController();

  Future addComment({required taskId}) async {
    String? assignedApiary =
        Provider.of<Apiaries>(context, listen: false).apiary?.getId();
    String apiaryId =
        assignedApiary ?? ModalRoute.of(context)!.settings.arguments as String;
    print("TaskId $taskId and apiaryId $apiaryId");
    try {
      await Provider.of<Tasks>(context, listen: false)
          .addComment(apiaryId: apiaryId, taskId: taskId, comment: comment);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Add comment failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Status: ${task.status}",
        //     style: Theme.of(context).textTheme.labelMedium),
        Text(
          widget.task.content,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Divider(),
        Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Comments",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            widget.task.status == "Pending"
                ? TextField(
                    controller: _controller,
                    style: Theme.of(context).textTheme.labelSmall,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).colorScheme.tertiaryFixed,
                          ),
                          onPressed: () async {
                            if (_controller.text.isEmpty) {
                            } else {
                              await addComment(taskId: widget.task.id);
                              _controller.clear();
                            }
                          },
                        ),
                        label: Text("Add a comment",
                            style: Theme.of(context).textTheme.labelSmall),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.tertiaryFixed,
                              width: 1.0,
                            ))),
                    onChanged: (value) {
                      setState(() {
                        comment = value;
                      });
                    },
                  )
                : SizedBox.shrink(),
            widget.task.comments.isEmpty
                ? Text("No comments")
                : Column(
                    spacing: 25,
                    children: widget.task.comments.map((comment) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                capitalize(comment.userName),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontSize: 12),
                              ),
                              Text(
                                parseDateTime(dateTime: comment.date),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Text(
                            comment.content,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
          ],
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
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      leading: widget.task.status == "Pending"
          ? iconBox(
              Icons.circle_outlined, Theme.of(context).colorScheme.secondary)
          : iconBox(
              Icons.check_circle, Theme.of(context).colorScheme.secondary),
      title: Text(
        widget.task.title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: Text(
        widget.task.date,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        ExpandedTile(task: widget.task),
      ],
    );
  }
}

// class ExpandedTileBeekeeper extends StatefulWidget {
//   ExpandedTileBeekeeper(
//       {super.key,
//       required this.task,
//       required this.comment,
//       required this.setComment});
//   String? comment;
//   final Task task;
//   final setComment;

//   @override
//   State<ExpandedTileBeekeeper> createState() => _ExpandedTileBeekeeperState();
// }

// class _ExpandedTileBeekeeperState extends State<ExpandedTileBeekeeper> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 20,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.task.content,
//           style: Theme.of(context).textTheme.labelMedium,
//         ),
//         TextField(
//           style: Theme.of(context).textTheme.labelSmall,
//           decoration: InputDecoration(
//             label:
//                 Text("Comment", style: Theme.of(context).textTheme.labelSmall),
//           ),
//           onChanged: (value) {
//             widget.setComment(value);
//           },
//         ),
//       ],
//     );
//   }
// }
