import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../models/workout_model.dart';
import '../../models/workout_exercise_model.dart';
import 'workout_local_datasource.dart';

/// Workout local data source implementation
/// Handles SQLite operations for workouts
class WorkoutLocalDataSourceImpl implements WorkoutLocalDataSource {
  final Database database;
  final Uuid uuid = const Uuid();

  WorkoutLocalDataSourceImpl(this.database);

  @override
  Future<List<WorkoutModel>> getWorkouts() async {
    final List<Map<String, dynamic>> maps = await database.query(
      'workouts',
      orderBy: 'created_at DESC',
    );

    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  @override
  Future<WorkoutModel?> getWorkoutById(String id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return WorkoutModel.fromMap(maps.first);
  }

  @override
  Future<List<WorkoutExerciseModel>> getWorkoutExercises(
    String workoutId,
  ) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'workout_exercises',
      where: 'workout_id = ?',
      whereArgs: [workoutId],
      orderBy: 'order_index ASC',
    );

    return maps.map((map) => WorkoutExerciseModel.fromMap(map)).toList();
  }

  @override
  Future<WorkoutModel> createWorkout(WorkoutModel workout) async {
    await database.insert(
      'workouts',
      workout.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return workout;
  }

  @override
  Future<void> createWorkoutExercises(
    List<WorkoutExerciseModel> workoutExercises,
  ) async {
    final batch = database.batch();

    for (final workoutExercise in workoutExercises) {
      batch.insert(
        'workout_exercises',
        workoutExercise.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<WorkoutModel> updateWorkout(WorkoutModel workout) async {
    await database.update(
      'workouts',
      workout.toMap(),
      where: 'id = ?',
      whereArgs: [workout.id],
    );

    return workout;
  }

  @override
  Future<void> updateWorkoutExercises(
    String workoutId,
    List<WorkoutExerciseModel> workoutExercises,
  ) async {
    // Use transaction for atomic update
    await database.transaction((txn) async {
      // Delete existing workout exercises
      await txn.delete(
        'workout_exercises',
        where: 'workout_id = ?',
        whereArgs: [workoutId],
      );

      // Insert new workout exercises
      final batch = txn.batch();
      for (final workoutExercise in workoutExercises) {
        batch.insert(
          'workout_exercises',
          workoutExercise.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    });
  }

  @override
  Future<void> deleteWorkout(String id) async {
    // Foreign key cascade will delete workout_exercises automatically
    await database.delete(
      'workouts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<WorkoutModel>> getTemplates() async {
    final List<Map<String, dynamic>> maps = await database.query(
      'workouts',
      where: 'is_template = ?',
      whereArgs: [1],
      orderBy: 'created_at DESC',
    );

    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }
}
