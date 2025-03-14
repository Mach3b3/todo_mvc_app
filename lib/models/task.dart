class Task {
  String title;
  bool completed;

  Task({required this.title, this.completed = false});

  // Convert a Task object to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  // Create a Task object from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      completed: map['completed'] ?? false,
    );
  }
}
