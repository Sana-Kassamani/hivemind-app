import 'package:flutter/material.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/pages/beekeeper/HivePage.dart';
import 'package:hivemind_app/pages/owner/HivePage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/hive.provider.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';
import 'package:provider/provider.dart';

import '../../providers/apiary.provider.dart';

class HivesList extends StatefulWidget {
  const HivesList({super.key});

  @override
  State<HivesList> createState() => _HivesListState();
}

class _HivesListState extends State<HivesList> {
  final isOwner = ISOWNER;
  final List<Map<String, String>> hives = [
    {"label": "Hive #1"},
    {"label": "Hive #2"},
    {"label": "Hive #3"},
    {"label": "Hive #4"},
  ];

  @override
  Widget build(BuildContext context) {
    String? apiaryId = ModalRoute.of(context)?.settings.arguments as String?;

    print(apiaryId);
    return Expanded(
      child: Consumer<Apiaries>(
        builder: (BuildContext context, Apiaries value, Widget? child) {
          List<Hive> hives =
              value.apiariesList.firstWhere((a) => a.getId() == apiaryId).hives;
          return ListView.builder(
              itemCount: hives.length,
              itemBuilder: (context, index) {
                return ListItem(
                  data: hives[index],
                  icon: "assets/icons/hive_icon.png",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              isOwner ? HivePageOwner() : HivePageBeekeeper()),
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
