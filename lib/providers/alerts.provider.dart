import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/models/alert.model.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Alerts extends ChangeNotifier {
  List<Alert> _alerts = [];
  List<Alert> get alerts => _alerts;
  bool allowed = false;

  bool get getPermission => allowed;

  Future setAllowAlerts(bool value) async {
    allowed = value;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('allowAlerts', value);
    notifyListeners();
  }

  void save({required alerts}) {
    for (int i = 0; i < alerts.length; i++) {
      var alert = alerts[i];

      final newAlert = Alert(
        id: alert["_id"],
        title: alert["title"],
        message: alert["message"],
        time: DateTime.parse(alert["time"]),
      );

      _alerts.insert(0, newAlert);
    }
    notifyListeners();
  }

  void add({message}) {
    print(
        "-------------------------------------------In Provider----------------------------------------");
    print(message.notification?.title);
    print(message.notification?.body);
    print(message?.data["time"]);
    String? time = message?.data["time"];
    if (time != null) {
      int timestamp = int.parse(message?.data["time"]);
      // Convert the timestamp to a DateTime object
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      print(dateTime);
      final newAlert = Alert(
        id: message["_id"],
        title: message.notification?.title,
        message: message.notification?.body,
        time: message["time"],
      );
      print("hey  $newAlert");
      _alerts.add(newAlert);
      notifyListeners();
    }
  }

  Future markRead({context}) async {
    final userId = Provider.of<Auth>(context, listen: false).user.getId;
    try {
      // List<String> alertIds = [];
      // for (var alert in alerts) {
      //   print(alert.id);
      //   alertIds.add(alert.id);
      // }
      // Map<String, String> data = {"id": alertIds.toString()};
      Map<String, dynamic> data = {};
      final response = await request(
        route: '/notifications/$userId',
        method: RequestMethods.patch,
        data: data,
      );

      _alerts = [];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void showAlerts({required message}) {
    print(
        "-------------------------------------------In Provider----------------------------------------");
    print(message.notification?.title);
    print(message.notification?.body);
    print(message?.data["time"]);
    String? time = message?.data["time"];
    if (time != null) {
      int timestamp = int.parse(message?.data["time"]);
      // Convert the timestamp to a DateTime object
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      print(dateTime);
    }
  }

  void reset() {
    _alerts = [];
    notifyListeners();
  }
}
