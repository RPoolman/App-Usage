import 'package:app_usage/app_usage.dart';
import 'package:flutter_app/classes/deviceVars.dart';

class DeviceData {
  static List<AppUsageInfo> infosDay = [];
  static Future<void> getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime dailyDate = endDate.subtract(new Duration(days: 1));
      List<AppUsageInfo> infoDayList = await AppUsage.getAppUsage(dailyDate, endDate);
      infoDayList.sort((a, b) => b.usage.inSeconds.compareTo(a.usage.inSeconds));

      infosDay = infoDayList;
      int totalAmount = 0;

      for(int x = 0; x < infoDayList.length; x++) {
        if(infoDayList[x].appName == "flutter_app") {
          infoDayList.removeAt(x);
        }
      }
      if(infoDayList.length >= 5) {
        for(int i = 0; i < 5; i++){
          GlobalData.appsGraphHours[i] = (infoDayList[i].usage.inMinutes).round();
        }
      } else if(infoDayList.length >= 3) {
        for(int i = 0; i < infoDayList.length; i++){
          GlobalData.appsGraphHours[i] = (infoDayList[i].usage.inMinutes).round();
        }
      } else if(infoDayList.length >= 1) {
        for(int i = 0; i < infoDayList.length; i++){
          GlobalData.appsGraphHours[i] = (infoDayList[i].usage.inMinutes).round();
        }
      } else if(infoDayList.length == 0) {
        for(int i = 0; i < 5; i++){
          GlobalData.appsGraphHours[i] = 1;
        }
      }
      for(int k = 0; k < infoDayList.length; k++){
        totalAmount += infoDayList[k].usage.inMinutes;
        GlobalData.applicationList.add((infoDayList[k].usage.inHours).toString() + ':' + (infoDayList[k].usage.inMinutes%60).toString().padLeft(2,'0'));
        GlobalData.applicationNameList.add(infoDayList[k].appName);
      }

      GlobalData.totalAmountOnPhoneToday = (totalAmount~/60).toString() + ':' + (totalAmount%60).toString().padLeft(2,'0');
      GlobalData.totalAmountOnPhoneTodayHours = totalAmount~/60;

      var listLen = infoDayList.length;
      switch(listLen) {
        case 0: { GlobalData.app1Name = ""; }
        break;
        case 1: {
          GlobalData.app1Name = infoDayList[0].appName;
          GlobalData.app1Time = (infoDayList[0].usage.inHours).toString() + ':' + (infoDayList[0].usage.inMinutes%60).toString().padLeft(2,'0');
        }
        break;
        case 2: {
          GlobalData.app1Name = infoDayList[0].appName;
          GlobalData.app1Time = (infoDayList[0].usage.inHours).toString() + ':' + (infoDayList[0].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app2Name = infoDayList[1].appName;
          GlobalData.app2Time = (infoDayList[1].usage.inHours).toString() + ':' + (infoDayList[1].usage.inMinutes%60).toString().padLeft(2,'0');
        }
        break;
        default: {
          GlobalData.app1Name = infoDayList[0].appName;
          GlobalData.app1Time = (infoDayList[0].usage.inHours).toString() + ':' + (infoDayList[0].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app2Name = infoDayList[1].appName;
          GlobalData.app2Time = (infoDayList[1].usage.inHours).toString() + ':' + (infoDayList[1].usage.inMinutes%60).toString().padLeft(2,'0');
          GlobalData.app3Name = infoDayList[2].appName;
          GlobalData.app3Time = (infoDayList[2].usage.inHours).toString() + ':' + (infoDayList[2].usage.inMinutes%60).toString().padLeft(2,'0');
        }
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
  static void refreshUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime dailyDate = endDate.subtract(new Duration(days: 1));
      List<AppUsageInfo> infoDayList = await AppUsage.getAppUsage(
          dailyDate, endDate);
      infoDayList.sort((a, b) =>
          b.usage.inSeconds.compareTo(a.usage.inSeconds));

      infosDay = infoDayList;

      for (int x = 0; x < infoDayList.length; x++) {
        if (infoDayList[x].appName == "flutter_app") {
          infoDayList.removeAt(x);
        }
      }
      GlobalData.applicationList = [];
      GlobalData.applicationNameList = [];
      for (int k = 0; k < infoDayList.length; k++) {
        GlobalData.applicationList.add(
            (infoDayList[k].usage.inHours).toString() + ':' +
                (infoDayList[k].usage.inMinutes % 60).toString().padLeft(
                    2, '0'));
        GlobalData.applicationNameList.add(infoDayList[k].appName);
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
}