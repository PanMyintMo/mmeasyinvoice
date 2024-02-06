import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceService {
  static const String userRoleKey = 'userRole';
  static const String tokenKey = 'tokenKey';
  static const String userNameKey = 'userName';
  static const String userMailKey = 'userMail';

  static Future<void> saveUserRole(String userRole) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(userRoleKey, userRole);
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(tokenKey, token);
  }

  Future<void> saveUserName(String name) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userNameKey, name);
  }

  Future<String?> getUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final userName = pref.getString(userNameKey);
    return userName;
  }

  Future<void> saveUserEmail(String email) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userMailKey, email);
  }

  Future<String?> getUserEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final email = pref.getString(userMailKey);
    return email;
  }

  Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString(userRoleKey);
    return userType;
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);
    return token;
  }

  // getUserId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userType = prefs.getString(userRoleKey);
  //   if (userType != null) {
  //     return true;
  //   }
  //   return false;
  // }

  Future<void> removeUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userRoleKey);
  }

   Future<void> removeToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(tokenKey);
  }
}
