import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/session_status.dart';
import '../../database/database_helper.dart';
import '../../models/performed_exercise_model.dart';
import '../../models/set_record_model.dart';
import '../../models/workout_session_model.dart';
import 'workout_session_local_datasource.dart';

/// Implementation of WorkoutSessionLocalDataSource using SQLite
class WorkoutSessionLocalDataSourceImpl
    implements WorkoutSessionLocalDataSource {
  final DatabaseHelper _dbHelper;
  final Uuid _uuid = const Uuid();

  WorkoutSessionLocalDataSourceImpl(this._dbHelper);

  @override
  Future<WorkoutSessionModel> createSession(WorkoutSessionModel session) async {
    final db = await _dbHelper.database;

    await db.transaction((txn) async {
      // Insert session
      await txn.insert('workout_sessions', session.toDatabase());

      // Insert performed exercises and their sets
      for (final performedExercise in session.performedExercises) {
        final performedExerciseId = _uuid.v4();

        await txn.insert(
          'performed_exercises',
          {
            'id': performedExerciseId,
            ...performedExercise.toDatabase(sessionId: session.id),
          },
        );

        // Insert sets for this exercise
        for (final set in performedExercise.sets) {
          await txn.insert(
            'set_records',
            {
              'id': _uuid.v4(),
              ...set.toDatabase(performedExerciseId: performedExerciseId),
            },
          );
        }
      }
    });

    return session;
  }

  @override
  Future<WorkoutSessionModel?> getActiveSession() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> sessions = await db.query(
      'workout_sessions',
      where: 'status = ?',
      whereArgs: [SessionStatus.active.toDatabase()],
      orderBy: 'start_time DESC', // Added orderBy clause
      limit: 1,
    );

    if (sessions.isEmpty) {
      return null;
    }

    return await _loadSessionWithExercises(db, sessions.first);
  }

  @override
  Future<WorkoutSessionModel> updateSession(WorkoutSessionModel session) async {
    final db = await _dbHelper.database;

    await db.transaction((txn) async {
      // Update session
      await txn.update(
        'workout_sessions',
        session.toDatabase(),
        where: 'id = ?',
        whereArgs: [session.id],
      );

      // Delete existing performed exercises and sets
      final performedExercises = await txn.query(
        'performed_exercises',
        where: 'session_id = ?',
        whereArgs: [session.id],
      );

      for (final pe in performedExercises) {
        await txn.delete(
          'set_records',
          where: 'performed_exercise_id = ?',
          whereArgs: [pe['id']],
        );
      }

      await txn.delete(
        'performed_exercises',
        where: 'session_id = ?',
        whereArgs: [session.id],
      );

      // Insert updated performed exercises and sets
      for (final performedExercise in session.performedExercises) {
        final performedExerciseId = _uuid.v4();

        await txn.insert(
          'performed_exercises',
          {
            'id': performedExerciseId,
            ...performedExercise.toDatabase(sessionId: session.id),
          },
        );

        for (final set in performedExercise.sets) {
          await txn.insert(
            'set_records',
            {
              'id': _uuid.v4(),
              ...set.toDatabase(performedExerciseId: performedExerciseId),
            },
          );
        }
      }
    });

    return session;
  }

  @override
  Future<WorkoutSessionModel?> getSessionById(String sessionId) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> sessions = await db.query(
      'workout_sessions',
      where: 'id = ?',
      whereArgs: [sessionId],
      limit: 1,
    );

    if (sessions.isEmpty) {
      return null;
    }

    return await _loadSessionWithExercises(db, sessions.first);
  }

  @override
  Future<List<WorkoutSessionModel>> getAllSessions() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> sessions = await db.query(
      'workout_sessions',
      orderBy: 'start_time DESC',
    );

    final List<WorkoutSessionModel> result = [];
    for (final sessionMap in sessions) {
      final session = await _loadSessionWithExercises(db, sessionMap);
      result.add(session);
    }

    return result;
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    final db = await _dbHelper.database;

    await db.transaction((txn) async {
      // Delete sets
      final performedExercises = await txn.query(
        'performed_exercises',
        where: 'session_id = ?',
        whereArgs: [sessionId],
      );

      for (final pe in performedExercises) {
        await txn.delete(
          'set_records',
          where: 'performed_exercise_id = ?',
          whereArgs: [pe['id']],
        );
      }

      // Delete performed exercises
      await txn.delete(
        'performed_exercises',
        where: 'session_id = ?',
        whereArgs: [sessionId],
      );

      // Delete session
      await txn.delete(
        'workout_sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
      );
    });
  }

  /// Helper method to load a session with all its performed exercises and sets
  Future<WorkoutSessionModel> _loadSessionWithExercises(
    Database db,
    Map<String, dynamic> sessionMap,
  ) async {
    final session = WorkoutSessionModel.fromDatabase(sessionMap);

    // Load performed exercises
    final List<Map<String, dynamic>> performedExercisesData = await db.query(
      'performed_exercises',
      where: 'session_id = ?',
      whereArgs: [session.id],
    );

    final List<PerformedExerciseModel> performedExercises = [];

    for (final peData in performedExercisesData) {
      final performedExercise = PerformedExerciseModel.fromDatabase(peData);
      final performedExerciseId = peData['id'] as String;

      // Load sets for this exercise
      final List<Map<String, dynamic>> setsData = await db.query(
        'set_records',
        where: 'performed_exercise_id = ?',
        whereArgs: [performedExerciseId],
        orderBy: 'set_number ASC',
      );

      final sets = setsData
          .map((setData) => SetRecordModel.fromDatabase(setData))
          .toList();

      performedExercises.add(performedExercise.copyWith(sets: sets));
    }

    return session.copyWith(performedExercises: performedExercises);
  }
}
