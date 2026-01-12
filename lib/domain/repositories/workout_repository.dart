import '../entities/workout.dart';

/// Workout repository interface - Domain layer
/// Defines contract for workout data operations
abstract class WorkoutRepository {
  /// Get all workouts
  Future<List<Workout>> getWorkouts();

  /// Get workout by ID
  Future<Workout?> getWorkoutById(String id);

  /// Create a new workout
  Future<Workout> createWorkout(Workout workout);

  /// Update an existing workout
  Future<Workout> updateWorkout(Workout workout);

  /// Delete a workout by ID
  Future<void> deleteWorkout(String id);

  /// Get all workout templates
  Future<List<Workout>> getTemplates();
}
