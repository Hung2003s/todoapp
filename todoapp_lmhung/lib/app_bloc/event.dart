import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:todoapp_lmhung/model/todo.dart';

sealed class AppEvent extends Equatable{
  const AppEvent();
}

final class SetThemeColorEvent extends AppEvent {
  final Color themeColor;
  SetThemeColorEvent(this.themeColor);

  @override
  // TODO: implement props
  List<Object?> get props => [themeColor];
}
final class LoadTodoData extends AppEvent {
  final Todo todo;
  LoadTodoData(this.todo);
  @override
  // TODO: implement props
  List<Object?> get props => [todo];


}
final class SetTodoStatusEvent extends AppEvent {
  final Status setStatus;
  SetTodoStatusEvent(this.setStatus);

  @override
  // TODO: implement props
  List<Object?> get props => [setStatus];
}