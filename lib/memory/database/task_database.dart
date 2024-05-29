import 'dart:async';

import 'package:studypal/memory/database/database_helper.dart';

import '../../models/task.dart';

class TaskDatabaseHelper {
  static const String table = "tasks";

  static Future<int?> insertTask(Task task) async {
    final db = DatabaseHelper.database;
    return await db?.insert(table, task.toJson());
  }

  static Future<List<Task>> getTasks() async {
    final db = DatabaseHelper.database;
    final List<Map<String, dynamic>>? tasks = await db?.query(table);
    
    return List.generate(tasks!.length, (i) => Task.fromJson(tasks[i]));
  }

  static Future<int?> deleteTask(int id) async {
    final db = DatabaseHelper.database;
    return await db?.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int?> updateTask(Task task) async {
    final db = DatabaseHelper.database;
    return await db?.update(
      table,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<void> deleteTable() async {
    final db = DatabaseHelper.database;
    await db?.execute('DROP TABLE IF EXISTS $table');
  }
}
