// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class StateBloc extends Equatable {
  const StateBloc() : super();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginState extends StateBloc {
  const LoginState();
}

class RegistorState extends StateBloc {
  const RegistorState();
}

class EnterInformationState extends StateBloc {
  EnterInformationState(this.email, this.permission);
  bool permission;
  String email;
}

class HomeState extends StateBloc {
  HomeState(this.email, this.permission);
  String email;
  bool permission;
}
