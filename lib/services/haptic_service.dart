import 'package:flutter/services.dart';

/// Service for providing haptic feedback throughout the app
/// Centralizes vibration patterns for consistency using Flutter's built-in HapticFeedback
class HapticService {
  // Light tap for subtle interactions
  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  // Medium feedback for standard interactions
  static Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  // Strong feedback for important actions
  static Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  // Success pattern (selection click)
  static Future<void> success() async {
    await HapticFeedback.selectionClick();
  }

  // Error pattern (vibrate)
  static Future<void> error() async {
    await HapticFeedback.vibrate();
  }

  // Warning pattern (selection click)
  static Future<void> warning() async {
    await HapticFeedback.selectionClick();
  }
}
