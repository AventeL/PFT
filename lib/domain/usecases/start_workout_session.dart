import 'package:uuid/uuid.dart';

import '../entities/performed_exercise.dart';
import '../entities/session_status.dart';
import '../entities/workout.dart';
import '../entities/workout_session.dart';
import '../repositories/workout_session_repository.dart';

/// Use case to start a new workout session
class StartWorkoutSession {
  final WorkoutSessionRepository _repository;
  final Uuid _uuid = const Uuid();

  StartWorkoutSession(this._repository);

  /// Execute the use case
  /// [workout] - Optional workout template to use (null for quick start)
  Future<WorkoutSession> call({Workout? workout}) async {
    // Create new session
    final session = WorkoutSession(
      id: _uuid.v4(),
      workoutId: workout?.id,
      startTime: DateTime.now(),
      endTime: null,
      status: SessionStatus.active,
      performedExercises: _initializePerformedExercises(workout),
      notes: null,
    );

    // Save to repository
    return await _repository.createSession(session);
  }

  /// Initialize performed exercises from workout template
  List<PerformedExercise> _initializePerformedExercises(Workout? workout) {
    if (workout == null) {
      return []; // Quick start - empty list
    }

    // Initialize from workout exercises
    return workout.exercises.map((workoutExercise) {
      return PerformedExercise(
        exerciseId: workoutExercise.exerciseId,
        sets: const [], // Sets will be added during workout
        restTime: workoutExercise.restTime,
        orderIndex: workoutExercise.order,
      );
    }).toList();
  }
}
