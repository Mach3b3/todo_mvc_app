import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mvc_app/controllers/task_controller.dart';

import 'package:todo_mvc_app/views/history_list.dart';
import 'package:todo_mvc_app/widgets/task_input.dart';
import 'package:todo_mvc_app/views/task_list.dart';

class TodoListScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);
    bool _showHistory = false;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TaskInputWidget(
              controller: _taskController,
              onAddPressed: () => taskController.addTask(_taskController.text),
              onHistoryPressed: () => _showHistory = !_showHistory,
            ),
            Expanded(
              child: taskController.tasks.isEmpty
                  ? const Center(child: Text('No tasks available'))
                  : TaskListWidget(
                      tasks: taskController.tasks,
                      onDelete: taskController.deleteTask,
                      onUpdate: taskController.updateTask,
                      onToggleComplete: taskController.toggleComplete,
                    ),
            ),
            if (_showHistory)
              Expanded(
                child: taskController.history.isEmpty
                    ? const Center(child: Text('No history yet'))
                    : HistoryListWidget(
                        history: taskController.history,
                        onClearHistory: taskController.clearHistory,
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
