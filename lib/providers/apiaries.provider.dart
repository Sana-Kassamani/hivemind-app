import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiary.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hive.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Apiaries extends ChangeNotifier {
  final List<Apiary> _apiaries = [];

  List<Apiary> get apiariesList => _apiaries;

  Future loadApiaries(beekeepers) async {
    try {
      final response =
          await request(route: "/apiaries/owner", method: RequestMethods.get);
      print(jsonDecode(response)["apiaries"]);
      saveApiaries(beekeepers, jsonDecode(response)["apiaries"]);
    } catch (error) {
      rethrow;
    }
  }

  List<Hive> saveHives(hives) {
    List<Hive> hiveList = [];

    notifyListeners();
    return hiveList;
  }

  void saveApiaries(beekeepers, apiaries) {
    for (int i = 0; i < apiaries.length; i++) {
      var apiary = apiaries[i];
      String beekeeperName = beekeepers
          .firstWhere((b) => b.getassignedApiaryId() == apiary["_id"])
          .getUsername();
      List<Hive> hiveList = saveHives(apiary["hives"]);
      final newApiary = Apiary(
          id: apiary["_id"],
          label: apiary["label"],
          location: apiary["location"],
          beekeeperName: beekeeperName,
          hives: hiveList);
      _apiaries.add(newApiary);
    }
    print("Hey");
    notifyListeners();
  }
}
