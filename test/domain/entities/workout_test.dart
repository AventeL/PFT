import 'package:flutter_test/flutter_test.dart';
import 'package:pft/domain/entities/workout.dart';
import 'package:pft/domain/entities/workout_exercise.dart';

void main() {
  group('Workout Entity', () {
    test('should create Workout with all properties', () {
      // Arrange
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      final exercises = [
        const WorkoutExercise(
          exerciseId: 'ex1',
          order: 0,
          targetSets: 3,
        ),
      ];

      // Act
      final workout = Workout(
        id: 'test-id',
        name: 'Push Day',
        description: 'Chest and triceps workout',
        exercises: exercises,
        notes: 'Test notes',
        createdAt: createdAt,
        updatedAt: updatedAt,
        isTemplate: false,
      );

      // Assert
      expect(workout.id, 'test-id');
      expect(workout.name, 'Push Day');
      expect(workout.description, 'Chest and triceps workout');
      expect(workout.exercises, exercises);
      expect(workout.notes, 'Test notes');
      expect(workout.createdAt, createdAt);
      expect(workout.updatedAt, updatedAt);
      expect(workout.isTemplate, false);
    });

    test('should create Workout with optional fields as null', () {
      // Arrange
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();

      // Act
      final workout = Workout(
        id: 'test-id',
        name: 'Push Day',
        exercises: const [],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // Assert
      expect(workout.description, isNull);
      expect(workout.notes, isNull);
      expect(workout.isTemplate, false);
    });

    test('should support copyWith', () {
      // Arrange
      final workout = Workout(
        id: 'test-id',
        name: 'Push Day',
        exercises: const [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Act
      final modified = workout.copyWith(
        name: 'Pull Day',
        description: 'Back and biceps',
      );

      // Assert
      expect(modified.id, workout.id);
      expect(modified.name, 'Pull Day');
      expect(modified.description, 'Back and biceps');
      expect(modified.exercises, workout.exercises);
      expect(modified.createdAt, workout.createdAt);
    });

    test('should be equal when properties are the same', () {
      // Arrange
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      final exercises = [
        const WorkoutExercise(
          exerciseId: 'ex1',
          order: 0,
          targetSets: 3,
        ),
      ];

      final workout1 = Workout(
        id: 'test-id',
        name: 'Push Day',
        exercises: exercises,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      final workout2 = Workout(
        id: 'test-id',
        name: 'Push Day',
        exercises: exercises,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // Assert
      expect(workout1, workout2);
    });

    test('should not be equal when properties differ', () {
      // Arrange
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();

      final workout1 = Workout(
        id: 'test-id-1',
        name: 'Push Day',
        exercises: const [],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      final workout2 = Workout(
        id: 'test-id-2',
        name: 'Pull Day',
        exercises: const [],
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      // Assert
      expect(workout1, isNot(workout2));
    });
  });

  group('WorkoutExercise Entity', () {
    test('should create WorkoutExercise with all properties', () {
      // Arrange & Act
      const workoutExercise = WorkoutExercise(
        exerciseId: 'ex-123',
        order: 0,
        targetSets: 4,
        restTime: Duration(seconds: 90),
      );

      // Assert
      expect(workoutExercise.exerciseId, 'ex-123');
      expect(workoutExercise.order, 0);
      expect(workoutExercise.targetSets, 4);
      expect(workoutExercise.restTime, const Duration(seconds: 90));
    });

    test('should create WorkoutExercise with optional restTime as null', () {
      // Arrange & Act
      const workoutExercise = WorkoutExercise(
        exerciseId: 'ex-123',
        order: 0,
        targetSets: 3,
      );

      // Assert
      expect(workoutExercise.restTime, isNull);
    });

    test('should support copyWith', () {
      // Arrange
      const workoutExercise = WorkoutExercise(
        exerciseId: 'ex-123',
        order: 0,
        targetSets: 3,
      );

      // Act
      final modified = workoutExercise.copyWith(
        targetSets: 5,
        restTime: const Duration(seconds: 120),
      );

      // Assert
      expect(modified.exerciseId, workoutExercise.exerciseId);
      expect(modified.order, workoutExercise.order);
      expect(modified.targetSets, 5);
      expect(modified.restTime, const Duration(seconds: 120));
    });

    test('should be equal when properties are the same', () {
      // Arrange
      const workoutExercise1 = WorkoutExercise(
        exerciseId: 'ex-123',
        order: 0,
        targetSets: 3,
        restTime: Duration(seconds: 90),
      );

      const workoutExercise2 = WorkoutExercise(
        exerciseId: 'ex-123',
        order: 0,
        targetSets: 3,
        restTime: Duration(seconds: 90),
      );

      // Assert
      expect(workoutExercise1, workoutExercise2);
    });

    test('should not be equal when properties differ', () {
      // Arrange
      const workoutExercise1 = WorkoutExercise(
        exerciseId: 'ex-123',
        order: 0,
        targetSets: 3,
      );

      const workoutExercise2 = WorkoutExercise(
        exerciseId: 'ex-456',
        order: 1,
        targetSets: 4,
      );

      // Assert
      expect(workoutExercise1, isNot(workoutExercise2));
    });
  });
}
