import 'package:app_usage/app_usage.dart';
import 'package:flutter_app/classes/deviceVars.dart';

class DeviceData {
  static List<AppUsageInfo> infosDay = [];

  static void getUsageStats() async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime dailyDate = endDate.subtract(new Duration(days: 1));
      List<AppUsageInfo> infoDayList = await AppUsage.getAppUsage(dailyDate, endDate);
      infoDayList.sort((a, b) => b.usage.inSeconds.compareTo(a.usage.inSeconds));

      infosDay = infoDayList;
      for(int i = 0; i < 5; i++){
        GlobalData.appsGraph[i] = infoDayList[i].usage.inMinutes;
      }
      for(int k = 0; k < infoDayList.length; k++){
        GlobalData.applicationList.add((infoDayList[k].usage.inHours).toString() + ':' + (infoDayList[k].usage.inMinutes%60).toString().padLeft(2,'0'));
      }
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
}