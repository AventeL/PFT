import '../../models/workout_model.dart';
import '../../models/workout_exercise_model.dart';

/// Workout local data source interface
/// Defines contract for local workout data operations
abstract class WorkoutLocalDataSource {
  /// Get all workouts
  Future<List<WorkoutModel>> getWorkouts();

  /// Get workout by ID (without exercises)
  Future<WorkoutModel?> getWorkoutById(String id);

  /// Get exercises for a workout
  Future<List<WorkoutExerciseModel>> getWorkoutExercises(String workoutId);

  /// Create a new workout
  Future<WorkoutModel> createWorkout(WorkoutModel workout);

  /// Create workout exercises
  Future<void> createWorkoutExercises(
    List<WorkoutExerciseModel> workoutExercises,
  );

  /// Update an existing workout
  Future<WorkoutModel> updateWorkout(WorkoutModel workout);

  /// Update workout exercises (delete old ones and insert new ones)
  Future<void> updateWorkoutExercises(
    String workoutId,
    List<WorkoutExerciseModel> workoutExercises,
  );

  /// Delete a workout by ID
  Future<void> deleteWorkout(String id);

  /// Get all workout templates
  Future<List<WorkoutModel>> getTemplates();
}
