import 'package:get_storage/get_storage.dart';

class GetSfLocalStorage {

  static final box = GetStorage();

  /// for writing string value
  static void writeString(String key, String v) {
    box.write(key, v);
  }

  /// for reading string value
  static String getString(String key) {
    return box.read(key) ?? "";
  }

  /// for writing string value
  static void writeBool(String key, bool v) {
    box.write(key, v);
  }

  /// for reading string value
  static bool getBool(String key) {
    return box.read(key);
  }

  /// to clear value from storage
  static void clearValueByKey(String key) {
    box.remove(key);
  }

  /// to clear all data from local storage
  static eraseLocalStorage() {
    isUserLoggedIn(false);
    box.erase();
  }

  /// to save login status
  static void isUserLoggedIn(bool? v) {
    writeBool(GetXStorageConstants.login, v ?? false);
  }

  /// to save login status
  static bool? getUserLoggedIn() {
    return getBool(GetXStorageConstants.login);
  }

  /// to save rememberMe status
  static void setRememberMe(bool v) {
    writeBool(GetXStorageConstants.rememberMe, v);
  }

  /// to save rememberMe status
  static bool getRememberMe() {
    return box.read(GetXStorageConstants.rememberMe) ?? false;
  }

  /// to save last logged time.
  static void setAuthToken(String token) {
    box.write(GetXStorageConstants.authToken, token);
  }

  /// to get last logged time.
  static String getAuthToken() {
    return box.read(GetXStorageConstants.authToken) ?? "";
  }

  /// to save clockOut time.
  static void setClockOutTime(String clocKOutTime) {
    box.write(GetXStorageConstants.clockOut, clocKOutTime);
  }

  /// to get last logged time.
  static String getClockOutTime() {
    return box.read(GetXStorageConstants.clockOut) ?? "";
  }

  /// for clearing all data
  static void clear() {
    box.erase();
  }
}

class GetXStorageConstants {
  static const authToken = "Authorization";
  static const clockOut = "clockOut";
  static const login = "login";
  static const rememberMe = "rememberMe";
  static const isBioMetric = "isBioMetric";
  static const languageId = "languageId";
  static const selectedLanguage = "selectedLanguage";
  static const videoQualityId = "videoQualityId";
  static const videoQuality = "videoQuality";
  static const locationAllowed = "locationAllowed";
  static const biometricEnabled = "biometricEnabled";
  static const appleHealthConnected = "appleHealthConnected";
  static const locationServiceStatus = "locationServiceStatus";
  static const userID = "userID";
  static const userName = "userName";
  static const emailAddress = "emailAddress";
  static const logProgressLastVisitedPage = "logProgressLastVisitedPage";
  static const logProgressLastVisitedPageId = "logProgressLastVisitedPageId";
  static const biometricType = "emailAddress";
}
