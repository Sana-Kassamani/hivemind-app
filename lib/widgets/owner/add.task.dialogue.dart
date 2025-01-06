import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, required this.apiaryId});
  final apiaryId;
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _globalKey = GlobalKey<FormState>();
  var title = "";
  var nbOfFrames;
  var errorMessage = "";

  @override
  Widget build(BuildContext context) {
    final inputTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14);
    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: ColorManager.SCAFFOLD_BG,
      title: Text(
        "Add Task",
        textAlign: TextAlign.center,
      ),
      content: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: _globalKey,
            child: Column(
              spacing: 20,
              children: [
                TextFormField(
                  decoration: InputDecoration(label: Text("Task Title")),
                  style: inputTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title field cannot be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      errorMessage = "";
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      title = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          errorMessage == ""
              ? SizedBox.shrink()
              : SizedBox(
                  child: Text(
                    errorMessage,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
        ],
      ),
      buttonPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      actions: [
        FilledBtn(
            text: "Add",
            onPress: () async {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();
                print("pressed");
                // await (context);
              }
            }),
      ],
    );
  }
}
