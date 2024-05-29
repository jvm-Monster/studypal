// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:studypal/memory/database/database_helper.dart';
import 'package:studypal/memory/database/task_database.dart';
import 'package:studypal/models/task.dart';

void main() {
  group('TaskDatabaseHelper', () {
    setUp(() async {
      DatabaseHelper.initDatabase();
      // Ensure that the database is initialized before running each test
    });

    test('Insert and Retrieve Task', () async {
      // Arrange
      Task task = Task(
        name: 'Complete Flutter project',
        description: 'Finish building the studypal app',
        dueDate: '2024-02-10',
        priority: 2,
        id: 0,
      );

      // Act
      int? taskId = await TaskDatabaseHelper.insertTask(task);
      List<Task> tasks = await TaskDatabaseHelper.getTasks();

      // Assert
      expect(taskId, isNotNull);
      expect(tasks.length, greaterThan(0));
      expect(tasks[0].name, 'Complete Flutter project');
    });

    // Add more test cases as needed...
  });
}
