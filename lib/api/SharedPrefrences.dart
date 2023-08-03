// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPref {
//   static late SharedPreferences sharedPref;

//   static init() async {
//     sharedPref = await SharedPreferences.getInstance();
//   }


// static Future<bool> setData(
//       {required String key, required dynamic value}) async {
//     if (value is int) return await sharedPref.setInt(key, value);
//     if (value is double) return await sharedPref.setDouble(key, value);
//     if (value is String) return await sharedPref.setString(key, value);
//     return await sharedPref.setBool(key, value);
//   }

//   // static Future<bool> setData(
//   //     {required String key, required dynamic value}) async {
//   //   if (value is int) {
//   //     return await sharedPref!.setInt(key, value);
//   //   } else if (value is double) {
//   //     return await sharedPref!.setDouble(key, value);
//   //   } else if (value is String) {
//   //     return await sharedPref!.setString(key, value);
//   //   } else {
//   //     return await sharedPref!.setBool(key, value);
//   //   }
//   // }

//   static dynamic getData({required String key}) {
//     return sharedPref.get(key);
//   }

//   static Future<bool> removeData({
//     required String key,
//   }) async {
//     return await sharedPref.remove(key);
//   }

//   static Future<bool> setBoolData(
//       {required String key, required bool value}) async {
//     return await SharedPref.setBool(key, value);
//   }
// }






import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late final SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // static Future<bool> setbooldata(
  //     {required String key, required bool value}) async {
  //   return await prefs.setBool(key, value);
  // }

  // static bool? getbooldata({required String key}) {
  //   return prefs.getBool(key);
  // }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) return await prefs.setInt(key, value);
    if (value is double) return await prefs.setDouble(key, value);
    if (value is String) return await prefs.setString(key, value);
    return await prefs.setBool(key, value);
  }

  static dynamic getData({required String key}) {
    return prefs.get(key);
  }

 static Future<bool> removeData({required String key})async {
  return await prefs.remove(key);
  }
}