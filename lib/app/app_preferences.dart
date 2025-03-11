import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  AppPreferences(this._sharedPreferences, this._secureStorage);


  Future<void> setUserToken(String token) async {
    _secureStorage
        .write(key: 'accessToken', value: token)
        .then((value) => print('Token saved'))
        .catchError((error) => print('Error saving token: $error'));
  }

  Future<String?> getUserToken() async {
    return _secureStorage.read(key: 'accessToken');
  }


  Future<void> setIsUserLoggedIn(bool value) async {
    _sharedPreferences.setBool('isLogin', value);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool('isLogin') ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove('isLogin');
    _secureStorage.delete(key: 'accessToken');
    
  }
}
