import 'package:graphql_bloc/bloc/authentication_bloc/bloc.dart';
import 'package:graphql_bloc/login/bloc/bloc.dart';
import 'package:graphql_bloc/login/widgets/login_form.dart';
import 'package:graphql_bloc/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  const LoginScreen({Key key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocProvider(
            builder: (context) {
              return LoginBloc(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
                userRepository: userRepository,
              );
            },
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
