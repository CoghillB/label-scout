import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../services/food_api_service.dart';
import '../services/profile_service.dart';
import 'result_screen.dart';

/// Full-screen barcode scanner view using the device camera
class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final MobileScannerController _controller = MobileScannerController();
  final FoodApiService _foodApiService = FoodApiService();
  final ProfileService _profileService = ProfileService();
  
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Handles barcode detection and processing
  void _onBarcodeDetect(BarcodeCapture barcodeCapture) async {
    // Prevent multiple simultaneous scans
    if (_isProcessing) return;
    
    final barcode = barcodeCapture.barcodes.firstOrNull;
    if (barcode == null || barcode.rawValue == null) return;
    
    setState(() {
      _isProcessing = true;
    });
    
    final barcodeValue = barcode.rawValue!;
    
    try {
      // Check if a profile is active
      final activeProfile = await _profileService.getActiveProfile();
      
      if (activeProfile == null) {
        if (mounted) {
          _showNoProfileDialog();
        }
        return;
      }
      
      // Fetch product data from API
      final productData = await _foodApiService.fetchProductByBarcode(barcodeValue);
      
      // Extract product information
      final productName = _foodApiService.getProductName(productData) ?? 'Unknown Product';
      final brand = _foodApiService.getProductBrand(productData) ?? 'Unknown Brand';
      final ingredientsText = _foodApiService.getIngredientsText(productData);
      
      // TODO: In future versions, analyze ingredients against the active profile
      // For now, we'll use a simple placeholder status
      final status = 'safe'; // This should be calculated based on ingredient analysis
      
      if (mounted) {
        // Navigate to result screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              barcode: barcodeValue,
              productName: productName,
              brand: brand,
              ingredientsText: ingredientsText,
              status: status,
            ),
          ),
        );
      }
      
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  /// Shows dialog when no dietary profile is selected
  void _showNoProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Profile Selected'),
        content: const Text(
          'Please select a dietary profile in the Profiles tab before scanning products.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to scanner screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Shows error dialog
  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Camera preview
          MobileScanner(
            controller: _controller,
            onDetect: _onBarcodeDetect,
          ),
          
          // Scanning overlay
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Processing...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          
          // Scanning guide overlay
          if (!_isProcessing)
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          
          // Instructions
          if (!_isProcessing)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Position the barcode within the frame',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
