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
  final Todo? todostate;
  LoadingState loadingState;
  Color appcolor;

  AppState({
    this.todostate,
    this.loadingState = LoadingState.pure,
    required this.appcolor,
  });

  factory AppState.init() {
    return AppState(
        todostate: listTodo.first,
        loadingState: LoadingState.pure,
        appcolor: Color(0xff24A19C));
  }

  AppState copyWith ({
    Todo? todostate,
    LoadingState? loadingstate,
     Color? appcolor,
  }) {
    return AppState(
        appcolor: appcolor ?? this.appcolor,
      todostate: todostate ?? this.todostate,
      loadingState: loadingstate ?? this.loadingState
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    todostate,
    appcolor,
    loadingState,
  ];
}
