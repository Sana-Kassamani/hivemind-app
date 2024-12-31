import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';

class User extends ChangeNotifier {
  final String _id;
  final UserTypes _userType;
  final UserSettings _settings;

  User(
    this._id,
    this._userType,
    this._settings,
  );
  String getId() => _id;
  UserTypes getUserType() => _userType;
  UserSettings getSettings() => _settings;
}

class UserSettings {
  bool _darkmode;
  bool _alertsOn;
  UserSettings(
    this._darkmode,
    this._alertsOn,
  );
  bool getIsDark() => _darkmode;
  bool getIsOnAlerts() => _alertsOn;
  void setDark(bool state) => _darkmode = state;
  void setAlertsSetting(bool state) => _alertsOn = state;
}
