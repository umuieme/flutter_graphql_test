import 'package:graphql_bloc/login/bloc/bloc.dart';
import 'package:graphql_bloc/utils/color.dart';
import 'package:graphql_bloc/utils/router.dart';
import 'package:graphql_bloc/utils/validator.dart';
import 'package:graphql_bloc/widgets/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email = "";
  String _password = "";

  GlobalKey<FormState> _formKey = GlobalKey();

  _onSignInPress() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    print('email $_email password $_password');
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        username: _email,
        password: _password,
      ),
    );
  }

  _onSignInWithFacebook() {
    Navigator.pushNamed(context, 'aasd');
  }

  _onSignUpPressed() {
    Navigator.pushNamed(context, Router.REGISTER);
  }

  _onForgetPasswordPressed() {}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return _buildBody(state);
              },
            ),
          )),
    );
  }

  Widget _buildBody(LoginState state) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 64,
        ),
        FlutterLogo(
          size: 128,
        ),
        SizedBox(
          height: 64,
        ),
        TextFormField(
          style: TextStyle(fontSize: 16),
          decoration:
              InputDecoration(hintText: "Username", labelText: "Username"),
          validator: (value) => Validator.validateEmail(value),
          onSaved: (value) => _email = value,
          initialValue: kDebugMode ? 'admin': '',
        ),
        SizedBox(
          height: 32,
        ),
        TextFormField(
          validator: (value) => Validator.validatePassword(value),
          style: TextStyle(fontSize: 16),
          decoration:
              InputDecoration(hintText: "Password", labelText: "Password"),
          onSaved: (value) => _password = value,
          initialValue: kDebugMode ? 'secret': '',
        ),
        SizedBox(
          height: 32,
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Forgot your password?",
              style: TextStyle(color: theme.primaryColor),
            )),
        SizedBox(
          height: 32,
        ),
        state is LoginLoading
            ? LoadingIndicator()
            : RaisedButton(
                onPressed: () => this._onSignInPress(),
                child: Text("SIGN IN"),
                color: theme.accentColor,
                elevation: 0,
                textColor: Colors.white,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
        SizedBox(
          height: 32,
        ),
        RaisedButton(
          onPressed: () => this._onSignInWithFacebook(),
          child: Text("Connect with Facebook"),
          color: CustomColor.FB_LOGO,
          elevation: 0,
          textColor: Colors.white,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 16,
        ),
        Align(
          child: RichText(
              text: TextSpan(
                  text: "Don't have account? ",
                  style: TextStyle(color: Colors.grey),
                  children: [
                TextSpan(
                    text: "Sign Up",
                    style: TextStyle(color: Colors.black),
                    recognizer: TapGestureRecognizer()
                      ..onTap = this._onSignUpPressed),
              ])),
        ),
      ],
    );
  }
}
