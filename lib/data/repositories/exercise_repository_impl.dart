import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../datasources/local/exercise_local_datasource.dart';

/// Implementation of ExerciseRepository
class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseLocalDataSource localDataSource;

  ExerciseRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Exercise>> getExercises() async {
    return await localDataSource.getExercises();
  }

  @override
  Future<Exercise?> getExerciseById(String id) async {
    return await localDataSource.getExerciseById(id);
  }

  @override
  Future<Exercise> createExercise(Exercise exercise) async {
    return await localDataSource.insertExercise(exercise);
  }

  @override
  Future<void> deleteExercise(String id) async {
    await localDataSource.deleteExercise(id);
  }

  @override
  Future<void> seedExercises(List<Exercise> exercises) async {
    await localDataSource.bulkInsertExercises(exercises);
  }

  @override
  Future<bool> hasExercises() async {
    final count = await localDataSource.getExerciseCount();
    return count > 0;
  }
}

