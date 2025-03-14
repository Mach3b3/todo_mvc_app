import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import 'package:flutter/material.dart';

class TaskController with ChangeNotifier {
  List<Task> tasks;
  List<Task> history;

  TaskController()
      : tasks = [],
        history = [] {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    final String? historyString = prefs.getString('history');

    if (tasksString != null) {
      tasks = (jsonDecode(tasksString) as List)
          .map((item) => Task.fromMap(item))
          .toList();
      notifyListeners();
    }

    if (historyString != null) {
      history = (jsonDecode(historyString) as List)
          .map((item) => Task.fromMap(item))
          .toList();
      notifyListeners();
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
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    history.add(tasks[index]); // Move to history before deleting
    tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void updateTask(int index, String newTitle) {
    if (newTitle.isNotEmpty) {
      tasks[index].title = newTitle;
      saveTasks();
      notifyListeners();
    }
  }

  void toggleComplete(int index, bool? value) {
    tasks[index].completed = value ?? false;
    saveTasks();
    notifyListeners();
  }

  void clearHistory() {
    history.clear();
    saveTasks();
    notifyListeners();
  }
}
