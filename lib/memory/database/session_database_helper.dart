import 'package:studypal/memory/database/database_helper.dart';
import 'package:studypal/models/session.dart';

class SessionDatabaseHelper {
  // Create a new session
  static Future<int> createNewSession(Session session) async {
    final db = DatabaseHelper.database;
    int? id = await db?.insert(
      'session', // Use the 'session' table
      session.toJson(),
    );
    return id!;
  }

  // Get all sessions
  static Future<List<Session>> getAllSessions() async {
    final db = DatabaseHelper.database;
    final List<Map<String, dynamic>>? maps = await db?.query('session');

    // Convert the List<Map<String, dynamic>> into a List<Session>
    return List.generate(maps!.length, (i) {
      return Session.fromJson(maps[i]);
    });
  }
}
