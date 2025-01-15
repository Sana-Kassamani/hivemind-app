import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:provider/provider.dart';

class AddHive extends StatefulWidget {
  const AddHive({super.key, required this.apiaryId});
  final apiaryId;
  @override
  State<AddHive> createState() => _AddHiveState();
}

class _AddHiveState extends State<AddHive> {
  final _globalKey = GlobalKey<FormState>();
  var hiveLabel = "";
  var nbOfFrames;
  var errorMessage = "";

  Future addHive(context) async {
    try {
      await Provider.of<Hives>(context, listen: false).addHive(
          context: context,
          hiveLabel: hiveLabel,
          numberOfFrames: nbOfFrames,
          apiaryId: widget.apiaryId);
      print("Hive added");
    } catch (error) {
      print(error.toString());
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

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
        "Add Hive",
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
                  decoration: InputDecoration(
                      label: Text(
                    "Hive Label",
                    style: inputTextStyle,
                  )),
                  style: inputTextStyle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Label field cannot be empty";
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
                      hiveLabel = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text(
                    "Number Of Frames",
                    style: inputTextStyle,
                  )),
                  style: inputTextStyle,
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Frames number field cannot be empty";
                    }
                    if (int.tryParse(value) == null ||
                        int.tryParse(value)! < 0) {
                      return "Invalid number of frames";
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
                      nbOfFrames = int.tryParse(value!)!;
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
            child: Text("Add"),
            onPressed: () async {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();
                print("pressed");
                await addHive(context);
                Navigator.pop(context);
              }
            }),
      ],
    );
  }
}
