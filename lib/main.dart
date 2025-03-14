import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_mvc_app/views/todo_list_screen.dart';
import 'widgets/header.dart';
import 'controllers/task_controller.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  bool _isDarkMode = false;
  final TaskController _taskController = TaskController();

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    _taskController.loadTasks();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _saveThemePreference(_isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        hintColor: Colors.teal,
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.teal),
          bodyMedium: TextStyle(color: Colors.teal),
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        hintColor: Colors.tealAccent,
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.tealAccent),
          bodyMedium: TextStyle(color: Colors.tealAccent),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TodoHeader(
                      title: 'To-Do List',
                      subtitle: 'Manage your tasks efficiently',
                    ),
                    IconButton(
                      iconSize: 45,
                      icon: Icon(
                          _isDarkMode ? Icons.light_mode : Icons.dark_mode),
                      onPressed: _toggleTheme,
                      tooltip: 'Toggle Theme',
                    ),
                  ],
                ),
              ),
              Expanded(child: TodoListScreen(taskController: _taskController)),
            ],
          ),
        ),
      ),
    );
  }
}
