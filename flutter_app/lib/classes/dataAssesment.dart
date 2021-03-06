import 'package:flutter_app/classes/deviceVars.dart';

class UserUsageAssesment {
  final int totalhoursday = 24;
  static String usageResult = '';
  static String resultDescription = '';
  static void getUserHours(int userhours) {
    if(userhours >= 7) {
      usageResult = 'TEEN DAUGHTER';
      resultDescription = 'You are clearly inhuman...';
    } else if(userhours >= 5) {
      usageResult = 'HIGH';
      resultDescription = 'Your phone usage habbits are somewhat on the higher spectrum. Please re-evaluate how much time you spend on your device daily, as continuing spending more and more time on your phone can lead to health problems and possibly depression. Physical exercise is a good way of unwinding and bringing down your phone usage amount.';
    } else if(userhours >= 3) {
      usageResult = 'AVERAGE';
      resultDescription = 'You are in a good spot for the amount you are on your phone. The average amount people spend on their phones is around 3 hours and you fall in that category, as long as you keep in mind to not be on your device for longer then needed, you will achieve a balanced digital wellness.';
    } else if(userhours > 1) {
      usageResult = 'LOW';
      resultDescription = 'Your phone usage is very low, but do not threat as their isn\'t any negative effect as to not using your phone all the time, it just means you have more time to enjoy life.';
    } else if(userhours <= 1) {
      usageResult = 'VERY LOW';
      resultDescription = 'You might not care at all.';
    }
  }
}
