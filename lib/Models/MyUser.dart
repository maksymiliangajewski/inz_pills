import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String uid;
  final String name;
  final String surname;
  final Timestamp birthDate;
  final String sex;

  MyUser({this.uid, this.name, this.surname, this.birthDate, this.sex});
}
