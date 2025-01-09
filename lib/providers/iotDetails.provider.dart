import 'package:flutter/material.dart';
import 'package:hivemind_app/models/iotDetail.model.dart';
import 'package:hivemind_app/utils/parseDate.dart';

class IotDetails extends ChangeNotifier {
  Map<String, List<IotDetail>> _iotDetails = {};
  Map<String, List<IotDetail>> get iotDetails => _iotDetails;
  set iotDetails(Map<String, List<IotDetail>> map) => _iotDetails = map;

  void save({hiveId, iotDetails}) {
    _iotDetails[hiveId] = [];
    for (int i = iotDetails.length - 1; i >= 0; i--) {
      var detail = iotDetails[i];

      // parse date of iotDetail to Jan 01, 2000 format
      String updatedDt = parseDate(date: detail["date"]);

      final newDetail = IotDetail(
        id: detail["_id"],
        humidity: detail["humidity"].toDouble(),
        temperature: detail["temperature"].toDouble(),
        mass: detail["mass"].toDouble(),
        date: updatedDt,
        dateTime: DateTime.parse(detail["date"]),
      );

      _iotDetails[hiveId]!.add(newDetail);
      print("New task ${newDetail.toString()}");
    }

    notifyListeners();
  }

  void reset() {
    _iotDetails = {};
    notifyListeners();
  }
}
