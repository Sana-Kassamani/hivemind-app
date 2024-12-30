import 'dart:convert';
import 'dart:io';

import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:http/http.dart' as http;

Future request(
    {required String route,
    required RequestMethods method,
    Map<String, String>? data}) async {
  const baseURL = "http://192.168.0.100:8080";

  //---------------------------------- GET ----------------------------------
  if (method == RequestMethods.get) {
    final response = await http.get(
      Uri.parse("$baseURL$route"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response.body;
  }

  //---------------------------------- POST ----------------------------------
  if (method == RequestMethods.post) {
    final response = await http.post(
      Uri.parse("$baseURL$route"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response.body;
  }

  //---------------------------------- PUT ----------------------------------
  if (method == RequestMethods.put) {
    final response = await http.put(
      Uri.parse("$baseURL$route"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response.body;
  }

  //---------------------------------- PATCH ----------------------------------
  if (method == RequestMethods.patch) {
    final response = await http.patch(
      Uri.parse("$baseURL$route"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response.body;
  }

  //---------------------------------- DELETE ----------------------------------
  if (method == RequestMethods.delete) {
    final response = await http.delete(
      Uri.parse("$baseURL$route"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    return response.body;
  }
}
