import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';

class User extends ChangeNotifier {
  final String id;
  final UserTypes userType;
  final UserSettings settings;

  User({
    required this.id,
    required this.userType,
    required this.settings,
  });
  String getId() => id;
  UserTypes getUserType() => userType;
  UserSettings getSettings() => settings;
}

class UserSettings {
  bool darkmode;
  bool alertsOn;
  UserSettings({
    required this.darkmode,
    required this.alertsOn,
  });
  bool getIsDark() => darkmode;
  bool getIsOnAlerts() => alertsOn;
  void setDark(bool state) => darkmode = state;
  void setAlertsSetting(bool state) => alertsOn = state;
}

class Beekeeper {
  final String id;
  final String username;
  final String? assignedApiaryId;
  Beekeeper(
      {required this.id,
      required this.username,
      required this.assignedApiaryId});
  String getId() => id;
  String getUsername() => username;
  String? getassignedApiaryId() => assignedApiaryId;
}
