import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/scan_history_item.dart';
import '../services/food_api_service.dart';
import '../services/haptic_service.dart';
import '../services/hive_service.dart';
import '../services/ingredient_analysis_service.dart';
import '../services/pro_status_service.dart';
import '../services/profile_service.dart';
import 'product_not_found_screen.dart';
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
  final HiveService _hiveService = HiveService();
  final ProfileService _profileService = ProfileService();
  final ProStatusService _proStatusService = ProStatusService();
  final IngredientAnalysisService _analysisService =
      IngredientAnalysisService();

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
      // Check Pro status and get active profiles
      final isPro = await _proStatusService.isProUser();
      final activeProfiles = await _profileService.getActiveProfiles();

      if (activeProfiles.isEmpty) {
        if (mounted) {
          _showNoProfileDialog();
        }
        return;
      }

      // Fetch product data from API
      final productData = await _foodApiService.fetchProductByBarcode(
        barcodeValue,
      );

      // Extract product information
      final productName =
          _foodApiService.getProductName(productData) ?? 'Unknown Product';
      final brand =
          _foodApiService.getProductBrand(productData) ?? 'Unknown Brand';
      final ingredientsText = _foodApiService.getIngredientsText(productData);

      // Analyze ingredients against profile(s)
      final status = isPro
          ? _analysisService.analyzeAgainstMultipleProfiles(
              ingredientsText,
              activeProfiles,
            )
          : _analysisService.analyzeAgainstProfile(
              ingredientsText,
              activeProfiles.first,
            );

      // Get flagged ingredients for history
      List<String> flaggedIngredients;
      if (isPro) {
        final flaggedMap = _analysisService.getFlaggedIngredientsMultiProfile(
          ingredientsText,
          activeProfiles,
        );
        // Flatten all flagged ingredients from all profiles into a single list
        flaggedIngredients = flaggedMap.values
            .expand((list) => list)
            .toSet()
            .toList();
      } else {
        flaggedIngredients = _analysisService.getFlaggedIngredients(
          ingredientsText,
          activeProfiles.first,
        );
      }

      // Save to scan history
      final historyItem = ScanHistoryItem(
        barcode: barcodeValue,
        productName: productName,
        scanDate: DateTime.now(),
        resultStatus: status.toUpperCase(),
        flaggedIngredients: flaggedIngredients,
        brand: brand,
        imageUrl:
            null, // Optional: Add getImageUrl method to FoodApiService if needed
      );
      await _hiveService.saveScanHistory(historyItem);

      // Provide haptic feedback based on result
      if (status.toUpperCase() == 'SAFE') {
        await HapticService.success();
      } else if (status.toUpperCase() == 'AVOID') {
        await HapticService.error();
      } else if (status.toUpperCase() == 'CAUTION') {
        await HapticService.warning();
      } else {
        await HapticService.lightImpact();
      }

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
              flaggedIngredients: flaggedIngredients,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // Navigate to Product Not Found screen instead of showing error dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProductNotFoundScreen(barcode: barcodeValue),
          ),
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Barcode',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFA5B68D), // Muted Green
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Camera preview
          MobileScanner(controller: _controller, onDetect: _onBarcodeDetect),

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
                  border: Border.all(color: Colors.white, width: 3),
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
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
