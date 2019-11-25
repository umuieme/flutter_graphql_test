import 'package:graphql_bloc/bloc/authentication_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == "logout") {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Log out"),
                  value: "logout",
                )
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Text("HOme screen"),
      ),
    );
  }
}
