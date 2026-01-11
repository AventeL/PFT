import 'package:uuid/uuid.dart';
import '../entities/exercise.dart';
import '../repositories/exercise_repository.dart';

/// Use case to create a custom exercise
class CreateCustomExercise {
  final ExerciseRepository repository;
  final _uuid = const Uuid();

  CreateCustomExercise({required this.repository});

  Future<Exercise> call({
    required String name,
    required String muscleGroup,
    required String category,
    required String equipmentType,
    String? instructions,
  }) async {
    // Validation: name not empty
    if (name.trim().isEmpty) {
      throw ArgumentError('Exercise name cannot be empty');
    }

    // Create exercise with custom flag
    final exercise = Exercise(
      id: _uuid.v4(),
      name: name.trim(),
      muscleGroup: _parseEnumFromString(muscleGroup),
      category: _parseCategory(category),
      equipmentType: _parseEquipmentType(equipmentType),
      isCustom: true,
      instructions: instructions,
      createdAt: DateTime.now(),
    );

    return await repository.createExercise(exercise);
  }

  // Helper methods to parse enums
  dynamic _parseEnumFromString(String value) {
    // This will be implemented based on enum values
    return value;
  }

  dynamic _parseCategory(String value) {
    return value;
  }

  dynamic _parseEquipmentType(String value) {
    return value;
  }
}

