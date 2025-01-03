import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiary.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hive.provider.dart';
import 'package:hivemind_app/providers/user.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Apiaries extends ChangeNotifier {
  List<Apiary> _apiaries = [];

  List<Apiary> get apiariesList => _apiaries;
  void setApiariesList(apiaries) => _apiaries = apiaries;

  Future loadApiaries(context) async {
    try {
      final response =
          await request(route: "/apiaries/owner", method: RequestMethods.get);
      print(jsonDecode(response)["apiaries"]);
      setApiariesList(Provider.of<Apiary>(context, listen: false)
          .save(context: context, apiaries: jsonDecode(response)["apiaries"]));
    } catch (error) {
      rethrow;
    }
  }

  void saveApiaries({context, apiaries}) {}
}
