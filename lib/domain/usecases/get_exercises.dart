import '../entities/exercise.dart';
import '../repositories/exercise_repository.dart';

/// Use case to get all exercises
class GetExercises {
  final ExerciseRepository repository;

  GetExercises({required this.repository});

  Future<List<Exercise>> call() async {
    return await repository.getExercises();
  }
}

