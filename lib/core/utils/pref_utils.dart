import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth_feature/interceptor/AuthInterceptor.dart';


abstract class PrefUtils {
  String? getToken();

  void setToken(String token);

  bool? getLogin();

  void setLogin(bool login);

  void setRememberMe(bool rememberMe);

  bool? getRememberMe();

  void setPhoneNumber(String phoneNumber);

  String? getPhoneNumber();

  void setPassword(String password);

  String? getPassword();

  void removeToken();

  void removePhoneNumber();

  void removePassword();

  bool? checkIfOnBoardingSeen();

  void setOnBoardingSeen();

  void cacheUser(String object);

  String? getStringUser();

  void saveSelectedLanguage(String SelectedLanguage);

  String? getSelectedLanguage();
}

class PrefUtilsImpl implements PrefUtils {
  final SharedPreferences sharedPreferences;
  final AuthenticatedHttpClient httpClientInterceptor;

  PrefUtilsImpl(
      {required this.sharedPreferences, required this.httpClientInterceptor});

  @override
  String? getToken() {
    return sharedPreferences.getString("token");
  }

  @override
  void setToken(String token) {
    sharedPreferences.setString("token", token);
  }

  @override
  void removeToken() {
    const CACHED_USER = "LOGGED_USER";
    sharedPreferences.remove("token");
    if (sharedPreferences.getString(CACHED_USER) != null) {
      sharedPreferences.remove(CACHED_USER);
    }
    httpClientInterceptor.reset();
  }

  @override
  String? getPassword() {
    return sharedPreferences.getString("password");
  }

  @override
  String? getPhoneNumber() {
    return sharedPreferences.getString("phoneNumber");
  }

  @override
  bool? getRememberMe() {
    return sharedPreferences.getBool("rememberMe");
  }

  @override
  void setPassword(String password) {
    sharedPreferences.setString("password", password);
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    sharedPreferences.setString("phoneNumber", phoneNumber);
  }

  @override
  void setRememberMe(bool rememberMe) {
    sharedPreferences.setBool("rememberMe", rememberMe);
  }

  @override
  void removePassword() {
    sharedPreferences.remove("password");
  }

  @override
  void removePhoneNumber() {
    sharedPreferences.remove("phoneNumber");
  }

  @override
  bool? checkIfOnBoardingSeen() {
    return sharedPreferences.getBool("onBoardingSeen");
  }

  @override
  void setOnBoardingSeen() {
    sharedPreferences.setBool("onBoardingSeen", true);
  }

  @override
  void cacheUser(String object) {
    const CACHED_USER = "LOGGED_USER";
    sharedPreferences.setString(CACHED_USER, object);
  }

  @override
  String? getStringUser() {
    const CACHED_USER = "LOGGED_USER";
    return sharedPreferences.getString(CACHED_USER);
  }

  @override
  bool? getLogin() {
    return sharedPreferences.getBool("login");
  }

  @override
  void setLogin(bool login) {
    sharedPreferences.setBool("login", login);
  }

  @override
  void saveSelectedLanguage(String SelectedLanguage) {
    sharedPreferences.setString("SelectedLanguage", SelectedLanguage);
  }

  @override
  String? getSelectedLanguage() {
    sharedPreferences.getString("SelectedLanguage");
  }
}
