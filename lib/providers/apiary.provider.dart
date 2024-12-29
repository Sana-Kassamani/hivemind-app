import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/hive.provider.dart';
import 'package:hivemind_app/providers/task.provider.dart';

class Apiary extends ChangeNotifier {
  final String _id;
  final String label;
  final String location;
  final String beekeeperName;
  List<Hive> hives = [];
  List<Task> tasks = [];

  Apiary(
    this._id,
    this.label,
    this.location,
    this.beekeeperName,
    this.hives,
  );
  String getId() => _id;
}

// export class Apiary {
//   _id: Types.ObjectId;

//   @Prop({ type: String, unique: true, required: true })
//   label: string;

//   @Prop({ type: String, required: true })
//   location: string;

//   @Prop({ type: [HiveSchema], default: [] })
//   hives: Hive[];

//   @Prop({ type: [TaskSchema], default: [] })
//   tasks: Task[];
// }
