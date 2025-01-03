import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/providers/user.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  late User user;
  Future login(String username, String password) async {
    final data = <String, String>{"username": username, "password": password};
    try {
      final response = await request(
          route: "/auth", method: RequestMethods.post, data: data);

      // set token
      final token = jsonDecode(response)["token"];

      // Load and obtain the shared preferences for this app.
      final prefs = await SharedPreferences.getInstance();

      // Save the token value to persistent storage under the 'token' key.
      await prefs.setString('token', token);

      var loggedUser = jsonDecode(response)["user"];

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
    } catch (error) {
      rethrow;
    }
  }
}
