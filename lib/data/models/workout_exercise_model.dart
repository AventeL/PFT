import '../../domain/entities/workout_exercise.dart';

/// WorkoutExercise model - Data layer
/// Handles serialization/deserialization for database and JSON
class WorkoutExerciseModel {
  final String id;
  final String workoutId;
  final String exerciseId;
  final int order;
  final int targetSets;
  final int? restTime; // in seconds

  const WorkoutExerciseModel({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.order,
    required this.targetSets,
    this.restTime,
  });

  /// Create WorkoutExerciseModel from JSON
  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) {
    return WorkoutExerciseModel(
      id: json['id'] as String,
      workoutId: json['workoutId'] as String,
      exerciseId: json['exerciseId'] as String,
      order: json['order'] as int,
      targetSets: json['targetSets'] as int? ?? 3,
      restTime: json['restTime'] as int?,
    );
  }

  /// Create WorkoutExerciseModel from database map
  factory WorkoutExerciseModel.fromMap(Map<String, dynamic> map) {
    return WorkoutExerciseModel(
      id: map['id'] as String,
      workoutId: map['workout_id'] as String,
      exerciseId: map['exercise_id'] as String,
      order: map['order_index'] as int,
      targetSets: map['target_sets'] as int? ?? 3,
      restTime: map['rest_time'] as int?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutId': workoutId,
      'exerciseId': exerciseId,
      'order': order,
      'targetSets': targetSets,
      'restTime': restTime,
    };
  }

  /// Convert to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workout_id': workoutId,
      'exercise_id': exerciseId,
      'order_index': order,
      'target_sets': targetSets,
      'rest_time': restTime,
    };
  }

  /// Create WorkoutExerciseModel from WorkoutExercise entity
  factory WorkoutExerciseModel.fromEntity(
    WorkoutExercise workoutExercise,
    String id,
    String workoutId,
  ) {
    return WorkoutExerciseModel(
      id: id,
      workoutId: workoutId,
      exerciseId: workoutExercise.exerciseId,
      order: workoutExercise.order,
      targetSets: workoutExercise.targetSets,
      restTime: workoutExercise.restTime?.inSeconds,
    );
  }

  /// Convert to WorkoutExercise entity
  WorkoutExercise toEntity() {
    return WorkoutExercise(
      exerciseId: exerciseId,
      order: order,
      targetSets: targetSets,
      restTime: restTime != null ? Duration(seconds: restTime!) : null,
    );
  }
}
