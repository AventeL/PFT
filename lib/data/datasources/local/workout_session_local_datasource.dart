import '../../models/workout_session_model.dart';

/// Local data source interface for workout sessions
abstract class WorkoutSessionLocalDataSource {
  /// Create a new session in the database
  Future<WorkoutSessionModel> createSession(WorkoutSessionModel session);

  /// Get the currently active session
  Future<WorkoutSessionModel?> getActiveSession();

  /// Update an existing session
  Future<WorkoutSessionModel> updateSession(WorkoutSessionModel session);

  /// Get a session by ID
  Future<WorkoutSessionModel?> getSessionById(String sessionId);

  /// Get all sessions
  Future<List<WorkoutSessionModel>> getAllSessions();

  /// Delete a session
  Future<void> deleteSession(String sessionId);
}
