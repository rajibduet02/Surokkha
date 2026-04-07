import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists auth token after OTP verification.
class AuthStorageService extends GetxService {
  static const _tokenKey = 'auth_token';

  SharedPreferences? _prefs;

  Future<void> _ensurePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    await _ensurePrefs();
    await _prefs!.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    await _ensurePrefs();
    return _prefs!.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _ensurePrefs();
    await _prefs!.remove(_tokenKey);
  }
}
