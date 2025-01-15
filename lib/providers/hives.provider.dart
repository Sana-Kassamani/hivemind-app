import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/models/hive.model.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';

class Hives extends ChangeNotifier {
  Map<String, List<Hive>> _hives = {};
  Map<String, List<Hive>> get hives => _hives;
  set hives(Map<String, List<Hive>> map) => hives = map;

  int getHivesCount() {
    int count = _hives.values.fold(0, (sum, list) => sum + list.length);
    return count;
  }

  Hive getById({apiaryId, hiveId}) {
    Hive hive = _hives[apiaryId]!.firstWhere((a) => a.id == hiveId);
    return hive;
  }

  void save({apiaryId, context, hives}) {
    _hives[apiaryId] = [];

    for (int i = 0; i < hives.length; i++) {
      var hive = hives[i];

      String updatedDt;
      // parse lastHarvestDate of Hive to Jan 01, 2000 format
      if (hive.containsKey('lastHarvestDate')) {
        updatedDt = parseDate(date: hive["lastHarvestDate"]);
      } else {
        updatedDt = "No harvest yet";
      }

      List<String> diseases = [];
      for (int j = 0; j < hive["diseases"].length; j++) {
        diseases.add(hive["diseases"][j]);
      }

      Provider.of<IotDetails>(context, listen: false)
          .save(hiveId: hive["_id"], iotDetails: hive["iotDetails"]);

      final newHive = Hive(
        id: hive["_id"],
        label: hive["label"],
        numberOfFrames: hive["nbOfFrames"],
        harvestStatus: hive["harvestStatus"],
        lastHarvestDate: updatedDt,
        diseases: diseases,
      );

      _hives[apiaryId]!.add(newHive);
      print("New hive ${newHive.toString()}");
    }
    notifyListeners();
  }

  Future addHive({
    context,
    apiaryId,
    hiveLabel,
    numberOfFrames,
  }) async {
    Map<String, dynamic> data = {
      "label": hiveLabel,
      "nbOfFrames": numberOfFrames
    };
    try {
      final response = await request(
        route: '/hives/$apiaryId',
        method: RequestMethods.post,
        data: data,
      );
      var hivesLength = jsonDecode(response)["hives"].length;
      var hive = jsonDecode(response)["hives"][hivesLength - 1];
      Hive newHive = Hive(
          id: hive["_id"],
          label: hiveLabel,
          numberOfFrames: numberOfFrames,
          harvestStatus: hive["harvestStatus"],
          lastHarvestDate: "No harvest yet",
          diseases: []);
      Provider.of<IotDetails>(context, listen: false)
          .save(hiveId: newHive.getId, iotDetails: []);

      _hives[apiaryId]!.add(newHive);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future deleteHive({context, apiaryId, hiveId}) async {
    try {
      final response = await request(
        route: '/hives/$apiaryId/$hiveId',
        method: RequestMethods.delete,
      );

      print("here");
      Provider.of<IotDetails>(context, listen: false).iotDetails.remove(hiveId);

      print("here");
      Hive hive = getById(apiaryId: apiaryId, hiveId: hiveId);
      _hives[apiaryId]!.remove(hive);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void deleteDetailsOfHive({context, apiaryId}) {
    List<Hive>? hives = _hives[apiaryId];
    for (int i = 0; i < hives!.length; i++) {
      Provider.of<IotDetails>(context, listen: false)
          .iotDetails
          .remove(hives[i].id);
    }
  }

  void reset() {
    _hives = {};
    notifyListeners();
  }
}
