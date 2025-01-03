class IotDetail {
  final String id;
  final double humidity;
  final double temperature;
  final double mass;
  final String date;

  IotDetail({
    required this.id,
    required this.humidity,
    required this.temperature,
    required this.mass,
    required this.date,
  });
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
