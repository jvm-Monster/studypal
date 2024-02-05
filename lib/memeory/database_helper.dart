/*
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:studypal/models/new_plan_model.dart';
import 'package:studypal/models/new_task_model.dart';

import '../models/study.dart';

class DatabaseHelper{
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;//for creating a database
  DatabaseHelper._privateConstructor();

  Future<Database> _initDatabase()async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath,'studypal_plans_db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: _createDatabase
    );

  }
  Future<Database> get database async{
    if(_database!=null) return _database!;
    _database=await _initDatabase();
    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE plans(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        day TEXT,
        plan_id INTEGER,
        FOREIGN KEY(plan_id) REFERENCES plans(id)
      )
    ''');
  }


  // CRUD operations go here
  Future<int> insertPlan(NewPlan plan) async {
    Database db = await instance.database;
    return await db.insert('plans', plan.toMap());
  }

  Future<int> insertTask(NewTask task) async {
    Database db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

}
*/
