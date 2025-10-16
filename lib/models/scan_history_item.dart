import 'package:hive/hive.dart';

part 'scan_history_item.g.dart';

/// Model for storing scan history records
/// Each scan creates a new history entry for tracking purposes
@HiveType(typeId: 1)
class ScanHistoryItem extends HiveObject {
  /// Barcode that was scanned
  @HiveField(0)
  final String barcode;

  /// Product name from API or 'Unknown Product'
  @HiveField(1)
  final String productName;

  /// When the scan occurred
  @HiveField(2)
  final DateTime scanDate;

  /// Result status: 'SAFE', 'CAUTION', 'AVOID', or 'UNKNOWN'
  @HiveField(3)
  final String resultStatus;

  /// List of ingredients that were flagged as problematic
  @HiveField(4)
  final List<String> flaggedIngredients;

  /// Optional brand name
  @HiveField(5)
  final String? brand;

  /// Optional image URL
  @HiveField(6)
  final String? imageUrl;

  ScanHistoryItem({
    required this.barcode,
    required this.productName,
    required this.scanDate,
    required this.resultStatus,
    required this.flaggedIngredients,
    this.brand,
    this.imageUrl,
  });

  /// Get color based on result status
  String get statusColor {
    switch (resultStatus.toUpperCase()) {
      case 'SAFE':
        return '#4CAF50'; // Green
      case 'CAUTION':
        return '#FF9800'; // Orange
      case 'AVOID':
        return '#F44336'; // Red
      default:
        return '#9E9E9E'; // Gray
    }
  }

  /// Get icon based on result status
  String get statusIcon {
    switch (resultStatus.toUpperCase()) {
      case 'SAFE':
        return '✓';
      case 'CAUTION':
        return '⚠';
      case 'AVOID':
        return '✗';
      default:
        return '?';
    }
  }
}
