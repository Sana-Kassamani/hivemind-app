import 'package:intl/intl.dart';

String parseDate({date}) {
  // parse date to Jan 01, 2000 format
  DateTime parseDt = DateTime.parse(date);
  var newFormat = DateFormat("MMM dd, yyyy");
  String updatedDt = newFormat.format(parseDt);
  return updatedDt;
}

String graphDate({date}) {
  var newFormat = DateFormat("d/M/yy");
  String updatedDt = newFormat.format(date);
  return updatedDt;
}

String parseDateTime({dateTime}) {
  final now = DateTime.now();
  if (now.day == dateTime.day &&
      now.month == dateTime.month &&
      now.year == dateTime.year) {
    var newFormat = DateFormat('HH:mm');
    String updatedDt = newFormat.format(dateTime);
    return updatedDt;
  } else {
    var newFormat = DateFormat('dd/MM/yy HH:mm');
    String updatedDt = newFormat.format(dateTime);
    return updatedDt;
  }
}
