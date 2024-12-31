import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _authTokenKey = 'auth_token';
  static const String _villageName = 'villName';
  static const String _millId = 'millId';

  // Save token
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  static Future<void> saveVillageName(String villName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_villageName, villName);
  }

  static Future<void> saveMillId(String millId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_millId, millId);
  }

  static Future<String?> getMillId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_millId);
  }

  static Future<String?> getVillageName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_villageName);
  }

  // Retrieve token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Clear all preferences
  static Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
