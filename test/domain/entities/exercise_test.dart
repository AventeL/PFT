import 'package:flutter_test/flutter_test.dart';
import 'package:pft/domain/entities/exercise.dart';
import 'package:pft/domain/entities/exercise_enums.dart';

void main() {
  group('Exercise Entity', () {
    test('should create Exercise with all properties', () {
      // Arrange
      final createdAt = DateTime.now();

      // Act
      final exercise = Exercise(
        id: 'test-id',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        instructions: 'Test instructions',
        createdAt: createdAt,
      );

      // Assert
      expect(exercise.id, 'test-id');
      expect(exercise.name, 'Bench Press');
      expect(exercise.muscleGroup, MuscleGroup.chest);
      expect(exercise.category, ExerciseCategory.compound);
      expect(exercise.equipmentType, EquipmentType.barbell);
      expect(exercise.isCustom, false);
      expect(exercise.instructions, 'Test instructions');
      expect(exercise.createdAt, createdAt);
    });

    test('should support copyWith', () {
      // Arrange
      final exercise = Exercise(
        id: 'test-id',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      final modified = exercise.copyWith(name: 'Incline Bench Press');

      // Assert
      expect(modified.id, exercise.id);
      expect(modified.name, 'Incline Bench Press');
      expect(modified.muscleGroup, exercise.muscleGroup);
    });

    test('should be equal when properties are the same', () {
      // Arrange
      final createdAt = DateTime.now();
      final exercise1 = Exercise(
        id: 'test-id',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: createdAt,
      );
      final exercise2 = Exercise(
        id: 'test-id',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: createdAt,
      );

      // Assert
      expect(exercise1, exercise2);
    });

    test('should not be equal when properties differ', () {
      // Arrange
      final createdAt = DateTime.now();
      final exercise1 = Exercise(
        id: 'test-id-1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: createdAt,
      );
      final exercise2 = Exercise(
        id: 'test-id-2',
        name: 'Squat',
        muscleGroup: MuscleGroup.legs,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: createdAt,
      );

      // Assert
      expect(exercise1, isNot(exercise2));
    });
  });

  group('Exercise Enums', () {
    test('MuscleGroup enum should have all values', () {
      expect(MuscleGroup.values.length, 6);
      expect(MuscleGroup.values, contains(MuscleGroup.chest));
      expect(MuscleGroup.values, contains(MuscleGroup.back));
      expect(MuscleGroup.values, contains(MuscleGroup.shoulders));
      expect(MuscleGroup.values, contains(MuscleGroup.arms));
      expect(MuscleGroup.values, contains(MuscleGroup.legs));
      expect(MuscleGroup.values, contains(MuscleGroup.core));
    });

    test('ExerciseCategory enum should have all values', () {
      expect(ExerciseCategory.values.length, 2);
      expect(ExerciseCategory.values, contains(ExerciseCategory.compound));
      expect(ExerciseCategory.values, contains(ExerciseCategory.isolation));
    });

    test('EquipmentType enum should have all values', () {
      expect(EquipmentType.values.length, 5);
      expect(EquipmentType.values, contains(EquipmentType.barbell));
      expect(EquipmentType.values, contains(EquipmentType.dumbbell));
      expect(EquipmentType.values, contains(EquipmentType.machine));
      expect(EquipmentType.values, contains(EquipmentType.bodyweight));
      expect(EquipmentType.values, contains(EquipmentType.cable));
    });

    test('Enum names should be lowercase', () {
      expect(MuscleGroup.chest.name, 'chest');
      expect(ExerciseCategory.compound.name, 'compound');
      expect(EquipmentType.barbell.name, 'barbell');
    });
  });
}
