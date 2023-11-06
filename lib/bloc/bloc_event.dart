abstract class EventBloc {
  const EventBloc();
}

class LoginEvent extends EventBloc {
  LoginEvent(this.email, this.permission);
  bool permission;
  String email;
}

class LoginAndRegistorEvent extends EventBloc {
  const LoginAndRegistorEvent();
}

class RegistorEvent extends EventBloc {
  RegistorEvent(this.email, this.permission);
  bool permission;
  String email;
}

class LogoutEnvent extends EventBloc {
  const LogoutEnvent();
}
