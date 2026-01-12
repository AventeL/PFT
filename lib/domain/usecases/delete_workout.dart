import '../repositories/workout_repository.dart';

/// Use case to delete a workout
class DeleteWorkout {
  final WorkoutRepository repository;

  DeleteWorkout({required this.repository});

  Future<void> call(String workoutId) async {
    if (workoutId.trim().isEmpty) {
      throw ArgumentError('Workout ID cannot be empty');
    }

    return await repository.deleteWorkout(workoutId);
  }
}
