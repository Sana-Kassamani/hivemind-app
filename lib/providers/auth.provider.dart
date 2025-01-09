import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/models/user.model.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  late User? user;

  Future setDarkMode({required value}) async {
    int intValue = value ? 1 : 0;
    final response = await request(
      route: "/user-settings/darkmode/$intValue",
      method: RequestMethods.get,
    );
    user!.getSettings.darkmode = value;
    notifyListeners();
  }

  Future setAlerts({required value}) async {
    int intValue = value ? 1 : 0;
    final response = await request(
      route: "/user-settings/notifications/$intValue",
      method: RequestMethods.get,
    );
    user!.getSettings.alertsOn = value;
    notifyListeners();
  }

  void save({loggedUser}) {
    // set userType
    var userType = loggedUser["userType"];
    userType = UserTypes.isBeekeeper(userType)
        ? UserTypes.Beekeeper
        : (UserTypes.isOwner(userType) ? UserTypes.Owner : null);
    if (userType == null) {
      throw Exception("UserType not defined");
    }

    // set user settings
    final settings = UserSettings(
      darkmode: loggedUser["settings"]["darkMode"],
      alertsOn: loggedUser["settings"]["allowNotifications"],
    );

    //set user
    user = User(
      id: loggedUser["_id"],
      userType: userType,
      settings: settings,
    );
  }

  Future login({username, password}) async {
    final data = <String, dynamic>{"username": username, "password": password};
    try {
      final response = await request(
          route: "/auth", method: RequestMethods.post, data: data);

      // set token
      final token = jsonDecode(response)["token"];

      // Load and obtain the shared preferences for this app.
      final prefs = await SharedPreferences.getInstance();

      // Save the token value to persistent storage under the 'token' key.
      await prefs.setString('token', token);

      save(loggedUser: jsonDecode(response)["user"]);
      return jsonDecode(response);
    } catch (error) {
      rethrow;
    }
  }

  Future logout({required context}) async {
    // TODO logout from backend

    final prefs = await SharedPreferences.getInstance();

    // Remove the token value from persistent storage under the 'token' key.
    await prefs.remove('token');

    Provider.of<Apiaries>(context, listen: false).reset();
    Provider.of<Beekeepers>(context, listen: false).reset();
    Provider.of<Hives>(context, listen: false).reset();
    Provider.of<IotDetails>(context, listen: false).reset();
    Provider.of<Tasks>(context, listen: false).reset();
  }
}
