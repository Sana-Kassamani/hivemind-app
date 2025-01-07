import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/utils/colors.dart';
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
      backgroundColor: ColorManager.SCAFFOLD_BG,
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
            await onPressDelete();
            Navigator.pop(context);
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}

class CompleteTaskDialogue extends StatelessWidget {
  const CompleteTaskDialogue(
      {super.key, required this.comment, required this.onPressComplete});
  final comment;
  final onPressComplete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: ColorManager.SCAFFOLD_BG,
      icon: Icon(
        Icons.warning,
        size: 40,
      ),
      content: Text(
          "Are you sure you want to complete this task having this comment: ${comment ?? "_empty_"}?"),
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
    return AlertDialog();
  }
}
