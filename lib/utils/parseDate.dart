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
