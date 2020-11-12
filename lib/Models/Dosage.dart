import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Dosage {
  final String userId;
  final String medicine;
  final String medLink;
  final String dose;
  final Timestamp takeTime;

  Dosage({this.userId, this.medicine, this.medLink, this.dose, this.takeTime});

  String getDateTimeString() {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(takeTime.seconds * 1000).add(Duration(hours: 1));
    final formatter = new DateFormat('HH:mm dd.MM.yyyy');
    return formatter.format(date);
  }
}
