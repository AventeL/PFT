import '../entities/workout_session.dart';
import '../repositories/workout_session_repository.dart';

/// Use case for abandoning a workout session
class AbandonWorkoutSession {
  final WorkoutSessionRepository _repository;

  AbandonWorkoutSession(this._repository);

  /// Abandon the given session
  Future<void> call(WorkoutSession session) async {
    await _repository.abandonSession(session.id);
  }
}
