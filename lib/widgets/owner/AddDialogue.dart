import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';

Widget AddDialogue(context, title, form) => AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: ColorManager.SCAFFOLD_BG,
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  label: Text("Apiary Label",
                      style: Theme.of(context).textTheme.bodyMedium)),
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
      buttonPadding: EdgeInsets.all(45),
      actions: [
        SizedBox(
          width: double.infinity,
          child: FilledBtn(text: "Add", onPress: () {}),
        ),
      ],
    );
