import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) onDelete;
  final Function(int, String) onUpdate;
  final Function(int, bool?) onToggleComplete;

  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onDelete,
    required this.onUpdate,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Slidable(
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      TextEditingController updateController =
                          TextEditingController(text: tasks[index].title);
                      // ignore: unused_local_variable
                      bool? shouldUpdate = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Update Task'),
                          content: TextField(
                            controller: updateController,
                            decoration: InputDecoration(
                              labelText: 'New Task Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                onUpdate(index, updateController.text);
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) async {
                      final bool? confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Delete'),
                          content: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        onDelete(index);
                      }
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                leading: Checkbox(
                  value: tasks[index].completed,
                  onChanged: (value) => onToggleComplete(index, value),
                ),
                title: Text(
                  tasks[index].title,
                  style: TextStyle(
                    decoration: tasks[index].completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              indent: 75.0,
              endIndent: 16.0,
            ),
          ],
        );
      },
    );
  }
}
