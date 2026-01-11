import '../entities/exercise.dart';

/// Exercise repository interface - Domain layer
/// Defines contract for exercise data operations
abstract class ExerciseRepository {
  /// Get all exercises from the database
  Future<List<Exercise>> getExercises();

  /// Get a specific exercise by ID
  Future<Exercise?> getExerciseById(String id);

  /// Create a new exercise (for custom exercises)
  Future<Exercise> createExercise(Exercise exercise);

  /// Delete an exercise (custom exercises only)
  Future<void> deleteExercise(String id);

  /// Seed initial exercises into the database
  Future<void> seedExercises(List<Exercise> exercises);

  /// Check if exercises have been seeded
  Future<bool> hasExercises();
}

