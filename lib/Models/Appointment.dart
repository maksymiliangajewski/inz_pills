import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Appointment {
  final String userId;
  final Timestamp date;
  final String doctorName;
  final String doctorSpecialisation;
  final GeoPoint location;

  Appointment({this.userId, this.date, this.doctorName, this.doctorSpecialisation, this.location});

  String getDateTimeString() {
    DateTime result =
        DateTime.fromMillisecondsSinceEpoch(date.seconds * 1000).add(Duration(hours: 1));
    final scheduledTakeTime = tz.TZDateTime.from(result, tz.local);
    final formatter = new DateFormat('HH:mm dd.MM.yyyy');
    return formatter.format(scheduledTakeTime);
  }
}
