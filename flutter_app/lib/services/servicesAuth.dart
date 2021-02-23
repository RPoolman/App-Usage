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
  //
  // Future signInEmailPass() async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(email: "test@test.com", password: "admin12345");
  //     User currentUser = result.user;
  //     return _userFromFirebaseUser(currentUser);
  //   } on FirebaseAuthException catch(e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }
  //register email/password
  Future registerWithEmailPassword(String emailIn, String passwordIn) async {
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
  Future signOut() async {//this method name is unique from the one below, they do not touch the same areas
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}