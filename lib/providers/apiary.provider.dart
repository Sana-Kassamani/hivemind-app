import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/hive.provider.dart';
import 'package:hivemind_app/providers/task.provider.dart';
import 'package:provider/provider.dart';

class Apiary extends ChangeNotifier {
  final String id;
  final String label;
  final String location;
  final String beekeeperName;
  List<Hive> hives = [];
  List<Task> tasks = [];

  Apiary({
    required this.id,
    required this.label,
    required this.location,
    required this.beekeeperName,
    required this.hives,
    required this.tasks,
  });
  String getId() => id;

  List<Apiary> save({apiaries, context}) {
    List<Apiary> apiaryList = [];
    for (int i = 0; i < apiaries.length; i++) {
      var apiary = apiaries[i];
      List<Hive> hiveList = Provider.of<Hive>(context, listen: false)
          .save(context: context, hives: apiary["hives"]);
      List<Task> taskList = Provider.of<Task>(context, listen: false)
          .save(tasks: apiary["tasks"]);
      final newApiary = Apiary(
        id: apiary["_id"],
        label: apiary["label"],
        location: apiary["location"],
        beekeeperName: beekeeperName,
        hives: hiveList,
        tasks: taskList,
      );
      apiaryList.add(newApiary);
    }

    notifyListeners();
    return apiaryList;
  }
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
