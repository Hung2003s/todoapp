import 'model/todo.dart';

  final List<Todo> listTodo = [
    Todo(
        title: 'Làm việc nhà',
        description: 'Quét nhà',
        status: Status.Todo,
        deadline: DateTime.now(),
        creatAt: DateTime.now(),
        priority: Priority.low,
        id: 1),
    Todo(
        title: 'Design',
        description: 'Làm UI đồ án',
        status: Status.Ongoing,
        deadline: DateTime.now(),
        creatAt: DateTime.now(),
        priority: Priority.high,
        id: 2),
    Todo(
        title: 'Làm việc nhà',
        description: 'Dọn bàn',
        status: Status.Finish,
        deadline: DateTime.now(),
        creatAt: DateTime.now(),
        priority: Priority.nomal,
        id: 3),
    Todo(
        title: 'Làm việc nhà',
        description: 'Dọn bàn',
        status: Status.Todo,
        deadline: DateTime.now(),
        creatAt: DateTime.now(),
        priority: Priority.nomal,
        id: 4),
    Todo(
        title: 'Làm việc nhà',
        description: 'Dọn bàn',
        status: Status.Canceled,
        deadline: DateTime.now(),
        creatAt: DateTime.now(),
        priority: Priority.nomal,
        id: 5),
    Todo(
        title: 'Làm việc nhà',
        description: 'Dọn bàn',
        status: Status.Todo,
        deadline: DateTime.now(),
        creatAt: DateTime.now(),
        priority: Priority.nomal,
        id: 6),
  ];

