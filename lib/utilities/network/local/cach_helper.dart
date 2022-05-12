import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, data) async {
    if (data is String) {
      return await sharedPreferences.setString(key, data);
    } else if (data is bool) {
      return await sharedPreferences.setBool(key, data);
    } else if (data is int) {
      return await sharedPreferences.setInt(key, data);
    } else {
      return await sharedPreferences.setDouble(key, data);
    }
  }

  static Future<dynamic> loadData(String key) async {
    return sharedPreferences.get(key);
  }

  static Future<dynamic> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }
}
