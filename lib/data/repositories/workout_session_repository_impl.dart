import '../../../domain/entities/session_status.dart';
import '../../../domain/entities/workout_session.dart';
import '../../../domain/repositories/workout_session_repository.dart';
import '../datasources/local/workout_session_local_datasource.dart';
import '../models/workout_session_model.dart';

/// Implementation of WorkoutSessionRepository
class WorkoutSessionRepositoryImpl implements WorkoutSessionRepository {
  final WorkoutSessionLocalDataSource _localDataSource;

  WorkoutSessionRepositoryImpl(this._localDataSource);

  @override
  Future<WorkoutSession> createSession(WorkoutSession session) async {
    final model = WorkoutSessionModel.fromEntity(session);
    final createdModel = await _localDataSource.createSession(model);
    return createdModel.toEntity();
  }

  @override
  Future<WorkoutSession?> getActiveSession() async {
    final model = await _localDataSource.getActiveSession();
    return model?.toEntity();
  }

  @override
  Future<WorkoutSession> updateSession(WorkoutSession session) async {
    final model = WorkoutSessionModel.fromEntity(session);
    final updatedModel = await _localDataSource.updateSession(model);
    return updatedModel.toEntity();
  }

  @override
  Future<void> completeSession(String sessionId, DateTime endTime) async {
    final session = await _localDataSource.getSessionById(sessionId);
    if (session == null) {
      throw Exception('Session not found: $sessionId');
    }

    final updatedSession = session.copyWith(
      endTime: endTime,
      status: SessionStatus.completed,
    );

    await _localDataSource.updateSession(updatedSession);
  }

  @override
  Future<void> abandonSession(String sessionId) async {
    final session = await _localDataSource.getSessionById(sessionId);
    if (session == null) {
      throw Exception('Session not found: $sessionId');
    }

    final updatedSession = session.copyWith(
      endTime: DateTime.now(),
      status: SessionStatus.abandoned,
    );

    await _localDataSource.updateSession(updatedSession);
  }

  @override
  Future<WorkoutSession?> getSessionById(String sessionId) async {
    final model = await _localDataSource.getSessionById(sessionId);
    return model?.toEntity();
  }

  @override
  Future<List<WorkoutSession>> getAllSessions() async {
    final models = await _localDataSource.getAllSessions();
    return models.map((model) => model.toEntity()).toList();
  }
}
