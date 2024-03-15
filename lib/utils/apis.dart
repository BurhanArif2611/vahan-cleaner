class Apis {
  static String baseUrl = "https://www.vahanplus.club/app/";
  static String loginWithPasswordUrl = "cleaner/login.php";
  static String getPendingCleanerUrl = "cleaner/get-subscriptions.php?token=";
  static String getCompletedCleanerUrl = "cleaner/get-completed-subscription.php?token=";
  static String getOtherCleanerUrl = "cleaner/get-others-subscriptions.php?token=";
  static String addCleanerUrl = "cleaner/cleaning-log.php?token=";
  static String markAttendanceUrl = "cleaner/mark-attendance.php?token=";
  static String dashBoardUrl = "cleaner/dashboard.php?token=";
}

printImageError({required String error}) {
  print("Catch Error ==> $error");
}

printCatchError({required String url, required String error}) {
  print("Api Url ==> $url");
  print("Catch Error ==> $error");
}

printDifferenceCatchError({required String error}) {
  print("Catch Error ==> $error");
}

printWorkingHr({required String workingHr}) {
  print("Working Hr's ==> $workingHr");
}

printApiBody({required String body}) {
  print("Api body ==> $body");
}

printError({required String error}) {
  print("Error ==> $error");
}

printApiResponse({required String url, required String response, required String statusCode}) {
print("Api Url ==> $url");
print("Api Status code ==> $statusCode");
print("Api Response ==> $response");
}