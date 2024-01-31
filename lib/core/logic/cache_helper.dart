import 'package:shared_preferences/shared_preferences.dart';

import '../../views/auth/login/model.dart';

class CacheHelper {
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setCount(int value){
   return _prefs.setInt("my_count", value);
  }

  static int getCount() {
    return _prefs.getInt("my_count") ?? 0;
  }

  static Future<bool> clear() {
    print("Cleared Success");
    return _prefs.clear();
  }

  static Future<void> saveUserData(UserModel model)async{
   await _prefs.setString("phone", model.phone);
   await _prefs.setString("email", model.email);
   await _prefs.setString("token", model.token);
   await _prefs.setString("image", model.image);
   await _prefs.setString("full_name", model.fullname);
   await _prefs.setBool("isActive", model.isActive);
   await _prefs.setString("city_id", model.city.id);
   await _prefs.setString("city_name", model.city.name);
  }





  static bool isAuth()
  {
   String? token= _prefs.getString("token");

   return token!=null  || (token??"").isNotEmpty;
  }
}
