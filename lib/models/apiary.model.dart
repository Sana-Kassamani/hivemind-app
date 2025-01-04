class Apiary {
  final String id;
  final String label;
  final String location;
  final String? beekeeperName;

  Apiary({
    required this.id,
    required this.label,
    required this.location,
    required this.beekeeperName,
  });
  String getId() => id;
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
