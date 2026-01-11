import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_enums.dart';

/// Exercise model - Data layer
/// Handles serialization/deserialization for database and JSON
class ExerciseModel {
  final String id;
  final String name;
  final String muscleGroup;
  final String category;
  final String equipmentType;
  final bool isCustom;
  final String? instructions;
  final DateTime createdAt;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.category,
    required this.equipmentType,
    required this.isCustom,
    this.instructions,
    required this.createdAt,
  });

  /// Create ExerciseModel from JSON
  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      muscleGroup: json['muscleGroup'] as String,
      category: json['category'] as String,
      equipmentType: json['equipmentType'] as String,
      isCustom: json['isCustom'] as bool? ?? false,
      instructions: json['instructions'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  /// Create ExerciseModel from database map
  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'] as String,
      name: map['name'] as String,
      muscleGroup: map['muscle_group'] as String,
      category: map['category'] as String,
      equipmentType: map['equipment_type'] as String,
      isCustom: (map['is_custom'] as int) == 1,
      instructions: map['instructions'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'muscleGroup': muscleGroup,
      'category': category,
      'equipmentType': equipmentType,
      'isCustom': isCustom,
      'instructions': instructions,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Convert to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'muscle_group': muscleGroup,
      'category': category,
      'equipment_type': equipmentType,
      'is_custom': isCustom ? 1 : 0,
      'instructions': instructions,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Create ExerciseModel from Exercise entity
  factory ExerciseModel.fromEntity(Exercise exercise) {
    return ExerciseModel(
      id: exercise.id,
      name: exercise.name,
      muscleGroup: exercise.muscleGroup.name,
      category: exercise.category.name,
      equipmentType: exercise.equipmentType.name,
      isCustom: exercise.isCustom,
      instructions: exercise.instructions,
      createdAt: exercise.createdAt,
    );
  }

  /// Convert to Exercise entity
  Exercise toEntity() {
    return Exercise(
      id: id,
      name: name,
      muscleGroup: MuscleGroup.values.firstWhere(
        (e) => e.name == muscleGroup,
        orElse: () => MuscleGroup.chest,
      ),
      category: ExerciseCategory.values.firstWhere(
        (e) => e.name == category,
        orElse: () => ExerciseCategory.compound,
      ),
      equipmentType: EquipmentType.values.firstWhere(
        (e) => e.name == equipmentType,
        orElse: () => EquipmentType.barbell,
      ),
      isCustom: isCustom,
      instructions: instructions,
      createdAt: createdAt,
    );
  }
}

