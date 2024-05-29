import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;
  static const _databaseName = "studypal_testing1.db";
  static const _databaseVersion = 1;
  static const tasksTable = 'tasks';
  static const scheduleTasksTable = 'scheduleTasks';
  static const schedulesTable = 'schedules';
  static const sessionTable = "session";

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  static Future<String> get getFullPath async {
    final path = await getDatabasesPath();
    return join(path, _databaseName);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tasksTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        dueDate TEXT,
        priority INTEGER DEFAULT 0,
        completed INTEGER DEFAULT 0
      )
    ''');

    // Create schedules table
    await db.execute('''
      CREATE TABLE $schedulesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    // Create schedule tasks table
    await db.execute('''
      CREATE TABLE $scheduleTasksTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        lead TEXT,
        dueDate TEXT,
        day TEXT,
        completed INTEGER DEFAULT 0,
        scheduleId INTEGER,
        FOREIGN KEY(scheduleId) REFERENCES $schedulesTable(id) ON DELETE CASCADE
      )
    ''');

    // Create session table
    await db.execute('''
      CREATE TABLE $sessionTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sessionName TEXT NOT NULL,
        dateTime TEXT NOT NULL,
        isCanceled INTEGER NOT NULL DEFAULT 0,
        targetTime TEXT NOT NULL,
        canceledTime TEXT
      )
    ''');

  }

  static Future<void> initDatabase() async {
    final path = await getFullPath;
    _database = await openDatabase(path,
        version: _databaseVersion,
        onCreate: _createDatabase,
        singleInstance: true);
  }

  static Database? get database => _database;
}
