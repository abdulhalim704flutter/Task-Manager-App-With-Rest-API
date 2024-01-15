import 'dart:convert';

import 'package:task_manager/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthUtility{
  AuthUtility._();
  static LoginModel userInfo = LoginModel();

  static Future<void> saveUserInfo(LoginModel model) async{
    SharedPreferences _shareprefs =await SharedPreferences.getInstance();
    await _shareprefs.setString('user-data', jsonEncode(model.toJson()));
    userInfo = model; // this is call for show data in user profile
  }
  static Future<void> UpdateInfo(UserData data) async{
    SharedPreferences _shareprefs =await SharedPreferences.getInstance();
    userInfo.data = data;
    await _shareprefs.setString('user-data', jsonEncode(userInfo.toJson()));
  }

  static Future<LoginModel> getUserInfo() async{
    SharedPreferences _shareprefs =await SharedPreferences.getInstance();
    String value = _shareprefs.getString('user-data')!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  static Future<void> clearUserInfo()async{
    SharedPreferences _sharedPrefs =await SharedPreferences.getInstance();
    await _sharedPrefs.clear();

  }
  static Future<bool> checkIfUserLoggin()async{
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    bool isLogin = _sharedPrefs.containsKey('user-data');
    if(isLogin){
     userInfo = await getUserInfo();
    }
    return isLogin;


  }

}