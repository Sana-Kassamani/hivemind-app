import 'package:flutter/material.dart';
import 'package:hivemind_app/models/alert.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Alerts extends ChangeNotifier {
  List<Alert> alerts = [];
  bool allowed = false;

  bool get getPermission => allowed;

  Future setAllowAlerts(bool value) async {
    allowed = value;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('allowAlerts', value);
    notifyListeners();
  }

  void showAlerts({required message}) {
    print(message.title);
  }
}
