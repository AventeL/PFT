import '../entities/workout.dart';
import '../repositories/workout_repository.dart';

/// Use case to get all workout templates
class GetWorkoutTemplates {
  final WorkoutRepository repository;

  GetWorkoutTemplates({required this.repository});

  Future<List<Workout>> call() async {
    final allWorkouts = await repository.getWorkouts();
    return allWorkouts.where((workout) => workout.isTemplate).toList();
  }
}
