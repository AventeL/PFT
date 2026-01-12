import '../entities/workout.dart';
import '../repositories/workout_repository.dart';

/// Use case to update an existing workout
/// Validates workout data before update
class UpdateWorkout {
  final WorkoutRepository repository;

  UpdateWorkout({required this.repository});

  Future<Workout> call(Workout workout) async {
    // Validation: name must not be empty
    if (workout.name.trim().isEmpty) {
      throw ArgumentError('Workout name cannot be empty');
    }

    // Validation: must have at least 1 exercise
    if (workout.exercises.isEmpty) {
      throw ArgumentError('Workout must have at least one exercise');
    }

    // Validation: name max 100 characters
    if (workout.name.length > 100) {
      throw ArgumentError('Workout name cannot exceed 100 characters');
    }

    // Validation: description max 500 characters
    if (workout.description != null && workout.description!.length > 500) {
      throw ArgumentError('Workout description cannot exceed 500 characters');
    }

    // Update timestamp
    final workoutToUpdate = workout.copyWith(
      updatedAt: DateTime.now(),
    );

    return await repository.updateWorkout(workoutToUpdate);
  }
}
