import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Dosage {
  final String userId;
  final String medicine;
  final String medLink;
  final String dose;
  final Timestamp takeTime;

  Dosage({this.userId, this.medicine, this.medLink, this.dose, this.takeTime});

  String getDateTimeString() {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(takeTime.seconds * 1000);
    final scheduledTakeTime = tz.TZDateTime.from(date, tz.local);
    final formatter = new DateFormat('HH:mm dd.MM.yyyy');
    return formatter.format(scheduledTakeTime);
  }
}
