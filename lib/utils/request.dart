import 'dart:convert';
import 'dart:io';

import 'package:hivemind_app/utils/apiException.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future request(
    {required String route,
    required RequestMethods method,
    Map<String, dynamic>? data}) async {
  final baseURL = dotenv.env['URL'];
  var response;
  final prefs = await SharedPreferences.getInstance();
  final savedToken = prefs.getString('token');
  try {
    //---------------------------------- GET ----------------------------------
    if (method == RequestMethods.get) {
      response = await http.get(
        Uri.parse("$baseURL$route"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $savedToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }

    //---------------------------------- POST ----------------------------------
    else if (method == RequestMethods.post) {
      response = await http.post(
        Uri.parse("$baseURL$route"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $savedToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
    }

    //---------------------------------- PUT ----------------------------------
    else if (method == RequestMethods.put) {
      response = await http.put(
        Uri.parse("$baseURL$route"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $savedToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
    }

    //---------------------------------- PATCH ----------------------------------
    else if (method == RequestMethods.patch) {
      response = await http.patch(
        Uri.parse("$baseURL$route"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $savedToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
    }

    //---------------------------------- DELETE ----------------------------------
    else if (method == RequestMethods.delete) {
      response = await http.delete(
        Uri.parse("$baseURL$route"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $savedToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } else {
      throw ApiException("Non valid req");
    }
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    }
    throw (ApiException(jsonDecode(response.body)["message"]));
  } catch (error) {
    print("Error : ${error.toString()}");
    rethrow;
  }
}
