import 'package:uuid/uuid.dart';
import '../entities/workout.dart';
import '../repositories/workout_repository.dart';

/// Use case to create a new workout
/// Validates workout data before creation
class CreateWorkout {
  final WorkoutRepository repository;
  final Uuid uuid = const Uuid();

  CreateWorkout({required this.repository});

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

    // Ensure workout has ID, createdAt, and updatedAt
    final now = DateTime.now();
    final workoutToCreate = Workout(
      id: workout.id.isEmpty ? uuid.v4() : workout.id,
      name: workout.name.trim(),
      description: workout.description?.trim(),
      exercises: workout.exercises,
      notes: workout.notes?.trim(),
      createdAt: workout.createdAt,
      updatedAt: now,
      isTemplate: workout.isTemplate,
    );

    return await repository.createWorkout(workoutToCreate);
  }
}
