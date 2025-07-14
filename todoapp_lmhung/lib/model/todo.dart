
enum Priority { high, nomal, low }

class Todo {
  final int id;
  final String parent_id;
  final String category_id;
  final String maintask;

  late final bool? status;
  final DateTime deadline;
  final DateTime creatAt;
  Priority? priority;

  Todo( {
    required this.id,
    required this.maintask,

    required this.status,
    required this.deadline,
    required this.creatAt,
    this.priority,
    required this.category_id,
    required this.parent_id,
  });

  Todo copyWith({
    String? maintask,
    String? description,
    DateTime? deadline,
    Priority? priority,
    bool? status
  }) {
    return Todo(
      maintask: maintask ?? this.maintask,
      status: status ?? this.status,
      deadline: deadline ?? this.deadline,
      creatAt: creatAt,
      priority: priority ?? this.priority,
      id: id,
      category_id: '',
      parent_id: this.parent_id,
    );
  }

  @override
  String toString() {
    return "Todo($id, $maintask)";
  }
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

