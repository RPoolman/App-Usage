import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  static CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String uName, String uTName, List<String> appTimes) async {
    return await userCollection.doc(uid).set({
      'username':uName,
      'usertrackname':uTName,
      'applicationsList':appTimes
    },
      SetOptions(merge: true),);
  }
  
  //get snapshot
  Stream<QuerySnapshot> get userShot {
    return userCollection.snapshots();
  }
}