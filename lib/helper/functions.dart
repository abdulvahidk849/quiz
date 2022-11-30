
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String userLoggedInKey = "USERLOGGEDINKEY";
  static Future<bool?> saveUserLoggedInDetails({required bool isLoggedin}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedInKey, isLoggedin);
  }

  static Future<bool?> getUserLoggedInDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }
}