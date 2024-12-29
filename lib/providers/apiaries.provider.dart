import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiary.provider.dart';
import 'package:hivemind_app/providers/hive.provider.dart';

class Apiaries extends ChangeNotifier {
  final List<Apiary> _apiaries = [
    Apiary("001", "Apiary 1", "Barouk Cedars", "Yehya", [
      Hive("002", "Hive 1", 12, false, "0 harvests", []),
      Hive("003", "Hive 2", 10, false, "0 harvests", []),
      Hive("004", "Hive 3", 7, false, "0 harvests", []),
      Hive("005", "Hive 4", 8, false, "0 harvests", []),
    ]),
    Apiary("002", "Apiary 2", "Barouk Cedars", "Hatem", [
      Hive("001", "hive Label 1", 10, false, "0 harvests", []),
      Hive("002", "hive Label 2", 10, false, "0 harvests", []),
      Hive("003", "hive Label 3", 10, false, "0 harvests", []),
    ]),
    Apiary("003", "Apiary 3", "Barouk Cedars", "Seri", [
      Hive("001", "Hive #1", 12, false, "0 harvests", []),
    ]),
    Apiary("004", "Apiary 4", "Barouk Cedars", "Nour", []),
  ];

  List<Apiary> get apiariesList => _apiaries;
}
