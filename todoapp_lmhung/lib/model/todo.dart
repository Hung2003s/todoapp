enum Status { Todo, Ongoing, Finish, Canceled }

enum Priority { high, nomal, low }

class Todo {
  final int id;
  final String title;
  final String description;
  final Status status;
  final DateTime deadline;
  final DateTime creatAt;
  Priority? priority;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.deadline,
    required this.creatAt,
    this.priority,
  });

  Todo copyWith({
    String? title,
    String? description,
    DateTime? deadline,
    Priority? priority,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      status: status,
      deadline: deadline ?? this.deadline,
      creatAt: creatAt,
      priority: priority ?? this.priority,
      id: id,
    );
  }

  @override
  String toString() {
    return "Todo($id, $title)";
  }
}
