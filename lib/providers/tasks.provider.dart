import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/models/task.model.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:hivemind_app/utils/request.dart';

class Tasks extends ChangeNotifier {
  final Map<String, List<Task>> _tasks = {};
  Map<String, List<Task>> get tasks => _tasks;

  Task getById({apiaryId, taskId}) {
    Task task = _tasks[apiaryId]!.firstWhere((t) => t.id == taskId);
    return task;
  }

  List<Task> filterPendingTasks({required apiaryId}) {
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

  Future addTask({
    context,
    apiaryId,
    title,
    content,
  }) async {
    Map<String, dynamic> data = {
      "title": title,
      "content": content,
    };
    try {
      final response = await request(
        route: '/tasks/$apiaryId',
        method: RequestMethods.post,
        data: data,
      );
      var tasksLength = jsonDecode(response)["tasks"].length;
      var task = jsonDecode(response)["tasks"][tasksLength - 1];

      String updatedDt = parseDate(date: task["date"]);

      Task newTask = Task(
        id: task["_id"],
        title: title,
        content: content,
        status: task["status"],
        comment: task["comment"],
        date: updatedDt,
      );

      _tasks[apiaryId] = [];
      _tasks[apiaryId]!.add(newTask);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future completeTask(
      {required apiaryId, required taskId, String? comment}) async {
    try {
      Map<String, dynamic> data = {
        "comment": comment,
      };
      final response = await request(
        route: '/tasks/$apiaryId/$taskId',
        method: RequestMethods.patch,
        data: data,
      );
      var tasksLength = jsonDecode(response)["tasks"].length;
      var newTask = jsonDecode(response)["tasks"][tasksLength - 1];
      Task task = getById(apiaryId: apiaryId, taskId: taskId);
      task.status = newTask["status"];
      task.comment = newTask["comment"];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void clearCompletedTasks({required apiaryId}) {}
}
