import 'package:graphql_bloc/login/login.dart';
import 'package:graphql_bloc/screen/register.dart';
import 'package:flutter/material.dart';

class Router {
  static const LOGIN = "login";
  static const REGISTER = 'register';
  static onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case LOGIN:
      return MaterialPageRoute(builder: (_)=> LoginScreen());
      case REGISTER:
      return MaterialPageRoute(builder: (_)=>RegisterScreen());
      default:
      return Text("aalu khau");
    }
  }
}