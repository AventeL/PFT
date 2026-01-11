import '../entities/exercise.dart';
import '../repositories/exercise_repository.dart';

/// Use case to get a specific exercise by ID
class GetExerciseById {
  final ExerciseRepository repository;

  GetExerciseById({required this.repository});

  Future<Exercise?> call(String id) async {
    return await repository.getExerciseById(id);
  }
}

