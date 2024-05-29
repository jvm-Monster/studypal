import 'package:studypal/memory/database/database_helper.dart';
import 'package:studypal/models/schedule.dart';
import 'package:studypal/models/schedule_task.dart'; // Import the ScheduleTask model

class ScheduleDatabaseHelper {
  // Insert a new schedule and return its ID
  static Future<int> insertSchedule(Schedule schedule) async {
    final db = DatabaseHelper.database;
    final int? id = await db?.transaction((txn) async {
      // Insert the schedule into the 'schedules' table
      final List<Map<String, dynamic>> results = await txn.rawQuery('''
      INSERT INTO schedules (name) VALUES (?)
    ''', [schedule.name]);
      // Extract and return the inserted schedule ID
      return results.isNotEmpty ? results.first['id'] : null;
    });

    return id ?? -1; // Return the ID, or -1 if insertion failed
  }

  // Insert a task for a particular schedule
  static Future<int> insertTaskForSchedule(ScheduleTask task) async {
    final db = DatabaseHelper.database;
    int? id = await db?.insert(
      'scheduleTasks', // Use the 'schedule_tasks' table for ScheduleTask
      task.toJson(), // Assuming toMap method is defined in ScheduleTask
    );
    return id!;
  }

  // Delete a task for a particular schedule
  static Future<void> deleteTaskForSchedule(int taskId) async {
    final db = DatabaseHelper.database;
    int? s = await db?.delete(
      'scheduleTasks', // Use the 'schedule_tasks' table for ScheduleTask
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  // Delete a schedule
  static Future<void> deleteSchedule(int scheduleId) async {
    final db = DatabaseHelper.database;
    await db?.delete(
      'schedules',
      where: 'id = ?',
      whereArgs: [scheduleId],
    );
    print("deleting schedul");
  }

  //Get all schedules with their tasks
  static Future<List<Schedule>> getAllSchedulesWithTasks() async {
    final db = DatabaseHelper.database;
    final schedules = await db?.query('schedules'); //we get all schedules.
    final List<Schedule> scheduleList = [];

    //check if its not null
    if (schedules != null) {
      //a for each schedule in schedules
      for (final schedule in schedules) {
        // we query the scheduleTasks table and get result base on the
        // schedule id.
        List<Map<String, dynamic>>? tasks = await db?.query('scheduleTasks',
            where: 'scheduleId = ?', whereArgs: [schedule['id']]);

        //check if tasks is returned from the previous query is null
        final List<ScheduleTask> taskList = tasks != null
            ? //if not null, then map the task to a ScheduleTask object
            //and return the taskList
            tasks.map((task) => ScheduleTask.fromJson(task)).toList()
            //return empty list if task is null.
            : [];

        //convert schedule to Schedule object
        final scheduleObj = Schedule.fromJson(schedule);
        //set the scheduleObject tasks to the taskList
        scheduleObj.scheduleTasks = taskList;
        //then add the schedule to the scheduleList
        scheduleList.add(scheduleObj);
      }
    }
    return scheduleList;
  }

  static Future<int?> getNumberOfTaskForAParticularDay(
      int scheduleId, String day) async {
    final db = DatabaseHelper.database;

    // Query the scheduleTasks table to count tasks for the given day and schedule ID
    final List<Map<String, Object?>>? tasks = await db?.query(
      'scheduleTasks',
      where: 'scheduleId = ? AND day = ?',
      whereArgs: [scheduleId, day],
    );

    // Return the number of tasks found
    return tasks?.length;
  }
}
