import 'package:flutter/material.dart';
import '../models/task.dart';

class HistoryListWidget extends StatelessWidget {
  final List<Task> history;
  final VoidCallback onClearHistory;

  const HistoryListWidget({
    super.key,
    required this.history,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Deleted Tasks',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  history[index].title,
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: onClearHistory,
            icon: const Icon(Icons.delete_forever),
            label: const Text('Clear History'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
