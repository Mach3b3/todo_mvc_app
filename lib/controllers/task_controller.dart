import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/task.dart';

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

  void addTask(String title, BuildContext context) {
    if (title.isNotEmpty) {
      tasks.add(Task(title: title));
      saveTasks();
      notifyListeners();

      // Show toast message
      Fluttertoast.showToast(
        msg: "Task added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  void deleteTask(int index, BuildContext context) {
    history.add(tasks[index]); // Move to history before deleting
    tasks.removeAt(index);
    saveTasks();
    notifyListeners();

    // Show toast message
    Fluttertoast.showToast(
      msg: "Task deleted successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
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

  void clearHistory(BuildContext context) {
    history.clear();
    saveTasks();
    notifyListeners();

    // Show toast message
    Fluttertoast.showToast(
      msg: "History cleared successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }
}
