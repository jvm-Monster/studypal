import 'package:studypal/memory/database/database_helper.dart'; // Import your DatabaseHelper class

class EditableScheduleHelper {
  static Future<bool> editScheduleName(
      {required String newName, required int scheduleId}) async {
    try {
      final db = DatabaseHelper.database; // Access the database instance
      await db?.transaction((txn) async {
        // Update the schedule name in the 'schedules' table
        await txn.rawUpdate('''
          UPDATE schedules
          SET name = ?
          WHERE id = ?
        ''', [newName, scheduleId]);
      });
      return true;
    } catch (e) {
     
      return false;
    }
  }

  static Future<bool> editScheduleTaskTime({
    required int scheduleId,
    required int taskId,
    required String day,
    required String name,
    required String time,
  }) async {
    try {
      final db = DatabaseHelper.database; // Access the database instance
      await db?.transaction((txn) async {
        // Update the task time in the 'scheduleTasks' table
        await txn.rawUpdate('''
          UPDATE scheduleTasks
          SET dueDate = ?
          WHERE scheduleId = ? AND id = ? AND day = ? AND name = ?
        ''', [time, scheduleId, taskId, day, name]);
      });
      return true;
    } catch (e) {
     
      return false;
    }
  }
}
