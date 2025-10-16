import 'package:flutter/material.dart';

import '../models/diet_profile.dart';
import '../services/pro_status_service.dart';
import '../services/profile_service.dart';
import 'upgrade_screen.dart';

/// Screen displaying dietary profiles with single or multiple selection based on Pro status
class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  final ProfileService _profileService = ProfileService();
  final ProStatusService _proStatusService = ProStatusService();
  List<DietProfile> _profiles = [];
  bool _isLoading = true;
  bool _isProUser = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Loads profiles and Pro status
  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final isPro = await _proStatusService.isProUser();
      final profiles = isPro
          ? await _profileService.getAllProfilesWithMultipleActive()
          : await _profileService.getAllProfiles();

      setState(() {
        _isProUser = isPro;
        _profiles = profiles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  /// Activates a profile and updates the UI (for free users - single profile)
  Future<void> _activateProfile(String profileId) async {
    try {
      if (_isProUser) {
        // Pro users can toggle multiple profiles
        final profile = _profiles.firstWhere((p) => p.id == profileId);
        await _profileService.toggleProfileActive(profileId, !profile.isActive);
      } else {
        // Free users can only have one active profile
        await _profileService.activateProfile(profileId);
      }
      
      // Reload profiles to update active state
      await _loadData();
      
      if (mounted) {
        final activeCount = await _profileService.getActiveProfileCount();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isProUser
                  ? '$activeCount profile(s) active'
                  : 'Profile activated: ${_getProfileName(profileId)}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Gets profile name by ID
  String _getProfileName(String id) {
    final profile = _profiles.firstWhere(
      (p) => p.id == id,
      orElse: () => DietProfile(
        id: '',
        name: 'Unknown',
        avoidIngredients: [],
        cautionIngredients: [],
      ),
    );
    return profile.name;
  }

  /// Shows detailed information about a profile
  void _showProfileDetails(DietProfile profile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(profile.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '❌ Avoid:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                profile.avoidIngredients.join(', '),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              const Text(
                '⚠️ Caution:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                profile.cautionIngredients.join(', '),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dietary Profiles'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading profiles',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(_error!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Info banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      child: Row(
                        children: [
                          Icon(
                            _isProUser ? Icons.star : Icons.info_outline,
                            color: _isProUser ? Colors.amber : Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _isProUser
                                  ? 'Pro: Select multiple dietary profiles to scan against'
                                  : 'Select one dietary profile to use when scanning products',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          if (!_isProUser)
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UpgradeScreen(),
                                  ),
                                ).then((_) => _loadData());
                              },
                              child: const Text('Upgrade'),
                            ),
                        ],
                      ),
                    ),
                    
                    // Profiles list
                    Expanded(
                      child: ListView.builder(
                        itemCount: _profiles.length,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemBuilder: (context, index) {
                          final profile = _profiles[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: ListTile(
                              leading: _isProUser
                                  ? Checkbox(
                                      value: profile.isActive,
                                      onChanged: (value) {
                                        _activateProfile(profile.id);
                                      },
                                    )
                                  : Radio<String>(
                                      value: profile.id,
                                      groupValue: _profiles
                                          .firstWhere(
                                            (p) => p.isActive,
                                            orElse: () => DietProfile(
                                              id: '',
                                              name: '',
                                              avoidIngredients: [],
                                              cautionIngredients: [],
                                            ),
                                          )
                                          .id,
                                      onChanged: (value) {
                                        if (value != null) {
                                          _activateProfile(value);
                                        }
                                      },
                                    ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      profile.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  if (profile.isActive)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'ACTIVE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              subtitle: Text(
                                '${profile.avoidIngredients.length} ingredients to avoid',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.info_outline),
                                onPressed: () => _showProfileDetails(profile),
                                tooltip: 'View details',
                              ),
                              onTap: () => _activateProfile(profile.id),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // TODO: Future feature - Custom profiles
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: OutlinedButton.icon(
                    //     onPressed: () {
                    //       // Navigate to custom profile creation screen
                    //     },
                    //     icon: const Icon(Icons.add),
                    //     label: const Text('Create Custom Profile'),
                    //     style: OutlinedButton.styleFrom(
                    //       padding: const EdgeInsets.symmetric(vertical: 12),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
    );
  }
}
