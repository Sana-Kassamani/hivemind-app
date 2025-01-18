class Comment {
  final String id;
  final String content;
  final String userName;
  final DateTime date;
  Comment({
    required this.id,
    required this.content,
    required this.userName,
    required this.date,
  });
}

class Task {
  final String id;
  final String title;
  final String content;
  String status;
  final List<Comment> comments;
  final String date;

  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.comments,
    required this.date,
  });
}
// @Schema()
// export class Comment {
//   constructor({ userId, content }) {
//     this.content = content;
//     this.userId = userId;
//   }
//   _id: Types.ObjectId;

//   @Prop({ type: String, required: true })
//   content: string;

//   @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'User', default: null })
//   userId: User;

//   @Prop({ type: Date, required: true, default: Date.now })
//   date: Date;
// }
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
