import '../entities/workout.dart';
import '../repositories/workout_repository.dart';

/// Use case to get all workouts
class GetWorkouts {
  final WorkoutRepository repository;

  GetWorkouts({required this.repository});

  Future<List<Workout>> call() async {
    return await repository.getWorkouts();
  }
}
