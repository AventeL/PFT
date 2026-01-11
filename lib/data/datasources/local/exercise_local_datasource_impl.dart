import 'package:sqflite/sqflite.dart';
import '../../../domain/entities/exercise.dart';
import '../../models/exercise_model.dart';
import '../../database/database_helper.dart';
import 'exercise_local_datasource.dart';

/// Implementation of ExerciseLocalDataSource using SQLite
class ExerciseLocalDataSourceImpl implements ExerciseLocalDataSource {
  final DatabaseHelper databaseHelper;

  ExerciseLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<Exercise>> getExercises() async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'exercises',
      orderBy: 'name ASC',
    );

    return maps.map((map) => ExerciseModel.fromMap(map).toEntity()).toList();
  }

  @override
  Future<Exercise?> getExerciseById(String id) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return ExerciseModel.fromMap(maps.first).toEntity();
  }

  @override
  Future<Exercise> insertExercise(Exercise exercise) async {
    final db = await databaseHelper.database;
    final model = ExerciseModel.fromEntity(exercise);

    await db.insert(
      'exercises',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return exercise;
  }

  @override
  Future<void> deleteExercise(String id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> bulkInsertExercises(List<Exercise> exercises) async {
    final db = await databaseHelper.database;

    // Use transaction for performance
    await db.transaction((txn) async {
      final batch = txn.batch();

      for (final exercise in exercises) {
        final model = ExerciseModel.fromEntity(exercise);
        batch.insert(
          'exercises',
          model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    });
  }

  @override
  Future<int> getExerciseCount() async {
    final db = await databaseHelper.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM exercises');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}

