import '../entities/workout_session.dart';

/// Repository interface for workout session operations
abstract class WorkoutSessionRepository {
  /// Create a new workout session
  Future<WorkoutSession> createSession(WorkoutSession session);

  /// Get the currently active session (if any)
  Future<WorkoutSession?> getActiveSession();

  /// Update an existing session
  Future<WorkoutSession> updateSession(WorkoutSession session);

  /// Complete a session
  Future<void> completeSession(String sessionId, DateTime endTime);

  /// Abandon a session
  Future<void> abandonSession(String sessionId);

  /// Get a session by ID
  Future<WorkoutSession?> getSessionById(String sessionId);

  /// Get all sessions (for history)
  Future<List<WorkoutSession>> getAllSessions();
}
