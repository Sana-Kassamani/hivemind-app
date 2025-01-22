import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/models/user.model.dart';
import 'package:hivemind_app/providers/alerts.provider.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/providers/theme.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';
import 'package:hivemind_app/utils/notifications/firebase.api.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  late User user;

  Future setDarkMode({required value, context}) async {
    int intValue = value ? 1 : 0;
    final response = await request(
      route: "/user-settings/darkmode/$intValue",
      method: RequestMethods.get,
    );
    user.getSettings.darkmode = value;
    if (value) {
      Provider.of<ThemeProvider>(context, listen: false).setDark();
    } else {
      Provider.of<ThemeProvider>(context, listen: false).setLight();
    }
    notifyListeners();
  }

  Future setAlerts({required value, required context}) async {
    int intValue = value ? 1 : 0;
    final response = await request(
      route: "/user-settings/notifications/$intValue",
      method: RequestMethods.get,
    );
    user.getSettings.alertsOn = value;
    await Provider.of<Alerts>(context, listen: false).setAllowAlerts(value);
    notifyListeners();
  }

  Future save({loggedUser, context}) async {
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
    if (settings.darkmode) {
      Provider.of<ThemeProvider>(context, listen: false).setDark();
    } else {
      Provider.of<ThemeProvider>(context, listen: false).setLight();
    }

    await Provider.of<Alerts>(context, listen: false)
        .setAllowAlerts(settings.alertsOn);
    //set user
    user = User(
      id: loggedUser["_id"],
      userType: userType,
      settings: settings,
    );
    print(loggedUser["notifications"]);
    Provider.of<Alerts>(context, listen: false)
        .save(alerts: loggedUser["notifications"]);
  }

  Future login({username, password, context}) async {
    try {
      final deviceId = await FirebaseApi.instance.getToken();
      final data = <String, dynamic>{
        "username": username,
        "password": password,
        "deviceId": deviceId
      };
      final response = await request(
          route: "/auth", method: RequestMethods.post, data: data);

      // set token
      final token = jsonDecode(response)["token"];

      // Load and obtain the shared preferences for this app.
      final prefs = await SharedPreferences.getInstance();

      // Save the token value to persistent storage under the 'token' key.
      await prefs.setString('token', token);

      await save(loggedUser: jsonDecode(response)["user"], context: context);

      return jsonDecode(response);
    } catch (error) {
      rethrow;
    }
  }

  Future signup({username, email, password, context}) async {
    try {
      final deviceId = await FirebaseApi.instance.getToken();

      final data = <String, dynamic>{
        "username": username,
        "password": password,
        "email": email,
        "deviceId": deviceId
      };
      print(data);
      print("Hello 2");
      final response = await request(
          route: "/auth/signup", method: RequestMethods.post, data: data);
      print("Hello 3");
      // set token
      final token = jsonDecode(response)["token"];

      // Load and obtain the shared preferences for this app.
      final prefs = await SharedPreferences.getInstance();

      // Save the token value to persistent storage under the 'token' key.
      await prefs.setString('token', token);

      await save(loggedUser: jsonDecode(response)["user"], context: context);

      return jsonDecode(response);
    } catch (error) {
      rethrow;
    }
  }

  Future logout({required context}) async {
    // TODO logout from backend

    final prefs = await SharedPreferences.getInstance();

    // Remove the token value from persistent storage under the 'token' key.
    await prefs.clear();

    Provider.of<Apiaries>(context, listen: false).reset();
    Provider.of<Beekeepers>(context, listen: false).reset();
    Provider.of<Hives>(context, listen: false).reset();
    Provider.of<IotDetails>(context, listen: false).reset();
    Provider.of<Tasks>(context, listen: false).reset();
    Provider.of<Alerts>(context, listen: false).reset();
  }
}
