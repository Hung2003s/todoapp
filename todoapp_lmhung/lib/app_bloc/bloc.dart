import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class App_Bloc extends Bloc<AppEvent, AppState> {
  App_Bloc() : super(AppState.init()) {
    on<SetThemeColorEvent>(_onSetThemeColorEvent);
    // on<SetTodoStatusEvent>(_onSetTodoStatus);
    on<LoadTodoData>(_onLoadTodoData);
  }


  void _onSetThemeColorEvent(SetThemeColorEvent event, Emitter<AppState> emit) async {
    emit(state.copyWith(appcolor: event.themeColor));
  }

  // void _onSetTodoStatus(SetTodoStatusEvent event, Emitter<AppState> emit) async {
  //   emit(state.copyWith(
  //
  //   ));
  // }

void _onLoadTodoData(LoadTodoData event, Emitter<AppState> emit) async {
    emit(
      state.copyWith(
        todostate: event.todo
      )
    );
}
}
