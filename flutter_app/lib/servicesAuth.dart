import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //signing in with email/password
  Future signInEmailPass() async {
    try {
    //try this code
      UserCredential result = await _auth.signInWithEmailAndPassword(email: "test@test.com", password: "admin12345");
      User currentUser = result.user;
      return currentUser;
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
}