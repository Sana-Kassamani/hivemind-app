import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class AddDialogue extends StatefulWidget {
  const AddDialogue({super.key});

  @override
  State<AddDialogue> createState() => _AddDialogueState();
}

class _AddDialogueState extends State<AddDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: ColorManager.SCAFFOLD_BG,
      title: Text(
        "Add Apiary",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(height: 300, child: Center()),
      buttonPadding: EdgeInsets.all(45),
      actions: [],
    );
  }
}
