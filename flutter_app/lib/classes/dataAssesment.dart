import 'package:flutter_app/classes/deviceVars.dart';

class UserUsageAssesment {

  final int totalhoursday = 24;
  static int userhours = 0;

  static void getUsagePerc() {
    userhours = GlobalData.totalAmountOnPhoneTodayHours;

    switch(userhours) {
      case 0 : {}
      break;
      case 1: {}
      break;
      case 2: {}
      break;
      default: {}
    }
  }

  static void setUsagePerc() {}
}
