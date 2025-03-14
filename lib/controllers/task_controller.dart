import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskController {
  List<Task> tasks;
  List<Task> history;

  TaskController()
      : tasks = [],
        history = [];

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    final String? historyString = prefs.getString('history');

    if (tasksString != null) {
      tasks = (jsonDecode(tasksString) as List)
          .map((item) => Task.fromMap(item))
          .toList();
    }

    if (historyString != null) {
      history = (jsonDecode(historyString) as List)
          .map((item) => Task.fromMap(item))
          .toList();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'tasks', jsonEncode(tasks.map((task) => task.toMap()).toList()));
    await prefs.setString(
        'history', jsonEncode(history.map((task) => task.toMap()).toList()));
  }

  void addTask(String title) {
    if (title.isNotEmpty) {
      tasks.add(Task(title: title));
      saveTasks();
    }
  }

  void deleteTask(int index) {
    history.add(tasks[index]); // Move to history before deleting
    tasks.removeAt(index);
    saveTasks();
  }

  void updateTask(int index, String newTitle) {
    if (newTitle.isNotEmpty) {
      tasks[index].title = newTitle;
      saveTasks();
    }
  }

  void toggleComplete(int index, bool? value) {
    tasks[index].completed = value ?? false;
    saveTasks();
  }

  void clearHistory() {
    history.clear();
    saveTasks();
  }
}
