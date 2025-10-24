import '../models/diet_profile.dart';

/// Service for analyzing ingredients against dietary profiles
class IngredientAnalysisService {
  /// Checks if a target ingredient is present in the ingredients text
  /// Uses word boundary matching to avoid false positives
  /// For example, "oat" won't match "goat" or "boat"
  bool _containsIngredient(String ingredientsText, String targetIngredient) {
    final ingredientsLower = ingredientsText.toLowerCase();
    final targetLower = targetIngredient.toLowerCase();

    // Create a regex pattern with word boundaries
    // \b matches word boundaries (spaces, punctuation, start/end of string)
    final pattern = RegExp(r'\b' + RegExp.escape(targetLower) + r'\b');

    return pattern.hasMatch(ingredientsLower);
  }

  /// Analyzes ingredients against a single profile
  /// Returns 'avoid' if any avoid ingredients are found
  /// Returns 'caution' if any caution ingredients are found
  /// Returns 'safe' otherwise
  String analyzeAgainstProfile(String? ingredientsText, DietProfile profile) {
    if (ingredientsText == null || ingredientsText.isEmpty) {
      return 'unknown';
    }

    // Check for avoid ingredients
    for (final avoid in profile.avoidIngredients) {
      if (_containsIngredient(ingredientsText, avoid)) {
        return 'avoid';
      }
    }

    // Check for caution ingredients
    for (final caution in profile.cautionIngredients) {
      if (_containsIngredient(ingredientsText, caution)) {
        return 'caution';
      }
    }

    return 'safe';
  }

  /// Analyzes ingredients against multiple profiles (Pro feature)
  /// Returns the most restrictive result:
  /// - 'avoid' if ANY profile says avoid
  /// - 'caution' if ANY profile says caution (and none say avoid)
  /// - 'safe' if ALL profiles say safe
  /// - 'unknown' if ingredients text is missing
  String analyzeAgainstMultipleProfiles(
    String? ingredientsText,
    List<DietProfile> profiles,
  ) {
    if (ingredientsText == null || ingredientsText.isEmpty) {
      return 'unknown';
    }

    if (profiles.isEmpty) {
      return 'unknown';
    }

    bool hasAvoid = false;
    bool hasCaution = false;

    for (final profile in profiles) {
      final result = analyzeAgainstProfile(ingredientsText, profile);

      if (result == 'avoid') {
        hasAvoid = true;
        break; // Most restrictive - can return immediately
      } else if (result == 'caution') {
        hasCaution = true;
      }
    }

    if (hasAvoid) return 'avoid';
    if (hasCaution) return 'caution';
    return 'safe';
  }

  /// Gets a list of flagged ingredients from the text
  List<String> getFlaggedIngredients(
    String? ingredientsText,
    DietProfile profile,
  ) {
    if (ingredientsText == null || ingredientsText.isEmpty) {
      return [];
    }

    final flagged = <String>[];

    // Check avoid ingredients
    for (final avoid in profile.avoidIngredients) {
      if (_containsIngredient(ingredientsText, avoid)) {
        flagged.add('❌ $avoid');
      }
    }

    // Check caution ingredients
    for (final caution in profile.cautionIngredients) {
      if (_containsIngredient(ingredientsText, caution)) {
        flagged.add('⚠️ $caution');
      }
    }

    return flagged;
  }

  /// Gets flagged ingredients from multiple profiles
  Map<String, List<String>> getFlaggedIngredientsMultiProfile(
    String? ingredientsText,
    List<DietProfile> profiles,
  ) {
    final results = <String, List<String>>{};

    for (final profile in profiles) {
      final flagged = getFlaggedIngredients(ingredientsText, profile);
      if (flagged.isNotEmpty) {
        results[profile.name] = flagged;
      }
    }

    return results;
  }

  /// Gets a user-friendly status message
  String getStatusMessage(String status) {
    switch (status) {
      case 'safe':
        return 'Safe to Consume';
      case 'avoid':
        return 'Avoid This Product';
      case 'caution':
        return 'Caution Required';
      case 'unknown':
        return 'No Ingredient Information Available';
      default:
        return 'Unable to Analyze';
    }
  }
}
