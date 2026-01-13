import 'package:flutter_test/flutter_test.dart';
import 'package:pft/data/models/workout_model.dart';
import 'package:pft/data/models/workout_exercise_model.dart';
import 'package:pft/domain/entities/workout.dart';
import 'package:pft/domain/entities/workout_exercise.dart';

void main() {
  group('WorkoutModel', () {
    final testDate = DateTime(2026, 1, 12, 10, 30);

    test('should create WorkoutModel from JSON', () {
      // Arrange
      final json = {
        'id': 'workout-1',
        'name': 'Push Day',
        'description': 'Chest and triceps',
        'notes': 'Focus on form',
        'createdAt': '2026-01-12T10:30:00.000',
        'updatedAt': '2026-01-12T10:30:00.000',
        'isTemplate': true,
      };

      // Act
      final model = WorkoutModel.fromJson(json);

      // Assert
      expect(model.id, 'workout-1');
      expect(model.name, 'Push Day');
      expect(model.description, 'Chest and triceps');
      expect(model.notes, 'Focus on form');
      expect(model.isTemplate, true);
    });

    test('should create WorkoutModel from database map', () {
      // Arrange
      final map = {
        'id': 'workout-1',
        'name': 'Push Day',
        'description': 'Chest and triceps',
        'notes': 'Focus on form',
        'created_at': testDate.millisecondsSinceEpoch,
        'updated_at': testDate.millisecondsSinceEpoch,
        'is_template': 1,
      };

      // Act
      final model = WorkoutModel.fromMap(map);

      // Assert
      expect(model.id, 'workout-1');
      expect(model.name, 'Push Day');
      expect(model.description, 'Chest and triceps');
      expect(model.notes, 'Focus on form');
      expect(model.createdAt, testDate);
      expect(model.updatedAt, testDate);
      expect(model.isTemplate, true);
    });

    test('should convert WorkoutModel to JSON', () {
      // Arrange
      final model = WorkoutModel(
        id: 'workout-1',
        name: 'Push Day',
        description: 'Chest and triceps',
        notes: 'Focus on form',
        createdAt: testDate,
        updatedAt: testDate,
        isTemplate: true,
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], 'workout-1');
      expect(json['name'], 'Push Day');
      expect(json['description'], 'Chest and triceps');
      expect(json['notes'], 'Focus on form');
      expect(json['createdAt'], testDate.toIso8601String());
      expect(json['updatedAt'], testDate.toIso8601String());
      expect(json['isTemplate'], true);
    });

    test('should convert WorkoutModel to database map', () {
      // Arrange
      final model = WorkoutModel(
        id: 'workout-1',
        name: 'Push Day',
        description: 'Chest and triceps',
        notes: 'Focus on form',
        createdAt: testDate,
        updatedAt: testDate,
        isTemplate: true,
      );

      // Act
      final map = model.toMap();

      // Assert
      expect(map['id'], 'workout-1');
      expect(map['name'], 'Push Day');
      expect(map['description'], 'Chest and triceps');
      expect(map['notes'], 'Focus on form');
      expect(map['created_at'], testDate.millisecondsSinceEpoch);
      expect(map['updated_at'], testDate.millisecondsSinceEpoch);
      expect(map['is_template'], 1);
    });

    test('should create WorkoutModel from Workout entity', () {
      // Arrange
      final workout = Workout(
        id: 'workout-1',
        name: 'Push Day',
        description: 'Chest and triceps',
        exercises: const [],
        notes: 'Focus on form',
        createdAt: testDate,
        updatedAt: testDate,
        isTemplate: true,
      );

      // Act
      final model = WorkoutModel.fromEntity(workout);

      // Assert
      expect(model.id, workout.id);
      expect(model.name, workout.name);
      expect(model.description, workout.description);
      expect(model.notes, workout.notes);
      expect(model.createdAt, workout.createdAt);
      expect(model.updatedAt, workout.updatedAt);
      expect(model.isTemplate, workout.isTemplate);
    });

    test('should convert WorkoutModel to Workout entity', () {
      // Arrange
      final model = WorkoutModel(
        id: 'workout-1',
        name: 'Push Day',
        createdAt: testDate,
        updatedAt: testDate,
      );
      final exercises = [
        const WorkoutExercise(
          exerciseId: 'ex-1',
          order: 0,
          targetSets: 3,
        ),
      ];

      // Act
      final workout = model.toEntity(exercises);

      // Assert
      expect(workout.id, model.id);
      expect(workout.name, model.name);
      expect(workout.exercises, exercises);
      expect(workout.createdAt, model.createdAt);
      expect(workout.updatedAt, model.updatedAt);
    });

    test('should handle null optional fields in JSON', () {
      // Arrange
      final json = {
        'id': 'workout-1',
        'name': 'Push Day',
        'description': null,
        'notes': null,
        'createdAt': '2026-01-12T10:30:00.000',
        'updatedAt': '2026-01-12T10:30:00.000',
      };

      // Act
      final model = WorkoutModel.fromJson(json);

      // Assert
      expect(model.description, isNull);
      expect(model.notes, isNull);
      expect(model.isTemplate, false);
    });

    test('should handle null optional fields in database map', () {
      // Arrange
      final map = {
        'id': 'workout-1',
        'name': 'Push Day',
        'description': null,
        'notes': null,
        'created_at': testDate.millisecondsSinceEpoch,
        'updated_at': testDate.millisecondsSinceEpoch,
        'is_template': 0,
      };

      // Act
      final model = WorkoutModel.fromMap(map);

      // Assert
      expect(model.description, isNull);
      expect(model.notes, isNull);
      expect(model.isTemplate, false);
    });
  });

  group('WorkoutExerciseModel', () {
    test('should create WorkoutExerciseModel from JSON', () {
      // Arrange
      final json = {
        'id': 'we-1',
        'workoutId': 'workout-1',
        'exerciseId': 'ex-1',
        'order': 0,
        'targetSets': 4,
        'restTime': 90,
      };

      // Act
      final model = WorkoutExerciseModel.fromJson(json);

      // Assert
      expect(model.id, 'we-1');
      expect(model.workoutId, 'workout-1');
      expect(model.exerciseId, 'ex-1');
      expect(model.order, 0);
      expect(model.targetSets, 4);
      expect(model.restTime, 90);
    });

    test('should create WorkoutExerciseModel from database map', () {
      // Arrange
      final map = {
        'id': 'we-1',
        'workout_id': 'workout-1',
        'exercise_id': 'ex-1',
        'order_index': 0,
        'target_sets': 4,
        'rest_time': 90,
      };

      // Act
      final model = WorkoutExerciseModel.fromMap(map);

      // Assert
      expect(model.id, 'we-1');
      expect(model.workoutId, 'workout-1');
      expect(model.exerciseId, 'ex-1');
      expect(model.order, 0);
      expect(model.targetSets, 4);
      expect(model.restTime, 90);
    });

    test('should convert WorkoutExerciseModel to JSON', () {
      // Arrange
      const model = WorkoutExerciseModel(
        id: 'we-1',
        workoutId: 'workout-1',
        exerciseId: 'ex-1',
        order: 0,
        targetSets: 4,
        restTime: 90,
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], 'we-1');
      expect(json['workoutId'], 'workout-1');
      expect(json['exerciseId'], 'ex-1');
      expect(json['order'], 0);
      expect(json['targetSets'], 4);
      expect(json['restTime'], 90);
    });

    test('should convert WorkoutExerciseModel to database map', () {
      // Arrange
      const model = WorkoutExerciseModel(
        id: 'we-1',
        workoutId: 'workout-1',
        exerciseId: 'ex-1',
        order: 0,
        targetSets: 4,
        restTime: 90,
      );

      // Act
      final map = model.toMap();

      // Assert
      expect(map['id'], 'we-1');
      expect(map['workout_id'], 'workout-1');
      expect(map['exercise_id'], 'ex-1');
      expect(map['order_index'], 0);
      expect(map['target_sets'], 4);
      expect(map['rest_time'], 90);
    });

    test('should create WorkoutExerciseModel from WorkoutExercise entity', () {
      // Arrange
      const workoutExercise = WorkoutExercise(
        exerciseId: 'ex-1',
        order: 0,
        targetSets: 4,
        restTime: Duration(seconds: 90),
      );

      // Act
      final model = WorkoutExerciseModel.fromEntity(
        workoutExercise,
        'we-1',
        'workout-1',
      );

      // Assert
      expect(model.id, 'we-1');
      expect(model.workoutId, 'workout-1');
      expect(model.exerciseId, workoutExercise.exerciseId);
      expect(model.order, workoutExercise.order);
      expect(model.targetSets, workoutExercise.targetSets);
      expect(model.restTime, 90);
    });

    test('should convert WorkoutExerciseModel to WorkoutExercise entity', () {
      // Arrange
      const model = WorkoutExerciseModel(
        id: 'we-1',
        workoutId: 'workout-1',
        exerciseId: 'ex-1',
        order: 0,
        targetSets: 4,
        restTime: 90,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.exerciseId, model.exerciseId);
      expect(entity.order, model.order);
      expect(entity.targetSets, model.targetSets);
      expect(entity.restTime, const Duration(seconds: 90));
    });

    test('should handle null restTime in JSON', () {
      // Arrange
      final json = {
        'id': 'we-1',
        'workoutId': 'workout-1',
        'exerciseId': 'ex-1',
        'order': 0,
        'targetSets': 3,
        'restTime': null,
      };

      // Act
      final model = WorkoutExerciseModel.fromJson(json);

      // Assert
      expect(model.restTime, isNull);
    });

    test('should handle null restTime in database map', () {
      // Arrange
      final map = {
        'id': 'we-1',
        'workout_id': 'workout-1',
        'exercise_id': 'ex-1',
        'order_index': 0,
        'target_sets': 3,
        'rest_time': null,
      };

      // Act
      final model = WorkoutExerciseModel.fromMap(map);

      // Assert
      expect(model.restTime, isNull);
    });

    test('should convert null restTime to null Duration in entity', () {
      // Arrange
      const model = WorkoutExerciseModel(
        id: 'we-1',
        workoutId: 'workout-1',
        exerciseId: 'ex-1',
        order: 0,
        targetSets: 3,
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.restTime, isNull);
    });

    test('should use default targetSets of 3 when missing in JSON', () {
      // Arrange
      final json = {
        'id': 'we-1',
        'workoutId': 'workout-1',
        'exerciseId': 'ex-1',
        'order': 0,
      };

      // Act
      final model = WorkoutExerciseModel.fromJson(json);

      // Assert
      expect(model.targetSets, 3);
    });
  });
}
