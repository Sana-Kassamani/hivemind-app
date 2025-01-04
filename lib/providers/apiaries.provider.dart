import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';

class Apiaries extends ChangeNotifier {
  List<Apiary> _apiaries = [];
  late Apiary apiary;

  List<Apiary> get apiariesList => _apiaries;
  void setApiariesList(apiaries) => _apiaries = apiaries;

  // Future loadApiary({context, apiaryId}) async {
  //   try {
  //     final response =
  //         await request(route: "/apiaries/owner", method: RequestMethods.get);

  //     saveApiary(apiary: jsonDecode(response)["apiaries"], context: context);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future loadApiaries({context}) async {
  //   try {
  //     final response =
  //         await request(route: "/apiaries/owner", method: RequestMethods.get);

  //     saveApiaries(
  //         apiaries: jsonDecode(response)["apiaries"], context: context);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  void saveApiaries({context, apiaries}) {
    for (int i = 0; i < apiaries.length; i++) {
      var apiary = apiaries[i];
      Provider.of<Hives>(context, listen: false).save(
          context: context, apiaryId: apiary["_id"], hives: apiary["hives"]);
      Provider.of<Tasks>(context, listen: false)
          .save(apiaryId: apiary["_id"], tasks: apiary["tasks"]);
      String username = Provider.of<Beekeepers>(context, listen: false)
          .findByAssignedApiary(id: apiary["_id"]);

      final newApiary = Apiary(
        id: apiary["_id"],
        label: apiary["label"],
        location: apiary["location"],
        beekeeperName: username,
      );
      _apiaries.add(newApiary);
    }

    notifyListeners();
  }

  void saveApiary({context, apiary}) {
    Provider.of<Hives>(context, listen: false).save(
        context: context, apiaryId: apiary["_id"], hives: apiary["hives"]);
    Provider.of<Tasks>(context, listen: false)
        .save(apiaryId: apiary["_id"], tasks: apiary["tasks"]);

    final newApiary = Apiary(
      id: apiary["_id"],
      label: apiary["label"],
      location: apiary["location"],
      beekeeperName: null,
    );
    apiary = newApiary;
    notifyListeners();
  }
}
