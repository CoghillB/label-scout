import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/pro_status_service.dart';
import 'manual_add_screen.dart';
import 'upgrade_screen.dart';

/// Screen shown when a product is not found in the database
class ProductNotFoundScreen extends StatefulWidget {
  final String barcode;

  const ProductNotFoundScreen({
    super.key,
    required this.barcode,
  });

  @override
  State<ProductNotFoundScreen> createState() => _ProductNotFoundScreenState();
}

class _ProductNotFoundScreenState extends State<ProductNotFoundScreen> {
  final ProStatusService _proStatusService = ProStatusService();
  bool _isProUser = false;

  @override
  void initState() {
    super.initState();
    _checkProStatus();
  }

  Future<void> _checkProStatus() async {
    final isPro = await _proStatusService.isProUser();
    setState(() {
      _isProUser = isPro;
    });
  }

  void _handleAddManually() {
    if (!_isProUser) {
      // Navigate to upgrade screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UpgradeScreen()),
      );
      return;
    }

    // Navigate to manual add form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManualAddScreen(barcode: widget.barcode),
      ),
    );
  }

  void _handleScanAgain() {
    // Return to scanner (close this screen)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Not Found'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Icon
              Icon(
                Icons.search_off,
                size: 100,
                color: Colors.orange[700],
              ),
              const SizedBox(height: 24),

              // Title
              const Text(
                'Product Not Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Barcode display with copy functionality
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Barcode: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.barcode,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: widget.barcode),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Barcode copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.copy,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Message
              const Text(
                'This product isn\'t in our database yet.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Info box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue[700],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What you can do:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• Add it manually to your personal list\n'
                            '• Try scanning the barcode again\n'
                            '• Check the ingredients label directly',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Action buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _handleAddManually,
                  icon: Icon(_isProUser ? Icons.add : Icons.lock),
                  label: Text(
                    _isProUser
                        ? 'Add Manually to My Lists'
                        : 'Upgrade to Add Manually',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _handleScanAgain,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text(
                    'Scan Again',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Help text
              Text(
                'Our database is powered by Open Food Facts, '
                'a collaborative project with millions of products.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
