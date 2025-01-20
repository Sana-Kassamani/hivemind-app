class Alert {
  final String? id;
  final String title;
  final String message;
  final DateTime time;

  Alert({
    this.id,
    required this.title,
    required this.message,
    required this.time,
  });
}

// _id: Types.ObjectId;

//   @Prop({ type: String, required: true })
//   title: string;

//   @Prop({ type: String, required: true })
//   message: string;

//   @Prop({ type: Date, default: Date.now })
//   time: Date;

//   @Prop({ type: Boolean, default: false })
//   deleted: boolean;
