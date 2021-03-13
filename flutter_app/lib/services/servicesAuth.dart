import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserApptracker _userFromFirebaseUser(User firebaseUser){
    return firebaseUser != null ? UserApptracker(uid: firebaseUser.uid) : null;
  }

  Stream<UserApptracker> get signedInUser {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  //signin email/password
  Future signMeInEmailPassword(String emailIn, String passwordIn) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: emailIn, password: passwordIn);
      User currentUser = result.user;
      return _userFromFirebaseUser(currentUser);
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      return null;
    }
  }
  //register email/password
  Future registerMeWithEmailPassword(String emailIn, String passwordIn) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: emailIn, password: passwordIn);
      User currentUser = result.user;

      // List<String> times = GlobalData.applicationList;
      // List<String> apps = GlobalData.applicationNameList;
      // List<String> apptimes;
      //   USER SOMEWHERE ELSE
      // for(int i = 0; i < times.length; i++) {
      //   apptimes.add(apps[i] + " -> " + times[i]);
      // }

      DatabaseService(uid: currentUser.uid).updateUserData('John', 'Derrik', null);

      return _userFromFirebaseUser(currentUser);
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      return null;
    }
  }
  //signOut
  //this method name is unique from the one below, they do not touch the same areas
  Future signMeOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}