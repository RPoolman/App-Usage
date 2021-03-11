import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/classes/deviceVars.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  List<String> times = GlobalData.applicationList;
  List<String> apps = GlobalData.applicationNameList;

  Map<String, dynamic> resultMap = {};

  Future updateUserData(String uName, String uTName, List<String> appTimes) async {
    for (var i = 0; i < times.length; i++) {
      resultMap["${times[i]}"] = apps[i];
    }
    return await userCollection.doc(uid).set({
      'username':uName,
      'usertrackname':uTName,
      'applicationsList':resultMap
    });
  }
}