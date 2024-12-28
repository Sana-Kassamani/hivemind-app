import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';

class TaskExpansionTileOwner extends StatelessWidget {
  const TaskExpansionTileOwner({super.key, required this.task});

  final task;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      leading: task["status"] == "Pending"
          ? iconBox(
              Icons.circle_outlined, Theme.of(context).colorScheme.secondary)
          : iconBox(
              Icons.check_circle, Theme.of(context).colorScheme.secondary),
      title: Text(
        task["title"]!,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: Text(
        task["date"]!,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        ExpandedTileOwner(task: task),
      ],
    );
  }
}

class ExpandedTileOwner extends StatelessWidget {
  const ExpandedTileOwner({super.key, required this.task});
  final task;
  @override
  Widget build(BuildContext context) {
    return task["status"] == "Pending"
        ? Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Status: ${task["status"]!}",
                  style: Theme.of(context).textTheme.labelMedium),
              Text(
                task["content"]!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          )
        : Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Status: ${task["status"]!}",
                  style: Theme.of(context).textTheme.labelMedium),
              Text(
                task["content"]!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                "Comment: ${task["comment"]}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          );
  }
}

class TaskExpansionTileBeekeeper extends StatelessWidget {
  const TaskExpansionTileBeekeeper({super.key, required this.task});

  final task;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      leading: IconButton(
        onPressed: () {},
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
        task["title"]!,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: Text(
        task["date"]!,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      children: [
        // ExpandedTileBeekeeper(task: task),
      ],
    );
  }
}
