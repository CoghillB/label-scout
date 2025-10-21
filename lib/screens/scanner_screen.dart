import 'package:flutter/material.dart';

import '../services/profile_service.dart';
import 'barcode_scanner_view.dart';

/// Main scanner screen with a button to launch the barcode scanner
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ProfileService _profileService = ProfileService();
  bool _hasActiveProfile = false;
  bool _isChecking = true;
  List<String> _activeProfileNames = [];

  @override
  void initState() {
    super.initState();
    _checkForActiveProfile();
  }

  /// Check if user has selected at least one dietary profile
  Future<void> _checkForActiveProfile() async {
    try {
      final activeProfiles = await _profileService.getActiveProfiles();
      if (mounted) {
        setState(() {
          _hasActiveProfile = activeProfiles.isNotEmpty;
          _activeProfileNames = activeProfiles.map((p) => p.name).toList();
          _isChecking = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasActiveProfile = false;
          _isChecking = false;
        });
      }
    }
  }

  /// Handle scan button press - check for profile before opening camera
  void _handleScanPress() async {
    await _checkForActiveProfile();
    
    if (!_hasActiveProfile) {
      _showSelectProfilePrompt();
      return;
    }

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BarcodeScannerView(),
        ),
      );
    }
  }

  /// Show a bottom sheet prompting user to select a profile
  void _showSelectProfilePrompt() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (buildContext) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_outline,
              size: 64,
              color: Theme.of(buildContext).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select a Dietary Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Before scanning, please choose at least one dietary profile so we can analyze ingredients for you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(buildContext),
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Got It',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(buildContext),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40), // Top spacing to center content when there's space
              // Icon for visual appeal
              Icon(
                Icons.qr_code_scanner,
                size: 120,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 32),
              
              // Instructions
              Text(
                'Scan Product Barcode',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              Text(
                'Point your camera at a product barcode to check if it matches your dietary preferences.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Profile status indicator
              if (!_isChecking && _hasActiveProfile)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _activeProfileNames.length == 1
                              ? 'Active profile: ${_activeProfileNames.first}'
                              : 'Active profiles: ${_activeProfileNames.join(', ')}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              // Warning when no profile selected
              if (!_isChecking && !_hasActiveProfile)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'No dietary profile selected',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),
              
              // Scan button
              ElevatedButton.icon(
                onPressed: _isChecking ? null : _handleScanPress,
                icon: const Icon(Icons.camera_alt, size: 28),
                label: Text(
                  _isChecking ? 'Loading...' : 'Scan Barcode',
                  style: const TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // // Ad placeholder (shown only for free users)
              // const AdPlaceholder(
              //   size: AdSize.banner,
              //   margin: EdgeInsets.symmetric(vertical: 12),
              // ),
              
              // Tip text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tap the Profiles tab below to select your dietary preferences.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
