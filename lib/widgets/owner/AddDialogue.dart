import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/placesPage.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:provider/provider.dart';

Widget AddDialogue(context, title, form) {
  final inputTextStyle =
      Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14);
  return AlertDialog(
    insetPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
    actionsAlignment: MainAxisAlignment.center,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    titleTextStyle: Theme.of(context).textTheme.titleLarge,
    backgroundColor: ColorManager.SCAFFOLD_BG,
    title: Text(
      title,
      textAlign: TextAlign.center,
    ),
    content: SizedBox(height: 300, child: addApiary(context, inputTextStyle)),
    buttonPadding: EdgeInsets.all(45),
    actions: [
      SizedBox(
        width: double.infinity,
        child: FilledBtn(
            text: "Add",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GoogleMapSearchPlacesApi()),
              );
            }),
      ),
    ],
  );
}

Widget addApiary(context, inputTextStyle) {
  final _globalKey = GlobalKey<FormState>();
  List<String> _kOptions = ["apple", "banana", "cherries"];
  return Form(
    key: _globalKey,
    child: Column(
      children: [
        TextField(
          decoration: InputDecoration(label: Text("Apiary Label")),
          style: inputTextStyle,
        ),
        Consumer<Beekeepers>(
            builder: (BuildContext context, Beekeepers value, Widget? child) {
          return DropdownButtonFormField(
            decoration: InputDecoration(label: Text("Beekeeper Name")),
            items: value.beekeepersList.map((b) {
              bool free = b.assignedApiaryId == null ? true : false;
              return DropdownMenuItem(
                enabled: free,
                value: b.getId,
                child: Text(
                  b.getUsername,
                  style: free
                      ? inputTextStyle.copyWith(
                          color: ColorManager.COLOR_SECONDARY)
                      : inputTextStyle.copyWith(color: Colors.grey),
                ),
              );
            }).toList(),
            onChanged: (value) {
              print(value);
            },
          );
        }),
      ],
    ),
  );
}
