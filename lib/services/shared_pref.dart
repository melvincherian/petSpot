import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userImageKey = "USERIMAGEKEY";
  static String userphoneKey = "USERPHONEKEY";


  Future<bool> saveUserId(String getuserId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getuserId);
  }

  Future<bool> saveUserName(String getuserName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getuserName);
  }

  Future<bool> saveUserEmail(String getuseremail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userEmailKey, getuseremail);
  }

  Future<bool> saveUserImage(String getuserimage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userImageKey, getuserimage);
  }

   Future<bool> saveUserphone(String getusernumber) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userphoneKey, getusernumber);
  }

  Future<String?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }

  Future<String?> getUserImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userImageKey);
  }

  Future<String?> getUsernumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userphoneKey);
  }
}
