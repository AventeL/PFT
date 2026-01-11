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
      version: 1,
      onCreate: _createDB,
    );
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

    // TODO: Add more tables for workouts, sessions, etc. in future stories
  }

  /// Close database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

