import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/models/task.model.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';

class Tasks extends ChangeNotifier {
  Map<String, List<Task>> _tasks = {};
  Map<String, List<Task>> get tasks => _tasks;
  set tasks(Map<String, List<Task>> map) => _tasks = map;

  Task getById({apiaryId, taskId}) {
    Task task = _tasks[apiaryId]!.firstWhere((t) => t.id == taskId);
    return task;
  }

  List<Task> filterPendingTasks({required apiaryId}) {
    List<Task> list =
        _tasks[apiaryId]!.where((task) => task.status == "Pending").toList();
    return list;
  }

  void save({apiaryId, tasks, context}) {
    print(tasks);
    final currentUserId = Provider.of<Auth>(context, listen: false).user.getId;
    _tasks[apiaryId] = [];

    for (int i = 0; i < tasks.length; i++) {
      var task = tasks[i];
      if (!task["deleted"]) {
        // parse date of task to Jan 01, 2000 format
        String updatedDt = parseDate(date: task["date"]);

        List<Comment> comments = [];
        final savedComments = task["comments"];
        for (int j = 0; j < savedComments.length; j++) {
          var comment = savedComments[j];
          var name = "";
          if (comment["userId"]["_id"] == currentUserId) {
            name = "You";
          } else {
            name = comment["userId"]["username"];
          }

          final newComment = Comment(
            id: comment["_id"],
            content: comment["content"],
            userName: name,
            date: DateTime.parse(comment["date"]),
          );
          comments.insert(0, newComment);
        }
        final newTask = Task(
          id: task["_id"],
          title: task["title"],
          content: task["content"],
          status: task["status"],
          comments: comments,
          date: updatedDt,
        );

        _tasks[apiaryId]!.add(newTask);
        print("New task ${newTask.toString()}");
      }

      notifyListeners();
    }
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
        comments: [],
        date: updatedDt,
      );

      _tasks[apiaryId]!.add(newTask);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future completeTask({required apiaryId, required taskId}) async {
    try {
      Map<String, dynamic> data = {};
      final response = await request(
        route: '/tasks/$apiaryId/$taskId',
        method: RequestMethods.patch,
        data: data,
      );

      var updatedTask;
      for (var task in jsonDecode(response)["tasks"]) {
        if (task["_id"] == taskId) {
          updatedTask = task;
          break;
        }
      }
      Task task = getById(apiaryId: apiaryId, taskId: taskId);
      task.status = updatedTask["status"];

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future addComment(
      {required apiaryId, required taskId, required comment}) async {
    try {
      Map<String, dynamic> data = {"comment": comment};
      final response = await request(
        route: '/tasks/$apiaryId/$taskId',
        method: RequestMethods.put,
        data: data,
      );
      var updatedTask;
      for (var task in jsonDecode(response)["tasks"]) {
        if (task["_id"] == taskId) {
          updatedTask = task;
          break;
        }
      }

      var commentsLength = updatedTask["comments"].length;

      var newComment = updatedTask["comments"][commentsLength - 1];

      Task task = getById(apiaryId: apiaryId, taskId: taskId);

      var name = "You";

      final addedComment = Comment(
        id: newComment["_id"],
        content: newComment["content"],
        userName: name,
        date: DateTime.parse(newComment["date"]),
      );
      task.comments.insert(0, addedComment);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void clearCompletedTasks({required apiaryId}) async {
    try {
      Map<String, dynamic> data = {};
      final response = await request(
        route: '/tasks/$apiaryId',
        method: RequestMethods.delete,
        data: data,
      );

      List<Task> tasks = filterPendingTasks(apiaryId: apiaryId);
      _tasks[apiaryId] = tasks;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void reset() {
    _tasks = {};
    notifyListeners();
  }
}
