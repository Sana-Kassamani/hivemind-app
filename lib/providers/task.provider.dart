import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:intl/intl.dart';

class Task extends ChangeNotifier {
  final String id;
  final String title;
  final String content;
  final String status;
  final String comment;
  final String date;

  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.comment,
    required this.date,
  });

  List<Task> save({tasks}) {
    List<Task> taskList = [];

    for (int i = 0; i < tasks.length; i++) {
      var task = tasks[i];

      // parse date of task to Jan 01, 2000 format
      String updatedDt = parseDate(date: task["date"]);

      final newTask = Task(
        id: task["_id"],
        title: task["title"],
        content: task["content"],
        status: task["status"],
        comment: task["comment"],
        date: updatedDt,
      );

      taskList.add(newTask);
      print("New task ${newTask.toString()}");
    }

    notifyListeners();
    return taskList;
  }
}

// @Schema()
// export class Task {

//   _id: Types.ObjectId;

//   @Prop({ type: String, required: true })
//   title: string;

//   @Prop({ type: String, required: true })
//   content: string;

//   @Prop({ type: String, enum: TaskStatus, default: TaskStatus.Pending })
//   status: string;

//   @Prop({ type: String, required: false, default: '' })
//   comment: string;

//   @Prop({ type: Date, required: true, default: Date.now })
//   date: Date;
// }
