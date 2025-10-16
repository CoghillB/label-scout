import 'package:flutter/material.dart';

import '../widgets/ad_placeholder.dart';
import 'barcode_scanner_view.dart';

/// Main scanner screen with a button to launch the barcode scanner
class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(height: 48),
              
              // Scan button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BarcodeScannerView(),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt, size: 28),
                label: const Text(
                  'Scan Barcode',
                  style: TextStyle(fontSize: 18),
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
              
              // Ad placeholder (shown only for free users)
              const AdPlaceholder(
                size: AdSize.banner,
                margin: EdgeInsets.symmetric(vertical: 12),
              ),
              
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
                        'Make sure to select your dietary profile in the Profiles tab first!',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
