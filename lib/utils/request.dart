import 'dart:convert';
import 'dart:io';

import 'package:hivemind_app/utils/apiException.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:http/http.dart' as http;

Future request(
    {required String route,
    required RequestMethods method,
    Map<String, String>? data}) async {
  const baseURL = "http://192.168.0.100:8080";
  var response;

  try {
    //---------------------------------- GET ----------------------------------
    if (method == RequestMethods.get) {
      response = await http.get(
        Uri.parse("$baseURL$route"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    }

    //---------------------------------- POST ----------------------------------
    else if (method == RequestMethods.post) {
      response = await http.post(
        Uri.parse("$baseURL$route"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
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
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
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
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
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
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
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
