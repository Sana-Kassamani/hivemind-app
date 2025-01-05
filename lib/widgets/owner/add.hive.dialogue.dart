import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';

class AddHive extends StatefulWidget {
  const AddHive({super.key});

  @override
  State<AddHive> createState() => _AddHiveState();
}

class _AddHiveState extends State<AddHive> {
  final _globalKey = GlobalKey<FormState>();
  var hiveLabel = "";
  var nbOfFrames;

  Future addHive(context) async {
    String apiaryId = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    final inputTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14);
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
      content: SizedBox(
        height: 300,
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("Hive Label")),
                style: inputTextStyle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Label field cannot be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    hiveLabel = value!;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Number Of Frames")),
                style: inputTextStyle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Number of frames field cannot be empty";
                  }
                  if (int.tryParse(value) == null || int.tryParse(value)! < 0) {
                    return "Invalid number of frames";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    nbOfFrames = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      buttonPadding: EdgeInsets.all(45),
      actions: [
        SizedBox(
          width: double.infinity,
          child: FilledBtn(
              text: "Add",
              onPress: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                }

                await addHive(context);
              }),
        ),
      ],
    );
  }
}
