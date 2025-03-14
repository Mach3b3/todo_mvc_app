import 'package:flutter/material.dart';
import 'package:todo_mvc_app/controllers/task_controller.dart';

import 'package:todo_mvc_app/views/history_list.dart';
import 'package:todo_mvc_app/widgets/task_input.dart';
import 'package:todo_mvc_app/views/task_list.dart';

class TodoListScreen extends StatefulWidget {
  final TaskController taskController;

  const TodoListScreen({super.key, required this.taskController});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _taskController = TextEditingController();
  bool _showHistory = false;

  void _toggleHistory() {
    setState(() {
      _showHistory = !_showHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TaskInputWidget(
              controller: _taskController,
              onAddPressed: () =>
                  widget.taskController.addTask(_taskController.text),
              onHistoryPressed: _toggleHistory,
            ),
            Expanded(
              child: widget.taskController.tasks.isEmpty
                  ? const Center(child: Text('No tasks available'))
                  : TaskListWidget(
                      tasks: widget.taskController.tasks,
                      onDelete: widget.taskController.deleteTask,
                      onUpdate: widget.taskController.updateTask,
                      onToggleComplete: widget.taskController.toggleComplete,
                    ),
            ),
            if (_showHistory)
              Expanded(
                child: widget.taskController.history.isEmpty
                    ? const Center(child: Text('No history yet'))
                    : HistoryListWidget(
                        history: widget.taskController.history,
                        onClearHistory: widget.taskController.clearHistory,
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
