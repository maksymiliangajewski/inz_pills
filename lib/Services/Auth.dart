import 'package:firebase_auth/firebase_auth.dart';
import 'package:inz_pills/Models/MyUser.dart';
import 'package:inz_pills/Services/Database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create MyUser from firebase user
  MyUser _myUserFromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map(_myUserFromFirebase);
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _myUserFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //create a new document for the user with the uid
      DatabaseService(uid: user.uid).updateUserData('name', 'surname', 0, 'other');
      return _myUserFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign user out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
