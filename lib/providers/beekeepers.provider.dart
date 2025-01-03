import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/user.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';

class Beekeepers extends ChangeNotifier {
  List<Beekeeper> _beekeepersList = [];

  List<Beekeeper> get beekeepersList => _beekeepersList;

  Future loadBeekeepers() async {
    try {
      final response =
          await request(route: "/users/beekeepers", method: RequestMethods.get);
      print(jsonDecode(response).toString());
      print(jsonDecode(response)[0].toString());
      this.saveBeekeepers(jsonDecode(response));
    } catch (error) {
      rethrow;
    }
  }

  void saveBeekeepers(beekeepers) {}
}
