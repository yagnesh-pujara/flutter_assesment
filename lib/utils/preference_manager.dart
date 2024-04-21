import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static late SharedPreferences _prefs;
  static Future<SharedPreferences> initPrefs() async => _prefs = await SharedPreferences.getInstance();

  PreferenceManager() {
    initPrefs();
  }

  static Future<bool> saveBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  // Saves an integer value with the given key to SharedPreferences
  static Future<bool> saveInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  // Saves a double value with the given key to SharedPreferences
  static Future<bool> saveDouble(String key, double value) async {
    return _prefs.setDouble(key, value);
  }

  // Saves a string value with the given key to SharedPreferences
  static Future<bool> saveString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  // Saves a list of strings with the given key to SharedPreferences
  static Future<bool> saveStringList(String key, List<String> value) async {
    return _prefs.setStringList(key, value);
  }

  // Retrieves a boolean value with the given key from SharedPreferences
  static bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  // Retrieves an integer value with the given key from SharedPreferences
  static int getInt(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  // Retrieves a double value with the given key from SharedPreferences
  static double getDouble(String key) {
    return _prefs.getDouble(key) ?? 0.0;
  }

  // Retrieves a string value with the given key from SharedPreferences
  static String getString(String key) {
    return _prefs.getString(key) ?? "";
  }

  // Retrieves a list of strings with the given key from SharedPreferences
  static Future<List<String>?> getStringList(String key) async {
    return _prefs.getStringList(key);
  }

  // Removing data from SharedPreferences
  static Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  // Clearing all data from SharedPreferences
  static Future<void> clearData() async {
    await _prefs.clear();
  }
}
