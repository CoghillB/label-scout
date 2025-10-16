import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing Pro user status
class ProStatusService {
  static const String _proStatusKey = 'is_pro_user';
  
  /// Gets the current Pro status
  Future<bool> isProUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_proStatusKey) ?? false;
  }
  
  /// Sets the Pro status
  Future<bool> setProStatus(bool isPro) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_proStatusKey, isPro);
  }
  
  /// Toggles the Pro status (for testing purposes)
  Future<bool> toggleProStatus() async {
    final currentStatus = await isProUser();
    return await setProStatus(!currentStatus);
  }
}
