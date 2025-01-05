class Location {
  final double latitude;
  final double longitude;
  final String location;
  Location({
    required this.latitude,
    required this.longitude,
    required this.location,
  });
}

class Apiary {
  final String id;
  final String label;
  final String location;
  final double longitude;
  final double latitude;
  final String? beekeeperName;

  Apiary({
    required this.id,
    required this.label,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.beekeeperName,
  });
  String getId() => id;
  String getLocation() => location;
  String getLabel() => label;
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
