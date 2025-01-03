import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/iotDetails.provider.dart';
import 'package:hivemind_app/utils/parseDate.dart';
import 'package:provider/provider.dart';

class Hive extends ChangeNotifier {
  final String id;
  final String label;
  final int numberOfFrames;
  final bool harvestStatus;
  final List<String> diseases;
  final List<IotDetails> details;
  String lastHarvestDate;

  Hive({
    required this.id,
    required this.label,
    required this.numberOfFrames,
    required this.harvestStatus,
    required this.lastHarvestDate,
    required this.diseases,
    required this.details,
  });

  List<Hive> save({context, hives}) {
    List<Hive> hiveList = [];
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
      List<IotDetails> iotDetailsList =
          Provider.of<IotDetails>(context, listen: false)
              .save(iotDetails: hive["iotDetails"]);

      final newHive = Hive(
        id: hive["_id"],
        label: hive["label"],
        numberOfFrames: hive["nbOfFrames"],
        harvestStatus: hive["harvestStatus"],
        lastHarvestDate: updatedDt,
        diseases: diseases,
        details: iotDetailsList,
      );

      hiveList.add(newHive);
      print("New hive ${newHive.toString()}");
    }
    notifyListeners();
    return hiveList;
  }
}
// @Schema()
// export class Hive {
//   _id: Types.ObjectId;

//   @Prop({ type: String, required: true })
//   label: string;

//   @Prop({ required: true, type: Number })
//   nbOfFrames: number;

//   @Prop({ type: Boolean, default: false })
//   harvestStatus: boolean;

//   @Prop({ type: Date, required: false })
//   lastHarvestDate: Date;

//   @Prop({ type: [String], default: [] })
//   diseases: string[];

//   @Prop({ type: [HiveDetailsSchema], default: [], select: false })
//   iotDetails: HiveDetails[];

//   @Prop({ type: [HiveMediaSchema], default: [], select: false })
//   images: HiveMedia[];

//   @Prop({ type: [HiveMediaSchema], default: [], select: false })
//   audios: HiveMedia[];
// }
