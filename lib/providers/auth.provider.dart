import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/user.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  late User user;
  Future login(String username, String password) async {
    final data = <String, String>{"username": username, "password": password};
    try {
      final response = await request(
          route: "/auth", method: RequestMethods.post, data: data);
      final token = jsonDecode(response)["token"];
      var userType = jsonDecode(response)["user"]["userType"];
      if (userType == "Beekeeper")
        userType = UserTypes.beekeeper;
      else if (userType == "Owner")
        userType = UserTypes.owner;
      else {
        userType = null;
        throw Exception("UserType not defined");
      }
      final settings = UserSettings(
        jsonDecode(response)["user"]["settings"]["darkMode"],
        jsonDecode(response)["user"]["settings"]["allowNotifications"],
      );
      user = User(jsonDecode(response)["user"]["_id"], userType, settings);

      // Load and obtain the shared preferences for this app.
      final prefs = await SharedPreferences.getInstance();

      // Save the token value to persistent storage under the 'token' key.
      await prefs.setString('token', token);
      print("user is: ");
      print(user.getId());
      print(user.getUserType());
      print("User settings");
      print(user.getSettings().getIsDark());
      print(user.getSettings().getIsOnAlerts());
      final savedToken = prefs.getString('token') ?? 0;
      print(savedToken);
    } catch (error) {
      rethrow;
    }
  }
}
