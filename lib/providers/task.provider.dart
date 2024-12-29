import 'package:flutter/material.dart';

class Task extends ChangeNotifier {
  final String _id;
  final String title;
  final String content;
  final String status;
  final String comment;
  final String date;

  Task(
    this._id,
    this.title,
    this.content,
    this.status,
    this.comment,
    this.date,
  );
}

// @Schema()
// export class Task {

//   _id: Types.ObjectId;

//   @Prop({ type: String, required: true })
//   title: string;

//   @Prop({ type: String, required: true })
//   content: string;

//   @Prop({ type: String, enum: TaskStatus, default: TaskStatus.Pending })
//   status: string;

//   @Prop({ type: String, required: false, default: '' })
//   comment: string;

//   @Prop({ type: Date, required: true, default: Date.now })
//   date: Date;
// }
