import 'dart:async';

import 'package:flutter/material.dart';

import 'pro_status_service.dart';

/// Service for handling simulated In-App Purchases
/// In a production app, this would integrate with Apple StoreKit or Google Play Billing
class IAPService {
  final ProStatusService _proStatusService = ProStatusService();
  
  /// Simulates a Pro version purchase
  /// Returns true if purchase was successful, false otherwise
  Future<bool> purchaseProVersion() async {
    // Simulate network latency and processing time
    await Future.delayed(const Duration(seconds: 2));
    
    // In a real implementation, this would:
    // 1. Connect to Apple/Google payment systems
    // 2. Process the payment
    // 3. Verify the transaction
    // 4. Update the user's status on your backend
    
    // For simulation purposes, we'll randomly succeed (90% success rate)
    final random = DateTime.now().millisecondsSinceEpoch % 10;
    final purchaseSuccessful = random < 9; // 90% success rate
    
    if (purchaseSuccessful) {
      // Update Pro status
      await _proStatusService.setProStatus(true);
    }
    
    return purchaseSuccessful;
  }
  
  /// Simulates restoring previous purchases
  /// Useful when user reinstalls the app or switches devices
  Future<bool> restorePurchases() async {
    // Simulate checking with platform stores
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real implementation, this would query Apple/Google for previous purchases
    // For simulation, we'll check if they already have Pro status
    final isPro = await _proStatusService.isProUser();
    
    return isPro;
  }
  
  /// Gets the localized price for the Pro version
  /// In a real implementation, this would fetch from the platform store
  String getProPrice() {
    // Simulated price - would come from App Store/Play Store
    return '\$9.99/month';
  }
  
  /// Shows a simulated purchase dialog
  Future<bool> showPurchaseDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _PurchaseDialog(),
    );
    
    return result ?? false;
  }
}

/// Simulated purchase dialog widget
class _PurchaseDialog extends StatefulWidget {
  const _PurchaseDialog();

  @override
  State<_PurchaseDialog> createState() => _PurchaseDialogState();
}

class _PurchaseDialogState extends State<_PurchaseDialog> {
  final IAPService _iapService = IAPService();
  bool _isProcessing = false;

  Future<void> _processPurchase() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final success = await _iapService.purchaseProVersion();
      
      if (mounted) {
        if (success) {
          Navigator.of(context).pop(true);
          _showSuccessMessage();
        } else {
          setState(() {
            _isProcessing = false;
          });
          _showErrorMessage();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        _showErrorMessage();
      }
    }
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Welcome to Label Scout Pro!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Purchase failed. Please try again.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.star, color: Colors.amber),
          SizedBox(width: 8),
          Text('Upgrade to Pro'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Unlock all premium features:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildFeature('✓ Save unlimited items to My Lists'),
          _buildFeature('✓ Ad-free experience'),
          _buildFeature('✓ Multiple active diet profiles'),
          _buildFeature('✓ Priority support'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _iapService.getProPrice(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '💡 This is a simulated purchase for testing',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.orange,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isProcessing ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isProcessing ? null : _processPurchase,
          child: _isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Purchase'),
        ),
      ],
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}
