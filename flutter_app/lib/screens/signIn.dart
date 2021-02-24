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
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

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
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Enter your email below:',style: TextStyle(fontSize: 20),),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Please enter a valid email...' : null,
                onChanged: (value){
                  setState(() { email = value;});
                },
              ),
              SizedBox(height: 20.0),
              Text('Enter your password below:',style: TextStyle(fontSize: 20),),
              TextFormField(
                validator: (val) => val.length < 6 ? 'Please enter a password that is 6 characters long' : null,
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
                    if(_formKey.currentState.validate()) {
                      print('valid');
                      // if(result == null) {
                      //   setState(() => error = 'Please supply a valid email.');
                      // }
                    }
                  }
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
