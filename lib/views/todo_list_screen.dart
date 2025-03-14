import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mvc_app/controllers/task_controller.dart';
import 'package:todo_mvc_app/views/history_list.dart';
import 'package:todo_mvc_app/views/task_list.dart';
import 'package:todo_mvc_app/widgets/task_input.dart';

class TodoListScreen extends StatefulWidget {
  final TextEditingController _taskController = TextEditingController();

  TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  bool _showHistory = false;

  void _toggleHistory() {
    setState(() {
      _showHistory = !_showHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TaskInputWidget(
              controller: widget._taskController,
              onAddPressed: () {
                taskController.addTask(widget._taskController.text, context);
                widget._taskController.clear();
              },
              onHistoryPressed: _toggleHistory,
            ),
            Expanded(
              child: taskController.tasks.isEmpty
                  ? const Center(child: Text('No tasks available'))
                  : TaskListWidget(
                      tasks: taskController.tasks,
                      onDelete: (index) =>
                          taskController.deleteTask(index, context),
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
                        onClearHistory: () =>
                            taskController.clearHistory(context),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
