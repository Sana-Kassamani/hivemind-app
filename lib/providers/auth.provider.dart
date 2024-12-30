import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  Future login(String username, String password) async {
    final data = <String, String>{"username": username, "password": password};
    try {
      final response = await request(
          route: "/auth", method: RequestMethods.post, data: data);

      print(jsonDecode(response)["user"]["userType"]);
      print(jsonDecode(response)["token"]);
    } catch (error) {
      rethrow;
    }
  }
}
