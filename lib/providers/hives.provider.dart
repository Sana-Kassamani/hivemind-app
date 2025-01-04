import 'package:flutter/material.dart';
import 'package:hivemind_app/models/hive.model.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:provider/provider.dart';

class Hives extends ChangeNotifier {
  final Map<String, List<Hive>> _hives = {};

  void save({apiaryId, context, hives}) {
    _hives[apiaryId] = [];

    for (int i = 0; i < hives.length; i++) {
      var hive = hives[i];

      String updatedDt;
      // parse lastHarvestDate of Hive to Jan 01, 2000 format
      if (hive.containsKey('lastHarvestDate')) {
        updatedDt = parseDate(date: hive["lastHarvestDate"]);
      } else {
        updatedDt = "Not harvested yet";
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
}
