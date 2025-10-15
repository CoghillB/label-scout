import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for fetching food product data from Open Food Facts API
class FoodApiService {
  static const String _baseUrl = 'https://world.openfoodfacts.org/api/v0';
  
  /// Fetches product information by barcode from Open Food Facts API
  /// 
  /// Returns a Map containing the product data if successful
  /// Throws an exception if the request fails or product is not found
  Future<Map<String, dynamic>> fetchProductByBarcode(String barcode) async {
    try {
      final url = Uri.parse('$_baseUrl/product/$barcode.json');
      
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'LabelScout - Flutter App - Version 1.0',
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        
        // Check if product was found
        final status = data['status'] as int?;
        if (status == 0) {
          throw Exception('Product not found for barcode: $barcode');
        }
        
        return data;
      } else if (response.statusCode == 404) {
        throw Exception('Product not found for barcode: $barcode');
      } else {
        throw Exception('Failed to fetch product: HTTP ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Error fetching product data: $e');
    }
  }
  
  /// Extracts the ingredients text from the API response
  ///
  /// Returns the ingredients as a string, or null if not available
  String? getIngredientsText(Map<String, dynamic> productData) {
    try {
      final product = productData['product'] as Map<String, dynamic>?;
      if (product == null) return null;
      
      // Try to get ingredients in English first
      final ingredientsText = product['ingredients_text_en'] as String? ??
          product['ingredients_text'] as String?;
      
      return ingredientsText;
    } catch (e) {
      return null;
    }
  }
  
  /// Extracts the product name from the API response
  String? getProductName(Map<String, dynamic> productData) {
    try {
      final product = productData['product'] as Map<String, dynamic>?;
      if (product == null) return null;
      
      return product['product_name'] as String? ??
          product['product_name_en'] as String?;
    } catch (e) {
      return null;
    }
  }
  
  /// Extracts the product brand from the API response
  String? getProductBrand(Map<String, dynamic> productData) {
    try {
      final product = productData['product'] as Map<String, dynamic>?;
      if (product == null) return null;
      
      return product['brands'] as String?;
    } catch (e) {
      return null;
    }
  }
  
  /// Extracts allergens from the API response
  List<String>? getAllergens(Map<String, dynamic> productData) {
    try {
      final product = productData['product'] as Map<String, dynamic>?;
      if (product == null) return null;
      
      final allergensText = product['allergens'] as String?;
      if (allergensText == null || allergensText.isEmpty) return null;
      
      // Parse comma-separated allergens
      return allergensText
          .split(',')
          .map((a) => a.trim().toLowerCase())
          .where((a) => a.isNotEmpty)
          .toList();
    } catch (e) {
      return null;
    }
  }
  
  // TODO: Future enhancement - Implement ingredient parsing logic
  // This will compare product ingredients against dietary profile restrictions
  // and return a list of flagged ingredients (both avoid and caution)
  //
  // Example structure:
  // Map<String, dynamic> analyzeIngredients(
  //   String ingredientsText,
  //   DietProfile activeProfile,
  // ) {
  //   return {
  //     'avoid': [...], // List of ingredients to avoid found in product
  //     'caution': [...], // List of caution ingredients found in product
  //     'safe': true/false, // Overall safety based on active profile
  //   };
  // }
}
