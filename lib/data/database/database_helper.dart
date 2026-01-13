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
      version: 7,
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
    if (oldVersion < 3) {
      // Add workout session tables for version 3
      await _createSessionTables(db);
    }
    if (oldVersion < 4) {
      // Clean up old active sessions for version 4
      // Mark all existing sessions without proper status as abandoned
      await db.execute('''
        UPDATE workout_sessions 
        SET status = 'abandoned', end_time = start_time
        WHERE end_time IS NULL AND status = 'active'
      ''');
    }
    if (oldVersion < 5) {
      // Ensure session tables exist for version 5
      // This is a safety measure in case version 4 migration was incomplete
      await _createSessionTables(db);
    }
    if (oldVersion < 6) {
      // Migration from version 5 to 6: Ensure 'order_index' exists in performed_exercises
      // If table already existed without it, we add it.
      try {
        await db.execute(
            'ALTER TABLE performed_exercises ADD COLUMN order_index INTEGER NOT NULL DEFAULT 0');
      } catch (e) {
        // Column might already exist, ignore error
      }
    }
    if (oldVersion < 7) {
      // Migration from version 6 to 7: Ensure 'rest_time' exists in performed_exercises
      try {
        await db.execute(
            'ALTER TABLE performed_exercises ADD COLUMN rest_time INTEGER');
      } catch (e) {
        // ignore
      }
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

  /// Create workout session related tables
  Future<void> _createSessionTables(Database db) async {
    // Workout sessions table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS workout_sessions (
        id TEXT PRIMARY KEY,
        workout_id TEXT,
        start_time INTEGER NOT NULL,
        end_time INTEGER,
        status TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE SET NULL
      )
    ''');

    // Performed exercises table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS performed_exercises (
        id TEXT PRIMARY KEY,
        session_id TEXT NOT NULL,
        exercise_id TEXT NOT NULL,
        order_index INTEGER NOT NULL,
        rest_time INTEGER,
        notes TEXT,
        FOREIGN KEY (session_id) REFERENCES workout_sessions(id) ON DELETE CASCADE,
        FOREIGN KEY (exercise_id) REFERENCES exercises(id)
      )
    ''');

    // Set records table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS set_records (
        id TEXT PRIMARY KEY,
        performed_exercise_id TEXT NOT NULL,
        set_number INTEGER NOT NULL,
        weight REAL,
        reps INTEGER,
        rpe REAL,
        is_completed INTEGER DEFAULT 1,
        FOREIGN KEY (performed_exercise_id) REFERENCES performed_exercises(id) ON DELETE CASCADE
      )
    ''');

    // Create indexes for sessions
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_session_start_time ON workout_sessions(start_time)
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_performed_exercise_session ON performed_exercises(session_id)
    ''');

    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_set_performed_exercise ON set_records(performed_exercise_id)
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

    // Create workout session tables
    await _createSessionTables(db);
  }

  /// Close database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
