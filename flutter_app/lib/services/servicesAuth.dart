import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';

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
      return _userFromFirebaseUser(currentUser);
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      return null;
    }
  }
  //signing in with number

  //register with number

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