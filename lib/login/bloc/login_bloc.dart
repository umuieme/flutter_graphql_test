import 'dart:async';

import 'package:graphql_bloc/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:graphql_bloc/bloc/authentication_bloc/bloc.dart';
import 'package:graphql_bloc/login/bloc/bloc.dart';
import 'package:graphql_bloc/repositories/UserRepository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final userInfo = await userRepository.authenticateUser(
          event.username,
          event.password,
        );
        print("loginbloc === ${userInfo.toJson()}");
        authenticationBloc.add(LoggedIn(user: userInfo));
        // yield LoginInitial();
      } catch (error) {
        // print("login == eror === ${error}");
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
