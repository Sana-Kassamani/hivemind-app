import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';

class HivesList extends StatefulWidget {
  const HivesList({super.key, required this.apiaryId});
  final String apiaryId;
  String get getApiary => apiaryId;
  @override
  State<HivesList> createState() => _HivesListState();
}

class _HivesListState extends State<HivesList> {
  @override
  Widget build(BuildContext context) {
    final userType = Provider.of<Auth>(context, listen: false).user.getUserType;
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
                    return ListItem(
                      data: hives[index],
                      icon: "assets/icons/hive_icon.png",
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userType == UserTypes.Owner
                                ? HivePageOwner()
                                : HivePageBeekeeper(),
                            settings: RouteSettings(
                              arguments: {
                                "hiveId": hives[index].getId,
                                "apiaryId": apiaryId
                              },
                            ),
                          ),
                        );
                      },
                    );
                  });
        },
      ),
    );
  }
}
