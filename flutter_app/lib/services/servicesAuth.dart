import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/classes/deviceVars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserApptracker _userFromFirebaseUser(User firebaseUser){
    return firebaseUser != null ? UserApptracker(uid: firebaseUser.uid) : null;
  }

  Stream<UserApptracker> get signedInUser {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  Future signMeInEmailPassword(String emailIn, String passwordIn) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: emailIn, password: passwordIn);
      User currentUser = result.user;

      GlobalData.loggedInUserID = currentUser.uid;

      await FirebaseFirestore.instance.collection('users').doc(GlobalData.loggedInUserID).get().then((value) => {
        GlobalData.userTrackingName =  value.data()['username'],
        GlobalData.userTrackedName = value.data()['usertrackname']
      });

      return _userFromFirebaseUser(currentUser);
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      GlobalData.loggedInUserID = null;
      return null;
    }
  }
  Future registerMeWithEmailPassword(String emailIn, String passwordIn) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: emailIn, password: passwordIn);
      User currentUser = result.user;

      GlobalData.loggedInUserID = currentUser.uid;

      return _userFromFirebaseUser(currentUser);
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      GlobalData.loggedInUserID = null;
      return null;
    }
  }
  Future signMeOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}