import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';

class BlocApp extends Bloc<EventBloc, StateBloc> {
  StateBloc initState;

  BlocApp(this.initState) : super(initState) {
    on<LoginEvent>(login);
    on<LoginAndRegistorEvent>(logiregistor);
    on<RegistorEvent>(registor);
    on<LogoutEnvent>(logout);
  }

  void login(LoginEvent event, Emitter<StateBloc> emit) async {
    emit(HomeState(event.email, event.permission));
  }

  void logiregistor(LoginAndRegistorEvent event, Emitter<StateBloc> emit) {
    state is LoginState
        ? emit(const RegistorState())
        : emit(const LoginState());
  }

  void registor(RegistorEvent event, Emitter<StateBloc> emit) {
    emit(EnterInformationState(event.email, event.permission));
  }

  void logout(LogoutEnvent envent, Emitter<StateBloc> emit) {
    emit(const LoginState());
  }
}
