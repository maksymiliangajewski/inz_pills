import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Reminder {
  final String reminderId;
  final String userId;
  final String title;
  final String content;
  final Timestamp date;

  Reminder({this.reminderId, this.userId, this.title, this.content, this.date});

  String getDateTimeString() {
    DateTime result =
        DateTime.fromMillisecondsSinceEpoch(date.seconds * 1000).add(Duration(hours: 1));
    final scheduledTakeTime = tz.TZDateTime.from(result, tz.local);
    final formatter = new DateFormat('HH:mm dd.MM.yyyy');
    return formatter.format(scheduledTakeTime);
  }
}
