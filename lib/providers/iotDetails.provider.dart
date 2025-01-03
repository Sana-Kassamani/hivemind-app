import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/parseDate.dart';

class IotDetails extends ChangeNotifier {
  final String id;
  final String humidity;
  final String temperature;
  final String mass;
  final String date;

  IotDetails({
    required this.id,
    required this.humidity,
    required this.temperature,
    required this.mass,
    required this.date,
  });

  List<IotDetails> save({iotDetails}) {
    List<IotDetails> iotDetailsList = [];

    for (int i = iotDetails.length - 1; i >= 0; i--) {
      var detail = iotDetails[i];

      // parse date of iotDetail to Jan 01, 2000 format
      DateTime = DateTime.parse(detail["date"]);
      var newFormat = DateFormat("MMM dd, yyyy");
      String updatedDt = parseDate(date: detail["date"]);

      final newDetail = IotDetails(
        id: detail["_id"],
        humidity: detail["humidity"],
        temperature: detail["temperature"],
        mass: detail["mass"],
        date: updatedDt,
      );

      iotDetailsList.add(newDetail);
      print("New task ${newDetail.toString()}");
    }

    notifyListeners();
    return iotDetailsList;
  }
}

// export class HiveDetails {
//   _id: Types.ObjectId;

//   @Prop({ type: Number, required: true })
//   humidity: number;

//   @Prop({ type: Number, required: true })
//   temperature: number;

//   @Prop({ type: Number, required: true })
//   mass: number;

//   @Prop({ type: Date, default: Date.now })
//   date: Date;
// }
