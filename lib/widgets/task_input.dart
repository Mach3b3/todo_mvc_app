import 'package:flutter/material.dart';

class TaskInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAddPressed;
  final VoidCallback onHistoryPressed;

  const TaskInputWidget({
    super.key,
    required this.controller,
    required this.onAddPressed,
    required this.onHistoryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'New Task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 56, // Match the height of the TextField
            child: ElevatedButton(
              onPressed: onAddPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Add'),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 56, // Match the height of the TextField
            child: ElevatedButton.icon(
              onPressed: onHistoryPressed,
              icon: const Icon(Icons.history),
              label: const Text('History'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
