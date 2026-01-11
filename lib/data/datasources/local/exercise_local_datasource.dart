import '../../../domain/entities/exercise.dart';

/// Local data source interface for exercises
abstract class ExerciseLocalDataSource {
  /// Get all exercises from local database
  Future<List<Exercise>> getExercises();

  /// Get a specific exercise by ID
  Future<Exercise?> getExerciseById(String id);

  /// Insert a new exercise
  Future<Exercise> insertExercise(Exercise exercise);

  /// Delete an exercise
  Future<void> deleteExercise(String id);

  /// Bulk insert exercises (for seeding)
  Future<void> bulkInsertExercises(List<Exercise> exercises);

  /// Get exercise count
  Future<int> getExerciseCount();
}

