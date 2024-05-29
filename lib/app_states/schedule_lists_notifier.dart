import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studypal/memory/database/editable_schedule_database_helper.dart';
import 'package:studypal/memory/database/schedule_database_helper.dart';
import 'package:studypal/models/schedule.dart';
import 'package:studypal/models/schedule_task.dart';

part 'schedule_lists_notifier.g.dart';

@riverpod
class ScheduleListNotifier extends _$ScheduleListNotifier {
  @override
  Future<List<Schedule>> build() async {
    return ScheduleDatabaseHelper.getAllSchedulesWithTasks();
  }

  createSchedule(Schedule schedule) async {
    await ScheduleDatabaseHelper.insertSchedule(schedule);
    await updateState();
  }

  Future<void> deleteSchedule(int scheduleId) async {
    await ScheduleDatabaseHelper.deleteSchedule(scheduleId);
    await updateState();
  }

  Future<bool> updateSchedule({required newName, required scheduleId}) async {
    bool success = await EditableScheduleHelper.editScheduleName(
        newName: newName, scheduleId: scheduleId);
    return _success(success);
  }

  Future<int> insertTaskForSchedule(ScheduleTask scheduleTask) async {
    int id = await ScheduleDatabaseHelper.insertTaskForSchedule(scheduleTask);
    updateState();
    return id;
  }

  Future<void> deleteTaskForSchedule(int scheduleTaskId) async {
    await ScheduleDatabaseHelper.deleteTaskForSchedule(scheduleTaskId);
    await updateState();
  }

  Future<bool> updateTaskForSchedule(
      {required scheduleId,
      required int taskId,
      required String day,
      required String name,
      required String time}) async {
    bool success = await EditableScheduleHelper.editScheduleTaskTime(
        scheduleId: scheduleId,
        taskId: taskId,
        day: day,
        name: name,
        time: time);
    return _success(success);
  }

  Future<void> updateState() async {
    final turnDataIntoAsyncValue =
        await ScheduleDatabaseHelper.getAllSchedulesWithTasks();
    state = AsyncData(turnDataIntoAsyncValue);
  }

  bool _success(bool success) {
    if (success) {
      updateState();
      return success;
    }
    return success;
  }
}
