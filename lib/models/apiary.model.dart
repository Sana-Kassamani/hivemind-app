class Location {
  double latitude;
  double longitude;
  String location;
  Location({
    required this.latitude,
    required this.longitude,
    required this.location,
  });

  set setLongitude(double long) => longitude = long;
  set setLatitude(double lat) => latitude = lat;
  set setLocation(String loc) => location = loc;
}

class Apiary {
  final String id;
  final String label;
  final String location;
  final double longitude;
  final double latitude;
  final String? beekeeperName;
  String? weather;

  Apiary({
    required this.id,
    required this.label,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.beekeeperName,
    this.weather,
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
