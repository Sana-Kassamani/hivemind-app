import 'package:flutter/material.dart';

class Hive extends ChangeNotifier {
  final String id;
  final String label;
  final int numberOfFrames;
  final bool harvestStatus;
  final List<String> diseases;
  String lastHarvestDate;

  Hive({
    required this.id,
    required this.label,
    required this.numberOfFrames,
    required this.harvestStatus,
    required this.lastHarvestDate,
    required this.diseases,
  });
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
