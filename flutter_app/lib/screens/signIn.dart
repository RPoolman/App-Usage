import 'package:flutter/material.dart';
import 'package:flutter_app/services/servicesAuth.dart';

class SignIn extends StatefulWidget {

  final Function view;
  SignIn({ this.view });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Text('Sign in to AppTracker'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              widget.view();
            },
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Register', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Enter your email below:',style: TextStyle(fontSize: 20),),
              TextFormField(
                onChanged: (value){
                  setState(() { email = value;});
                },
              ),
              SizedBox(height: 20.0),
              Text('Enter your password below:',style: TextStyle(fontSize: 20),),
              TextFormField(
                obscureText: true,
                onChanged: (value){
                  setState(() { password = value;});
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
