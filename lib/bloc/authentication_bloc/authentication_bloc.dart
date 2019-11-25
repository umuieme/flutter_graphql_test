import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:graphql_bloc/models/User.dart';
import 'package:graphql_bloc/repositories/UserRepository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  User _userInfo;
  User get userInfo => _userInfo;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final User user = await userRepository.getUserInfo();
      if (user != null) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      // yield AuthenticationLoading();
      await userRepository.persistUserInfo(event.user);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteUserInfo();
      yield AuthenticationUnauthenticated();
    }
  }
}
