import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/predefined_profiles.dart';
import '../models/diet_profile.dart';

/// Service for managing dietary profiles and persisting user preferences
/// Supports both single profile (free) and multiple profiles (Pro)
class ProfileService {
  static const String _activeProfileKey = 'active_profile_id';
  static const String _activeProfilesKey = 'active_profile_ids'; // For Pro users
  
  /// Gets the ID of the currently active profile (for free users)
  Future<String?> getActiveProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activeProfileKey);
  }
  
  /// Gets the list of active profile IDs (for Pro users)
  Future<List<String>> getActiveProfileIds() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_activeProfilesKey);
    
    if (jsonString == null) {
      // If no multi-profile data, check for single profile
      final singleId = await getActiveProfileId();
      return singleId != null ? [singleId] : [];
    }
    
    try {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }
  
  /// Sets the active profile by ID (for free users - single profile)
  Future<bool> setActiveProfileId(String profileId) async {
    final prefs = await SharedPreferences.getInstance();
    // Clear multiple profiles when setting single profile
    await prefs.remove(_activeProfilesKey);
    return await prefs.setString(_activeProfileKey, profileId);
  }
  
  /// Sets multiple active profile IDs (for Pro users)
  Future<bool> setActiveProfileIds(List<String> profileIds) async {
    final prefs = await SharedPreferences.getInstance();
    // Clear single profile when setting multiple
    await prefs.remove(_activeProfileKey);
    
    final jsonString = json.encode(profileIds);
    return await prefs.setString(_activeProfilesKey, jsonString);
  }
  
  /// Toggles a profile's active state (for Pro users with multiple profiles)
  Future<bool> toggleProfileActive(String profileId, bool isActive) async {
    final currentIds = await getActiveProfileIds();
    
    if (isActive) {
      // Add profile if not already in list
      if (!currentIds.contains(profileId)) {
        currentIds.add(profileId);
      }
    } else {
      // Remove profile from list
      currentIds.remove(profileId);
    }
    
    return await setActiveProfileIds(currentIds);
  }
  
  /// Clears the active profile selection
  Future<bool> clearActiveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeProfileKey);
    await prefs.remove(_activeProfilesKey);
    return true;
  }
  
  /// Gets all available profiles with the correct active state (for free users)
  Future<List<DietProfile>> getAllProfiles() async {
    final activeId = await getActiveProfileId();
    
    return predefinedProfiles.map((profile) {
      return profile.copyWith(isActive: profile.id == activeId);
    }).toList();
  }
  
  /// Gets all available profiles with correct active states (for Pro users)
  Future<List<DietProfile>> getAllProfilesWithMultipleActive() async {
    final activeIds = await getActiveProfileIds();
    
    return predefinedProfiles.map((profile) {
      return profile.copyWith(isActive: activeIds.contains(profile.id));
    }).toList();
  }
  
  /// Gets the currently active profile, or null if none is selected (for free users)
  Future<DietProfile?> getActiveProfile() async {
    final activeId = await getActiveProfileId();
    if (activeId == null) return null;
    
    final profile = getProfileById(activeId);
    if (profile == null) return null;
    
    return profile.copyWith(isActive: true);
  }
  
  /// Gets all currently active profiles (for Pro users)
  Future<List<DietProfile>> getActiveProfiles() async {
    final activeIds = await getActiveProfileIds();
    
    return predefinedProfiles
        .where((profile) => activeIds.contains(profile.id))
        .map((profile) => profile.copyWith(isActive: true))
        .toList();
  }
  
  /// Activates a specific profile and deactivates all others (for free users)
  Future<bool> activateProfile(String profileId) async {
    // Verify the profile exists
    final profile = getProfileById(profileId);
    if (profile == null) return false;
    
    // Save the active profile ID
    return await setActiveProfileId(profileId);
  }
  
  /// Checks if a specific profile is currently active
  Future<bool> isProfileActive(String profileId) async {
    final activeIds = await getActiveProfileIds();
    return activeIds.contains(profileId);
  }
  
  /// Gets the count of active profiles
  Future<int> getActiveProfileCount() async {
    final activeIds = await getActiveProfileIds();
    return activeIds.length;
  }
}
