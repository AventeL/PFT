import '../entities/workout_session.dart';
import '../repositories/workout_session_repository.dart';

/// Use case for completing a workout session
class CompleteWorkoutSession {
  final WorkoutSessionRepository _repository;

  CompleteWorkoutSession(this._repository);

  /// Complete the given session
  Future<void> call(WorkoutSession session) async {
    await _repository.completeSession(session.id, DateTime.now());
  }
}
