// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_app.dart';
import 'bloc/bloc_state.dart';
import 'view/home/home_page.dart';
import 'view/login/login_view.dart';
import 'view/registor/enter_information_view.dart';
import 'view/registor/registor_view.dart';

class MyAppBloc extends StatelessWidget {
  MyAppBloc({super.key, required this.initState});

  StateBloc initState;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocApp(initState),
      child: BlocBuilder<BlocApp, StateBloc>(
        builder: (context, state) {
          if (state is LoginState) {
            return const LoginView();
          }

          if (state is RegistorState) {
            return const RegistorView();
          }

          if (state is EnterInformationState) {
            return EnterInformationView(
                email: state.email, permission: state.permission);
          }

          if (state is HomeState) {
            return HomePage(email: state.email, permission: state.permission);
          }

          return Container();
        },
      ),
    );
  }
}
