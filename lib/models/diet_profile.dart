/// Represents a dietary profile with specific restrictions and cautions
class DietProfile {
  final String id;
  final String name;
  final bool isActive;
  final List<String> avoidIngredients; // Ingredients marked with ❌
  final List<String> cautionIngredients; // Ingredients marked with ⚠️

  DietProfile({
    required this.id,
    required this.name,
    this.isActive = false,
    required this.avoidIngredients,
    required this.cautionIngredients,
  });

  /// Creates a copy of this profile with the specified fields replaced
  DietProfile copyWith({
    String? id,
    String? name,
    bool? isActive,
    List<String>? avoidIngredients,
    List<String>? cautionIngredients,
  }) {
    return DietProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      avoidIngredients: avoidIngredients ?? this.avoidIngredients,
      cautionIngredients: cautionIngredients ?? this.cautionIngredients,
    );
  }

  /// Converts the profile to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive,
      'avoidIngredients': avoidIngredients,
      'cautionIngredients': cautionIngredients,
    };
  }

  /// Creates a profile from a JSON map
  factory DietProfile.fromJson(Map<String, dynamic> json) {
    return DietProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      isActive: json['isActive'] as bool? ?? false,
      avoidIngredients: List<String>.from(json['avoidIngredients'] as List),
      cautionIngredients: List<String>.from(json['cautionIngredients'] as List),
    );
  }

  @override
  String toString() {
    return 'DietProfile(id: $id, name: $name, isActive: $isActive)';
  }
}
