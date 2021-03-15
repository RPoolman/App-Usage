class GlobalData {
  //user id to link to what to save
  static String loggedInUserID;
  //getting the users names who have been registered for the application
  static String userTrackedName = '';
  static String userTrackingName = '';
  //string variables for other screens
  static String app1Name = "";
  static String app2Name = "";
  static String app3Name = "";
  //string variables where the time will be set
  static String app1Time = "";
  static String app2Time = "";
  static String app3Time = "";
  //int variables for timing(only applicable to graph now);
  static List<int> appsGraphHours = [1,2,3,4,5];
  //below list used to populate extra screen
  static List<String> applicationList = [];
  static List<String> applicationNameList = [];
  //getting the total amount of daily hours the user spent
  static int totalAmountOnPhoneTodayHours;
  static String totalAmountOnPhoneToday;
}
