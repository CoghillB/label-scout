import 'package:flutter/material.dart';

/// Settings screen placeholder for future features
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
          
          // TODO: Future settings options
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
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Scan History'),
            subtitle: const Text('Coming soon - Pro feature'),
            trailing: const Icon(Icons.chevron_right),
            enabled: false,
            onTap: () {
              // TODO: Navigate to scan history (Pro feature)
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('My Lists'),
            subtitle: const Text('Coming soon - Pro feature'),
            trailing: const Icon(Icons.chevron_right),
            enabled: false,
            onTap: () {
              // TODO: Navigate to My Lists (Pro feature)
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Upgrade to Pro'),
            subtitle: const Text('Coming soon'),
            trailing: const Icon(Icons.chevron_right),
            enabled: false,
            onTap: () {
              // TODO: Navigate to upgrade screen
            },
          ),
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
