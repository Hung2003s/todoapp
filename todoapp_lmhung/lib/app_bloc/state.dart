import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:todoapp_lmhung/list.dart';


import '../model/todo.dart';

enum LoadingState {
  pure,
  loading,
  finished,
  error,
}

class AppState extends Equatable {
  final bool? todostate;
  LoadingState loadingState;
  Color appcolor;
  final List<Todo> todolist;

  AppState({
    this.todostate,
    this.loadingState = LoadingState.pure,
    required this.appcolor,
    required this.todolist,
  });

  factory AppState.init() {
    return AppState(
        todostate: false,
        loadingState: LoadingState.pure,
        appcolor: Color(0xff24A19C),
        todolist: listTodo,
    );

  }

  AppState copyWith ({
    bool? todostate,
    LoadingState? loadingstate,
    Color? appcolor,
    List<Todo>? listtodo
  }) {
    return AppState(
        appcolor: appcolor ?? this.appcolor,
      todostate: todostate ?? this.todostate,
      loadingState: loadingstate ?? this.loadingState,
      todolist: listtodo ?? this.todolist,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    todostate,
    appcolor,
    loadingState,
    todolist
  ];
}
