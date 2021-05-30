import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inz_pills/Models/Appointment.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Models/Medicine.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Models/Reminder.dart';

class DatabaseService {
  // current user uid
  final String uid;
  final String reminderId;

  DatabaseService({this.reminderId, this.uid});

  //  collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference dosagesCollection = FirebaseFirestore.instance.collection('dosages');
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');
  final CollectionReference remindersCollection =
      FirebaseFirestore.instance.collection('reminders');

  Future updateUserData(String name, String surname, Timestamp birthDate, String sex) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
      'sex': sex,
    });
  }

  Future updateUserReminder(
      String reminderId, String userId, String title, String content, Timestamp date) async {
    return await remindersCollection.doc(reminderId).set({
      'reminderId': reminderId,
      'userId': userId,
      'title': title,
      'content': content,
      'date': date,
    });
  }

  Future deleteUserReminder(String reminderId) async {
    return await remindersCollection.doc(reminderId).delete();
  }

  Future createUserReminder(String userId, String title, String content, Timestamp date) async {
    var document = FirebaseFirestore.instance.collection('reminders').doc();
    var documentId = document.id;
    return await remindersCollection.doc(documentId).set({
      'reminderId': documentId,
      'userId': userId,
      'title': title,
      'content': content,
      'date': date,
    });
  }

  MyUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return MyUser(
        uid: uid,
        name: snapshot.data()['name'],
        surname: snapshot.data()['surname'],
        birthDate: snapshot.data()['birthDate'],
        sex: snapshot.data()['sex']);
  }

  Reminder _reminderFromSnapshot(DocumentSnapshot snapshot) {
    return Reminder(
        reminderId: snapshot.data()['reminderId'],
        userId: snapshot.data()['userId'],
        title: snapshot.data()['title'],
        content: snapshot.data()['content'],
        date: snapshot.data()['date']);
  }

  List<Dosage> _dosageListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Dosage(
        userId: document.data()['userId'] ?? '',
        medicine: document.data()['medicine'] ?? '',
        medLink: document.data()['medLink'] ?? '',
        dose: document.data()['dose'] ?? '',
        takeTime: document.data()['takeTime'] ?? '',
      );
    }).toList();
  }

  List<Medicine> _medicineListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Medicine(
        name: document.data()['medicine'] ?? '',
        link: document.data()['medLink'] ?? '',
      );
    }).toList();
  }

  List<Appointment> _appointmentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Appointment(
        userId: document.data()['userId'] ?? '',
        date: document.data()['date'] ?? '',
        doctorName: document.data()['doctorName'] ?? '',
        doctorSpecialisation: document.data()['doctorSpecialisation'] ?? '',
        location: document.data()['location'] ?? '',
      );
    }).toList();
  }

  List<Reminder> _reminderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Reminder(
        reminderId: document.data()['reminderId'] ?? '',
        userId: document.data()['userId'] ?? '',
        title: document.data()['title'] ?? '',
        content: document.data()['content'] ?? '',
        date: document.data()['date'] ?? '',
      );
    }).toList();
  }

  // get dosages stream
  Stream<List<Dosage>> get dosages {
    return dosagesCollection.snapshots().map(_dosageListFromSnapshot);
  }

  //get list of dosages for current user
  Future<List<Dosage>> getUserDosagesList() async {
    List<Dosage> dosagesList = [];

    await FirebaseFirestore.instance
        .collection('dosages')
        .where('userId', isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        dosagesList.add(new Dosage(
          userId: document.data()['userId'] ?? '',
          medicine: document.data()['medicine'] ?? '',
          medLink: document.data()['medLink'] ?? '',
          dose: document.data()['dose'] ?? '',
          takeTime: document.data()['takeTime'] ?? '',
        ));
      });
    });

    return dosagesList;
  }

  Future<List<Appointment>> getUserAppointmentsList() async {
    List<Appointment> appointmentsList = [];

    await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        appointmentsList.add(new Appointment(
          userId: document.data()['userId'] ?? '',
          date: document.data()['date'] ?? '',
          doctorName: document.data()['doctorName'] ?? '',
          doctorSpecialisation: document.data()['doctorSpecialisation'] ?? '',
          location: document.data()['location'] ?? '',
        ));
      });
    });

    return appointmentsList;
  }

  Future<List<Reminder>> getUserRemindersList() async {
    List<Reminder> remindersList = [];
    await FirebaseFirestore.instance
        .collection('reminders')
        .where('userId', isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((document) {
        remindersList.add(new Reminder(
            reminderId: document.data()['reminderId'] ?? '',
            userId: document.data()['userId'] ?? '',
            title: document.data()['title'] ?? '',
            content: document.data()['content'] ?? '',
            date: document.data()['date'] ?? ''));
      });
    });

    return remindersList;
  }

  // get user doc stream
  Stream<MyUser> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // get reminder doc stream
  Stream<Reminder> get reminderData {
    return remindersCollection.doc(reminderId).snapshots().map(_reminderFromSnapshot);
  }

  // get specific user dosages stream
  Stream<List<Dosage>> get userDosages {
    final Query specificUserDosagesCollection =
        FirebaseFirestore.instance.collection('dosages').where('userId', isEqualTo: uid);

    return specificUserDosagesCollection.snapshots().map(_dosageListFromSnapshot);
  }

  // get specific user reminders stream
  Stream<List<Reminder>> get userReminders {
    final Query specificUserDosagesCollection =
        FirebaseFirestore.instance.collection('reminders').where('userId', isEqualTo: uid);

    return specificUserDosagesCollection.snapshots().map(_reminderListFromSnapshot);
  }

  // get medicines from user dosages
  Stream<List<Medicine>> get userMedicines {
    final Query specificUserDosagesCollection =
        FirebaseFirestore.instance.collection('dosages').where('userId', isEqualTo: uid);

    return specificUserDosagesCollection.snapshots().map(_medicineListFromSnapshot);
  }

  // get specific user appointments stream
  Stream<List<Appointment>> get userAppointments {
    final Query specificUserAppointmentsCollection =
        FirebaseFirestore.instance.collection('appointments').where('userId', isEqualTo: uid);

    return specificUserAppointmentsCollection.snapshots().map(_appointmentListFromSnapshot);
  }
}
