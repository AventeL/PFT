import 'package:equatable/equatable.dart';
import 'exercise_enums.dart';

/// Exercise entity - Domain layer
/// Represents an exercise in the application
class Exercise extends Equatable {
  final String id;
  final String name;
  final MuscleGroup muscleGroup;
  final ExerciseCategory category;
  final EquipmentType equipmentType;
  final bool isCustom;
  final String? instructions;
  final DateTime createdAt;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.category,
    required this.equipmentType,
    required this.isCustom,
    this.instructions,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        muscleGroup,
        category,
        equipmentType,
        isCustom,
        instructions,
        createdAt,
      ];

  /// Create a copy of this exercise with modified fields
  Exercise copyWith({
    String? id,
    String? name,
    MuscleGroup? muscleGroup,
    ExerciseCategory? category,
    EquipmentType? equipmentType,
    bool? isCustom,
    String? instructions,
    DateTime? createdAt,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      category: category ?? this.category,
      equipmentType: equipmentType ?? this.equipmentType,
      isCustom: isCustom ?? this.isCustom,
      instructions: instructions ?? this.instructions,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

