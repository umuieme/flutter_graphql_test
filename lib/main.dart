import 'package:graphql_bloc/graphql/graphql_helper.dart';
import 'package:graphql_bloc/login/login.dart';
import 'package:graphql_bloc/repositories/UserRepository.dart';
import 'package:graphql_bloc/screen/home_screen.dart';
import 'package:graphql_bloc/screen/splash_screen.dart';
import 'package:graphql_bloc/utils/router.dart';
import 'package:graphql_bloc/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication_bloc/bloc.dart';
import 'utils/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository(GraphqlHelper().grqphqlClient);
  runApp(
    BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graphql Test',
      theme: ThemeData(
        primaryColor: Color(0xff5AC8FA),
        accentColor: Color(0xff4CE5B1),
      ),
      onGenerateRoute: (settings) => Router.onGenerateRoute(settings),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomeScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashScreen();
        },
      ),
    );
  }
}
