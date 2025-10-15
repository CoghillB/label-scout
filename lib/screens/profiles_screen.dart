import 'package:flutter/material.dart';
import '../models/diet_profile.dart';
import '../services/profile_service.dart';

/// Screen displaying dietary profiles with radio button selection
class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  final ProfileService _profileService = ProfileService();
  List<DietProfile> _profiles = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  /// Loads all profiles with their active state
  Future<void> _loadProfiles() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final profiles = await _profileService.getAllProfiles();

      setState(() {
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

  /// Activates a profile and updates the UI
  Future<void> _activateProfile(String profileId) async {
    try {
      await _profileService.activateProfile(profileId);
      
      // Reload profiles to update active state
      await _loadProfiles();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile activated: ${_getProfileName(profileId)}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error activating profile: $e'),
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
                        onPressed: _loadProfiles,
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
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Select one dietary profile to use when scanning products',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
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
                              leading: Radio<String>(
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
                              title: Text(
                                profile.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
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
