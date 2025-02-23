import 'package:flutter/material.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:provider/provider.dart';

class DeleteDialogue extends StatelessWidget {
  const DeleteDialogue(
      {super.key, required this.item, required this.onPressDelete});

  final item;
  final onPressDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      icon: Icon(
        Icons.warning,
        size: 40,
      ),
      content: Text("Are you sure you want to permanently delete this $item?"),
      buttonPadding: EdgeInsets.all(20),
      actions: [
        FilledButton(
          style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(100, 40)),
              backgroundColor: WidgetStatePropertyAll(Colors.grey[200])),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        FilledButton(
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(100, 40)),
          ),
          onPressed: () async {
            await onPressDelete(context);
            navigatorKey.currentState?.pop();
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}

class CompleteTaskDialogue extends StatelessWidget {
  const CompleteTaskDialogue({super.key, required this.onPressComplete});
  final onPressComplete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      icon: Icon(
        Icons.warning,
        size: 40,
      ),
      content: Text("Are you sure you want to complete this task?"),
      buttonPadding: EdgeInsets.all(20),
      actions: [
        FilledButton(
          style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(100, 40)),
              backgroundColor: WidgetStatePropertyAll(Colors.grey[200])),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        FilledButton(
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(100, 40)),
          ),
          onPressed: () async {
            await onPressComplete();
            Navigator.pop(context);
          },
          child: Text("Complete"),
        ),
      ],
    );
  }
}

class LogoutDialogue extends StatelessWidget {
  const LogoutDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      icon: Icon(
        Icons.warning,
        size: 40,
      ),
      content: Text("Are you sure you want to logout?"),
      buttonPadding: EdgeInsets.all(20),
      actions: [
        FilledButton(
          style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(100, 40)),
              backgroundColor: WidgetStatePropertyAll(Colors.grey[200])),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        FilledButton(
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(100, 40)),
          ),
          onPressed: () async {
            await Provider.of<Auth>(context, listen: false)
                .logout(context: context);
            // Remove all previous routes
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/login",
              (Route<dynamic> route) => false,
            );
          },
          child: Text("Logout"),
        ),
      ],
    );
  }
}
