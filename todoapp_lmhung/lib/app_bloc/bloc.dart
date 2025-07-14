import 'package:bloc/bloc.dart';
import 'package:todoapp_lmhung/list.dart';

import '../model/todo.dart';
import 'event.dart';
import 'state.dart';

class App_Bloc extends Bloc<AppEvent, AppState> {
  App_Bloc() : super(AppState.init()) {
    on<SetThemeColorEvent>(_onSetThemeColorEvent);
    on<ToggleTask>(_onToggleTask);
    // on<S>(_onSetThemeColorEvent);
    on<SetTaskTrue>(_onSetTaskTrue);
  }

  void _onSetThemeColorEvent(SetThemeColorEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(appcolor: event.themeColor));
  }
  void _onToggleTask(ToggleTask event, Emitter<AppState> emit)  {

    final updatedTask = List<Todo>.from(state.todolist);
    final index = updatedTask.indexWhere((t) => t.id == event.id);
    final task = updatedTask[index];
    updatedTask[index] = task.copyWith(
      status: !task.status!
    );

   emit(state.copyWith(
       listtodo: updatedTask,
    )
   );
  }

  void _onSetTaskTrue(SetTaskTrue event, Emitter<AppState> emit)  {

    final updatedTask = List<Todo>.from(state.todolist);
    final index = updatedTask.indexWhere((t) => t.id == event.id);
    final task = updatedTask[index];
    updatedTask[index] = task.copyWith(
        status: true
    );

    emit(state.copyWith(
      listtodo: updatedTask,
    )
    );
  }

// void _onLoadTodoData(LoadTodoData event, Emitter<AppState> emit) async {
//     emit(
//       state.copyWith(
//         todostate: event.todo
//       )
//     );
// }
}
