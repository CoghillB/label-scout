import 'package:flutter/material.dart';

import '../data/food_categories.dart';
import '../models/saved_food_item.dart';
import '../services/hive_service.dart';

/// Screen for manually adding a product to personal lists (Pro feature)
class ManualAddScreen extends StatefulWidget {
  final String barcode;

  const ManualAddScreen({
    super.key,
    required this.barcode,
  });

  @override
  State<ManualAddScreen> createState() => _ManualAddScreenState();
}

class _ManualAddScreenState extends State<ManualAddScreen> {
  final HiveService _hiveService = HiveService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  String _selectedRating = 'safe'; // 'safe' or 'avoid'
  String _selectedCategory = foodCategories.first;
  bool _isSaving = false;

  @override
  void dispose() {
    _productNameController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Create saved food item
      final item = SavedFoodItem(
        barcode: widget.barcode,
        productName: _productNameController.text.trim(),
        brand: _brandController.text.trim().isEmpty
            ? 'Unknown Brand'
            : _brandController.text.trim(),
        savedDate: DateTime.now(),
        status: _selectedRating,
        category: _selectedCategory,
      );

      // Save to Hive
      await _hiveService.saveItem(item);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added "${_productNameController.text.trim()}" to $_selectedCategory',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );

        // Return to home/scanner
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving item: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Manually'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green[200]!, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.green[700],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Add this product to your shopping memory',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[900],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Barcode display
                Text(
                  'Barcode: ${widget.barcode}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 24),

                // Product Name field
                TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name *',
                    hintText: 'Enter product name',
                    prefixIcon: Icon(Icons.shopping_basket),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Brand field (optional)
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    labelText: 'Brand (Optional)',
                    hintText: 'Enter brand name',
                    prefixIcon: Icon(Icons.business),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 24),

                // My Rating section
                const Text(
                  'My Rating *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _RatingCard(
                        title: 'Safe',
                        subtitle: 'Good to buy',
                        icon: Icons.check_circle,
                        iconColor: Colors.green,
                        isSelected: _selectedRating == 'safe',
                        onTap: () {
                          setState(() {
                            _selectedRating = 'safe';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _RatingCard(
                        title: 'Avoid',
                        subtitle: 'Don\'t buy',
                        icon: Icons.cancel,
                        iconColor: Colors.red,
                        isSelected: _selectedRating == 'avoid',
                        onTap: () {
                          setState(() {
                            _selectedRating = 'avoid';
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Category dropdown
                const Text(
                  'Category *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: foodCategories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 32),

                // Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSaving ? null : _handleSave,
                    icon: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(
                      _isSaving ? 'Saving...' : 'Add to My Lists',
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

                // Cancel button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _isSaving
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child: const Text(
                      'Cancel',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget for rating selection cards
class _RatingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _RatingCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? iconColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? iconColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? iconColor : Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? iconColor : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? iconColor.withOpacity(0.8) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
