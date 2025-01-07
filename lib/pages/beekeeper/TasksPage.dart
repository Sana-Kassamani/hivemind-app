import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/general/TasksList.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
      ),
      body: Consumer<Apiaries>(
          builder: (BuildContext context, Apiaries apiaryValue, Widget? child) {
        return Consumer<Tasks>(
            builder: (BuildContext context, Tasks value, Widget? child) {
          return apiaryValue.apiary == null ||
                  value
                      .filterPendingTasks(apiaryId: apiaryValue.apiary!.getId())
                      .isEmpty
              ? EmptyState(context: context)
              : Column(
                  children: [
                    addVerticalSpace(24),
                    TasksListBeekeeper(
                        tasks: value.filterPendingTasks(
                            apiaryId: apiaryValue.apiary!.getId())),
                  ],
                );
        });
      }),
    );
  }
}
