import 'package:shared_preferences/shared_preferences.dart';
import '../models/diet_profile.dart';
import '../data/predefined_profiles.dart';

/// Service for managing dietary profiles and persisting user preferences
class ProfileService {
  static const String _activeProfileKey = 'active_profile_id';
  
  /// Gets the ID of the currently active profile
  Future<String?> getActiveProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activeProfileKey);
  }
  
  /// Sets the active profile by ID
  Future<bool> setActiveProfileId(String profileId) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_activeProfileKey, profileId);
  }
  
  /// Clears the active profile selection
  Future<bool> clearActiveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_activeProfileKey);
  }
  
  /// Gets all available profiles with the correct active state
  Future<List<DietProfile>> getAllProfiles() async {
    final activeId = await getActiveProfileId();
    
    return predefinedProfiles.map((profile) {
      return profile.copyWith(isActive: profile.id == activeId);
    }).toList();
  }
  
  /// Gets the currently active profile, or null if none is selected
  Future<DietProfile?> getActiveProfile() async {
    final activeId = await getActiveProfileId();
    if (activeId == null) return null;
    
    final profile = getProfileById(activeId);
    if (profile == null) return null;
    
    return profile.copyWith(isActive: true);
  }
  
  /// Activates a specific profile and deactivates all others
  Future<bool> activateProfile(String profileId) async {
    // Verify the profile exists
    final profile = getProfileById(profileId);
    if (profile == null) return false;
    
    // Save the active profile ID
    return await setActiveProfileId(profileId);
  }
  
  /// Checks if a specific profile is currently active
  Future<bool> isProfileActive(String profileId) async {
    final activeId = await getActiveProfileId();
    return activeId == profileId;
  }
}
