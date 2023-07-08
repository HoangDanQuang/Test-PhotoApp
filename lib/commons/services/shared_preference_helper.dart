import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._();

  static const String is_logged_in = "isLoggedIn";
  static const String access_token = "accessToken";
  static const String refresh_token = "refreshToken";
  static const String user_info = "userInfo";
  static const String token_expiration = "tokenExpiration";
  static const String is_dark_mode = "is_dark_mode";
  static const String current_language = "current_language";
}

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

   Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.access_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.access_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.access_token);
  }

  Future<String?> get userInfo async {
    return _sharedPreference.getString(Preferences.user_info);
  }

  Future<bool> saveUserInfo(String info) async {
    return _sharedPreference.setString(Preferences.user_info, info);
  }

  Future<bool> removeUserInfo() async {
    return _sharedPreference.remove(Preferences.user_info);
  }

  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeToDarkMode(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }

}