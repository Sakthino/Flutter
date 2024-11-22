import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static const _nameKey = 'profile_name';
  static const _phoneKey = 'profile_phone';
  static const _emailKey = 'profile_email';

  static Future<Map<String, String?>> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_nameKey),
      'phone': prefs.getString(_phoneKey),
      'email': prefs.getString(_emailKey),
    };
  }

  static Future<void> saveProfileData(Map<String, String?> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, data['name'] ?? '');
    await prefs.setString(_phoneKey, data['phone'] ?? '');
    await prefs.setString(_emailKey, data['email'] ?? '');
  }
}
