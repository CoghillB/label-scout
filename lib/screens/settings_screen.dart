import 'package:flutter/material.dart';

import '../services/pro_status_service.dart';
import 'my_lists_screen.dart';
import 'upgrade_screen.dart';

/// Settings screen for app configuration and feature access
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ProStatusService _proStatusService = ProStatusService();
  bool _isProUser = false;

  @override
  void initState() {
    super.initState();
    _loadProStatus();
  }

  Future<void> _loadProStatus() async {
    final isPro = await _proStatusService.isProUser();
    setState(() {
      _isProUser = isPro;
    });
  }

  Future<void> _toggleProStatus() async {
    await _proStatusService.toggleProStatus();
    await _loadProStatus();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isProUser ? 'Pro features enabled' : 'Pro features disabled'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // App version
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Label Scout MVP v1.0.0',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          
          // Pro Features Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'PRO FEATURES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          
          // Pro Status Toggle (for testing)
          ListTile(
            leading: Icon(
              _isProUser ? Icons.star : Icons.star_border,
              color: _isProUser ? Colors.amber : null,
            ),
            title: const Text('Pro Status (Test Toggle)'),
            subtitle: Text(_isProUser ? 'Pro features enabled' : 'Free version'),
            trailing: Switch(
              value: _isProUser,
              onChanged: (value) => _toggleProStatus(),
              activeColor: Colors.amber,
            ),
          ),
          
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: _isProUser ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
            title: const Text('My Lists'),
            subtitle: Text(_isProUser ? 'View your saved items' : 'Pro feature'),
            trailing: _isProUser 
                ? const Icon(Icons.chevron_right) 
                : const Icon(Icons.lock, size: 20),
            enabled: _isProUser,
            onTap: _isProUser
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyListsScreen()),
                    );
                  }
                : null,
          ),
          
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Scan History'),
            subtitle: const Text('Coming soon - Pro feature'),
            trailing: const Icon(Icons.lock, size: 20),
            enabled: false,
            onTap: () {
              // TODO: Navigate to scan history (Pro feature)
            },
          ),
          
          const Divider(),
          
          // General Settings
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'GENERAL',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            subtitle: const Text('Coming soon'),
            trailing: const Icon(Icons.chevron_right),
            enabled: false,
            onTap: () {
              // TODO: Navigate to notifications settings
            },
          ),
          
          const Divider(),
          
          // Upgrade Section
          if (!_isProUser) ...[
            ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: const Text('Upgrade to Pro'),
              subtitle: const Text('Unlock all premium features'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpgradeScreen()),
                );
              },
            ),
            const Divider(),
          ],
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            trailing: const Icon(Icons.chevron_right),
            enabled: false,
            onTap: () {
              // TODO: Navigate to help screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            enabled: false,
            onTap: () {
              // TODO: Show about dialog
            },
          ),
          
          // Info card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📱 MVP Version',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This is the initial MVP release of Label Scout. '
                      'More features including scan history, custom lists, '
                      'and advanced ingredient analysis are coming soon!',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
