import 'package:hivemind_app/utils/enums/UserTypes.dart';

class User {
  final String id;
  final UserTypes userType;
  final UserSettings settings;

  User({
    required this.id,
    required this.userType,
    required this.settings,
  });
  String get getId => id;
  UserTypes get getUserType => userType;
  UserSettings get getSettings => settings;
}

class UserSettings {
  bool darkmode;
  bool alertsOn;
  UserSettings({
    required this.darkmode,
    required this.alertsOn,
  });
  bool get getIsDark => darkmode;
  bool get getIsOnAlerts => alertsOn;
  set setDark(bool state) => darkmode = state;
  set setAlertsSetting(bool state) => alertsOn = state;
}

class Beekeeper {
  final String id;
  final String username;
  final String? assignedApiaryId;
  Beekeeper(
      {required this.id,
      required this.username,
      required this.assignedApiaryId});
  String get getId => id;
  String get getUsername => username;
  String? get getassignedApiaryId => assignedApiaryId;
}
