import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inz_pills/Models/Dosage.dart';
import 'package:inz_pills/Models/Medicine.dart';
import 'package:inz_pills/Models/MyUser.dart';

class DatabaseService {
  // current user uid
  final String uid;

  DatabaseService({this.uid});

  //  collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference dosagesCollection = FirebaseFirestore.instance.collection('dosages');

  Future updateUserData(String name, String surname, int age, String sex) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'age': age,
      'sex': sex,
    });
  }

  MyUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return MyUser(
        uid: uid,
        name: snapshot.data()['name'],
        surname: snapshot.data()['surname'],
        age: snapshot.data()['age'],
        sex: snapshot.data()['sex']);
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

  // get dosages stream
  Stream<List<Dosage>> get dosages {
    return dosagesCollection.snapshots().map(_dosageListFromSnapshot);
  }

  // get user doc stream
  Stream<MyUser> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // get specific user dosages stream
  Stream<List<Dosage>> get userDosages {
    final Query specificUserDosagesCollection =
        FirebaseFirestore.instance.collection('dosages').where('userId', isEqualTo: uid);

    return specificUserDosagesCollection.snapshots().map(_dosageListFromSnapshot);
  }

  // get medicines from user dosages
  Stream<List<Medicine>> get userMedicines {
    final Query specificUserDosagesCollection =
        FirebaseFirestore.instance.collection('dosages').where('userId', isEqualTo: uid);

    return specificUserDosagesCollection.snapshots().map(_medicineListFromSnapshot);
  }
}
