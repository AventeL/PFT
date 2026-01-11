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
    test('MuscleGroup should have correct display names', () {
      expect(MuscleGroup.chest.displayName, 'Chest');
      expect(MuscleGroup.back.displayName, 'Back');
      expect(MuscleGroup.shoulders.displayName, 'Shoulders');
      expect(MuscleGroup.arms.displayName, 'Arms');
      expect(MuscleGroup.legs.displayName, 'Legs');
      expect(MuscleGroup.core.displayName, 'Core');
    });

    test('ExerciseCategory should have correct display names', () {
      expect(ExerciseCategory.compound.displayName, 'Compound');
      expect(ExerciseCategory.isolation.displayName, 'Isolation');
    });

    test('EquipmentType should have correct display names', () {
      expect(EquipmentType.barbell.displayName, 'Barbell');
      expect(EquipmentType.dumbbell.displayName, 'Dumbbell');
      expect(EquipmentType.machine.displayName, 'Machine');
      expect(EquipmentType.bodyweight.displayName, 'Bodyweight');
      expect(EquipmentType.cable.displayName, 'Cable');
    });
  });
}

