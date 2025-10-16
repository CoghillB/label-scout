import 'package:flutter/material.dart';

import '../services/iap_service.dart';

/// Screen displaying Pro features and upgrade benefits
class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  Future<void> _handlePurchase(BuildContext context) async {
    final iapService = IAPService();
    final success = await iapService.showPurchaseDialog(context);
    
    if (success && context.mounted) {
      // Navigate back after successful purchase
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final iapService = IAPService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade to Pro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(32),
              child: const Column(
                children: [
                  Icon(
                    Icons.star,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Label Scout Pro',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Unlock the full potential',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Features list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pro Features',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildFeatureCard(
                    icon: Icons.list_alt,
                    title: 'My Lists',
                    description: 'Save your safe foods and items to avoid. Organize by category for quick reference.',
                    color: Colors.blue,
                  ),
                  
                  _buildFeatureCard(
                    icon: Icons.block,
                    title: 'Ad-Free Experience',
                    description: 'Enjoy uninterrupted scanning without any advertisements.',
                    color: Colors.green,
                  ),
                  
                  _buildFeatureCard(
                    icon: Icons.people,
                    title: 'Multiple Profiles',
                    description: 'Create and manage multiple dietary profiles for different family members.',
                    color: Colors.orange,
                  ),
                  
                  _buildFeatureCard(
                    icon: Icons.history,
                    title: 'Scan History',
                    description: 'Access your complete scanning history and revisit past product checks.',
                    color: Colors.purple,
                  ),
                  
                  _buildFeatureCard(
                    icon: Icons.support,
                    title: 'Priority Support',
                    description: 'Get faster response times and dedicated customer support.',
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Price display
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      iapService.getProPrice(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Subscription',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Upgrade button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _handlePurchase(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Purchase Now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Info text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '💡 Simulated purchase for testing',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
