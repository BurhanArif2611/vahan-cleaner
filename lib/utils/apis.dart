class Apis {
  static String baseUrl = "https://www.vahanplus.club/app/";
  static String loginWithPassword = "cleaner/login.php";
  static String getPendingCleaner = "cleaner/get-subscriptions.php?token=";
  static String getCompletedCleaner = "cleaner/get-completed-subscription.php?token=";
  static String getOtherCleaner = "cleaner/get-others-subscriptions.php?token=";
  static String addCleaner = "cleaner/cleaning-log.php?token=";
}

printImageError({required String error}) {
  print("Catch Error ==> $error");
}

printCatchError({required String url, required String error}) {
  print("Api Url ==> $url");
  print("Catch Error ==> $error");
}

printApiBody({required String body}) {
  print("Api body ==> $body");
}

printApiResponse({required String url, required String response, required String statusCode}) {
print("Api Url ==> $url");
print("Api Status code ==> $statusCode");
print("Api Response ==> $response");
}