import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studypal/memory/database/task_database.dart';

import '../models/task.dart';

part 'task_lists_notifier.g.dart';

final _getListProvider = FutureProvider((ref) {
  print('get list provider here');
  return TaskDatabaseHelper.getTasks();
});

@riverpod
class TaskListsNotifier extends _$TaskListsNotifier {
  List<Task> v = [];
  // Instantiate database helper

  @override
  List<Task> build() {
    fetchTasks();
    return v;
  }


  Future<void> fetchTasks() async {
    List<Task> vs = await _getListTask();
    v=vs;
    print('fetching the tasks');
    state = await TaskDatabaseHelper.getTasks();
  }

  Future<int> createNewTask(Task task) async {
    int? taskId = await TaskDatabaseHelper.insertTask(task);
    await fetchTasks();
    return taskId!;
  }

  Future<void> updateTask(Task task) async {
    await TaskDatabaseHelper.updateTask(task);
    await fetchTasks(); // Refresh the tasks after updating
  }

  Future<void> deleteTask(int id) async {
    await TaskDatabaseHelper.deleteTask(id);
    await fetchTasks(); // Refresh the tasks after deletion
  }

  Future<List<Task>> _getListTask() async{
    try {
      return TaskDatabaseHelper.getTasks();
    /*  final asyncValue = ref.watch(_getListProvider);
      return asyncValue.when(
        data: (tasks) {
          return tasks;
        },
        loading: () => [], // Return an empty list or handle loading state
        error: (_, __) => [], // Return an empty list or handle error state
      );*/
    } catch (e) {
      return [];
    }
  }

  void deleteTable() {
    TaskDatabaseHelper.deleteTable();
  }
}
