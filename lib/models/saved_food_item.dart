import 'package:hive/hive.dart';

part 'saved_food_item.g.dart';

/// Represents a saved food item in the user's lists
@HiveType(typeId: 0)
class SavedFoodItem extends HiveObject {
  @HiveField(0)
  String barcode;

  @HiveField(1)
  String productName;

  @HiveField(2)
  String brand;

  @HiveField(3)
  DateTime savedDate;

  @HiveField(4)
  String status; // 'safe' or 'avoid'

  @HiveField(5)
  String category; // e.g., 'Snacks', 'Pantry', etc.

  SavedFoodItem({
    required this.barcode,
    required this.productName,
    required this.brand,
    required this.savedDate,
    required this.status,
    required this.category,
  });

  /// Creates a copy of this item with the specified fields replaced
  SavedFoodItem copyWith({
    String? barcode,
    String? productName,
    String? brand,
    DateTime? savedDate,
    String? status,
    String? category,
  }) {
    return SavedFoodItem(
      barcode: barcode ?? this.barcode,
      productName: productName ?? this.productName,
      brand: brand ?? this.brand,
      savedDate: savedDate ?? this.savedDate,
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'SavedFoodItem(barcode: $barcode, productName: $productName, status: $status, category: $category)';
  }
}
