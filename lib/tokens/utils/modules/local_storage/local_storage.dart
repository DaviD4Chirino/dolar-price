import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static void hasBeenInitialized() {
    assert(
      pref != null,
      "You need to initialize shared preferences",
    );
  }

  static Future<void> setString(String key, String value) async {
    hasBeenInitialized();
    await pref!.setString(key, value);
  }

  static String? getString(String key) {
    hasBeenInitialized();
    return pref!.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    hasBeenInitialized();
    await pref!.setBool(key, value);
  }

  static bool? getBool(String key) {
    hasBeenInitialized();
    return pref!.getBool(key);
  }

  static Future<void> setInt(String key, int value) async {
    hasBeenInitialized();
    await pref!.setInt(key, value);
  }

  static int? getInt(String key) {
    hasBeenInitialized();
    return pref!.getInt(key);
  }

  static Future<void> setDouble(String key, double value) async {
    hasBeenInitialized();
    await pref!.setDouble(key, value);
  }

  static double? getDouble(String key) {
    hasBeenInitialized();
    return pref!.getDouble(key);
  }

  static Future<void> setStringList(
    String key,
    List<String> value,
  ) async {
    hasBeenInitialized();
    await pref!.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    hasBeenInitialized();
    return pref!.getStringList(key);
  }

  static Future<void> remove(String key) async {
    hasBeenInitialized();
    await pref!.remove(key);
  }

  static Future<void> clear() async {
    hasBeenInitialized();
    await pref!.clear();
  }

  static bool containsKey(String key) {
    hasBeenInitialized();
    return pref!.containsKey(key);
  }
}
