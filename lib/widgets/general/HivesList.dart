import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/models/hive.model.dart';
import 'package:hivemind_app/pages/beekeeper/HivePage.dart';
import 'package:hivemind_app/pages/owner/HivePage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:hivemind_app/widgets/owner/alert.dialogue.dart';
import 'package:provider/provider.dart';

class HivesList extends StatefulWidget {
  const HivesList({super.key, required this.apiaryId});
  final String apiaryId;
  String get getApiary => apiaryId;
  @override
  State<HivesList> createState() => _HivesListState();
}

class _HivesListState extends State<HivesList> {
  Future deleteHive(context, apiaryId, hiveId) async {
    try {
      print("in delete");
      await Provider.of<Hives>(context, listen: false)
          .deleteHive(context: context, apiaryId: apiaryId, hiveId: hiveId);
      print("hive deleted");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete Hive failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userType =
        Provider.of<Auth>(context, listen: false).user?.getUserType;
    final apiaryId = widget.apiaryId;
    return Expanded(
      child: Consumer<Hives>(
        builder: (BuildContext context, Hives value, Widget? child) {
          List<Hive>? hives = value.hives[apiaryId];
          return hives!.isEmpty
              ? EmptyState(context: context)
              : ListView.builder(
                  itemCount: hives.length,
                  itemBuilder: (context, index) {
                    return userType == UserTypes.Owner
                        ? Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    outlinedButtonTheme:
                                        const OutlinedButtonThemeData(
                                      style: ButtonStyle(
                                        iconColor: WidgetStatePropertyAll(
                                            Colors.white),
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
                                                item: "hive",
                                                onPressDelete: (context) =>
                                                    deleteHive(
                                                        context,
                                                        apiaryId,
                                                        hives[index].getId),
                                              );
                                            });
                                      }),
                                ),
                              ],
                            ),
                            child: ListItem(
                              data: hives[index],
                              icon: "assets/icons/hive_icon.png",
                              onPress: () {
                                Navigator.pushNamed(
                                  context,
                                  "/hiveOwner",
                                  arguments: {
                                    "hiveId": hives[index].getId,
                                    "apiaryId": apiaryId
                                  },
                                );
                              },
                            ),
                          )
                        : ListItem(
                            data: hives[index],
                            icon: "assets/icons/hive_icon.png",
                            onPress: () {
                              Navigator.pushNamed(
                                context,
                                "/hiveBeekeeper",
                                arguments: {
                                  "hiveId": hives[index].getId,
                                  "apiaryId": apiaryId
                                },
                              );
                            },
                          );
                  });
        },
      ),
    );
  }
}
