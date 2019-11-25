import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        backgroundColor: Color(0xfff8f8f8),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: _buildForm()),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration:
                  InputDecoration(hintText: 'Email', labelText: 'Email'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Name', labelText: 'Name'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Phone Number', labelText: 'Phone Number'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration:
                  InputDecoration(hintText: 'Password', labelText: 'Password'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              textColor: Colors.white,
              padding: EdgeInsets.all(16),
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
