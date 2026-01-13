import '../entities/workout_session.dart';
import '../repositories/workout_session_repository.dart';

/// Use case to get the currently active workout session
class GetActiveSession {
  final WorkoutSessionRepository _repository;

  GetActiveSession(this._repository);

  /// Execute the use case
  /// Returns the active session or null if no session is active
  Future<WorkoutSession?> call() async {
    return await _repository.getActiveSession();
  }
}
