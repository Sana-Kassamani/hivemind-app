import 'package:flutter/material.dart';
import 'package:hivemind_app/models/task.model.dart';
import 'package:hivemind_app/utils/parseDate.dart';

class Tasks extends ChangeNotifier {
  final Map<String, List<Task>> _tasks = {};
  Map<String, List<Task>> get tasks => _tasks;

  List<Task> filterPendingTasks({apiaryId}) {
    List<Task> list =
        _tasks[apiaryId]!.where((task) => task.status == "Pending").toList();
    return list;
  }

  void save({apiaryId, tasks}) {
    _tasks[apiaryId] = [];

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

      _tasks[apiaryId]!.add(newTask);
      print("New task ${newTask.toString()}");
    }

    notifyListeners();
  }
}
