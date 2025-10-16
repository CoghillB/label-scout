import 'package:flutter/material.dart';

import '../data/food_categories.dart';
import '../models/saved_food_item.dart';
import '../services/hive_service.dart';
import '../services/pro_status_service.dart';
import 'upgrade_screen.dart';

/// Result screen showing product information after scanning
class ResultScreen extends StatefulWidget {
  final String barcode;
  final String productName;
  final String brand;
  final String? ingredientsText;
  final String status; // 'safe' or 'avoid' - based on ingredient analysis

  const ResultScreen({
    super.key,
    required this.barcode,
    required this.productName,
    required this.brand,
    this.ingredientsText,
    required this.status,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ProStatusService _proStatusService = ProStatusService();
  final HiveService _hiveService = HiveService();
  
  bool _isProUser = false;
  bool _isAlreadySaved = false;

  @override
  void initState() {
    super.initState();
    _checkProStatus();
    _checkIfSaved();
  }

  Future<void> _checkProStatus() async {
    final isPro = await _proStatusService.isProUser();
    setState(() {
      _isProUser = isPro;
    });
  }

  void _checkIfSaved() {
    final isSaved = _hiveService.isItemSaved(widget.barcode);
    setState(() {
      _isAlreadySaved = isSaved;
    });
  }

  void _handleSaveToList() {
    if (!_isProUser) {
      // Navigate to upgrade screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UpgradeScreen()),
      );
      return;
    }

    // Show category selection dialog
    _showCategorySelectionDialog();
  }

  void _showCategorySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Category'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: foodCategories.map((category) {
              return ListTile(
                leading: Icon(
                  _getCategoryIcon(category),
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(category),
                onTap: () {
                  Navigator.pop(context);
                  _saveItem(category);
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Pantry':
        return Icons.kitchen;
      case 'Snacks':
        return Icons.cookie;
      case 'Produce':
        return Icons.eco;
      case 'Dairy':
        return Icons.local_drink;
      case 'Meat & Seafood':
        return Icons.set_meal;
      case 'Bakery':
        return Icons.bakery_dining;
      case 'Frozen':
        return Icons.ac_unit;
      case 'Beverages':
        return Icons.local_cafe;
      case 'Condiments':
        return Icons.restaurant;
      default:
        return Icons.shopping_basket;
    }
  }

  Future<void> _saveItem(String category) async {
    final item = SavedFoodItem(
      barcode: widget.barcode,
      productName: widget.productName,
      brand: widget.brand,
      savedDate: DateTime.now(),
      status: widget.status,
      category: category,
    );

    await _hiveService.saveItem(item);

    setState(() {
      _isAlreadySaved = true;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved to ${widget.status == 'safe' ? 'Safe Foods' : 'Avoid List'}!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSafe = widget.status == 'safe';
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Status header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isSafe 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Icon(
                    isSafe ? Icons.check_circle : Icons.cancel,
                    size: 80,
                    color: isSafe ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isSafe ? 'Safe to Consume' : 'Avoid This Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isSafe ? Colors.green[800] : Colors.red[800],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Product information
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Product', widget.productName),
                          const SizedBox(height: 8),
                          _buildInfoRow('Brand', widget.brand),
                          const SizedBox(height: 8),
                          _buildInfoRow('Barcode', widget.barcode),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  if (widget.ingredientsText != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ingredients',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.ingredientsText!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Save to My Lists button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isAlreadySaved ? null : _handleSaveToList,
                      icon: Icon(
                        _isAlreadySaved 
                            ? Icons.check 
                            : (_isProUser ? Icons.bookmark_add : Icons.lock),
                      ),
                      label: Text(
                        _isAlreadySaved 
                            ? 'Already Saved' 
                            : (_isProUser ? 'Save to My Lists' : 'Save to My Lists (Pro)'),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: _isAlreadySaved 
                            ? Colors.grey 
                            : (_isProUser 
                                ? Theme.of(context).colorScheme.primary 
                                : Colors.grey[400]),
                      ),
                    ),
                  ),
                  
                  if (!_isProUser) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Upgrade to Pro to save items to your personal lists',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 24),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.qr_code_scanner),
                          label: const Text('Scan Another'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          icon: const Icon(Icons.home),
                          label: const Text('Home'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
