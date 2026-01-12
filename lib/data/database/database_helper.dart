import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Database helper - Singleton pattern
/// Manages SQLite database for PFT app
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  /// Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pft.db');
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  /// Upgrade database when version changes
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add workouts tables for version 2
      await _createWorkoutTables(db);
    }
  }

  /// Create workout-related tables
  Future<void> _createWorkoutTables(Database db) async {
    // Workouts table
    await db.execute('''
      CREATE TABLE workouts (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        is_template INTEGER DEFAULT 0
      )
    ''');

    // Create indexes for workouts
    await db.execute('''
      CREATE INDEX idx_is_template ON workouts(is_template)
    ''');

    await db.execute('''
      CREATE INDEX idx_created_at ON workouts(created_at)
    ''');

    // Workout exercises join table
    await db.execute('''
      CREATE TABLE workout_exercises (
        id TEXT PRIMARY KEY,
        workout_id TEXT NOT NULL,
        exercise_id TEXT NOT NULL,
        order_index INTEGER NOT NULL,
        target_sets INTEGER,
        rest_time INTEGER,
        FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
        FOREIGN KEY (exercise_id) REFERENCES exercises(id)
      )
    ''');

    // Create index for workout_exercises
    await db.execute('''
      CREATE INDEX idx_workout_id ON workout_exercises(workout_id)
    ''');
  }

  /// Create database tables
  Future<void> _createDB(Database db, int version) async {
    // Exercises table
    await db.execute('''
      CREATE TABLE exercises (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        muscle_group TEXT NOT NULL,
        category TEXT NOT NULL,
        equipment_type TEXT NOT NULL,
        is_custom INTEGER NOT NULL,
        instructions TEXT,
        created_at INTEGER NOT NULL
      )
    ''');

    // Create indexes for performance
    await db.execute('''
      CREATE INDEX idx_muscle_group ON exercises(muscle_group)
    ''');

    await db.execute('''
      CREATE INDEX idx_is_custom ON exercises(is_custom)
    ''');

    // Create workout tables
    await _createWorkoutTables(db);

    // TODO: Add more tables for sessions, history, etc. in future stories
  }

  /// Close database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
