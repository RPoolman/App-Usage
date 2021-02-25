import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(User firebaseUser){
    return firebaseUser != null ? User(uid: firebaseUser.uid) : null;
  }

  Stream<User> get signedInUser {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInEmailPass() async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: "test@test.com", password: "admin12345");
      User currentUser = result.user;
      return _userFromFirebase(currentUser);
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  //register email/password

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