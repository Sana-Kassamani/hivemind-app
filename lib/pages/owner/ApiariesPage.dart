import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hivemind_app/pages/Owner/ApiaryPage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:hivemind_app/widgets/owner/add.apiary.dialogue.dart';
import 'package:hivemind_app/widgets/owner/alert.dialogue.dart';
import 'package:provider/provider.dart';

class ApiariesPage extends StatefulWidget {
  const ApiariesPage({super.key});

  @override
  State<ApiariesPage> createState() => _ApiariesPageState();
}

class _ApiariesPageState extends State<ApiariesPage> {
  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AddApiary();
        });
  }

  Future deleteApiary(context, apiaryId) async {
    try {
      print("in delete");
      await Provider.of<Apiaries>(context, listen: false)
          .deleteApiary(context: context, apiaryId: apiaryId);
      print("apiary deleted");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete Apiary failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Apiaries"),
      ),
      body: Column(
        children: [
          addVerticalSpace(24),
          Expanded(
            child: Consumer<Apiaries>(
              builder: (BuildContext context, Apiaries value, Widget? child) {
                return value.apiariesList.isEmpty
                    ? EmptyState(context: context)
                    : ListView.builder(
                        itemCount: value.apiariesList.length,
                        itemBuilder: (context, index) => Slidable(
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  outlinedButtonTheme:
                                      const OutlinedButtonThemeData(
                                    style: ButtonStyle(
                                      iconColor:
                                          WidgetStatePropertyAll(Colors.white),
                                    ),
                                  ),
                                ),
                                child: SlidableAction(
                                    icon: Icons.delete,
                                    backgroundColor: Colors.red,
                                    onPressed: (context) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DeleteDialogue(
                                              item: "apiary",
                                              onPressDelete: () => deleteApiary(
                                                  context,
                                                  value.apiariesList[index]
                                                      .getId()),
                                            );
                                          });
                                    }),
                              ),
                            ],
                          ),
                          child: ListItem(
                            data: value.apiariesList[index],
                            icon: "assets/icons/apiary_icon.png",
                            onPress: () {
                              Navigator.pushNamed(
                                context,
                                "/apiary",
                                arguments: value.apiariesList[index].getId(),
                              );
                            },
                          ),
                        ),
                      );
              },
            ),
          ),
          FilledBtn(
            text: "Add a New Apiary",
            icon: Icon(Icons.add),
            onPress: _showDialog,
          ),
        ],
      ),
      // bottomNavigationBar: NavbarOwner(),
    );
  }
}
