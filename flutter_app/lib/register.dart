import 'package:flutter/material.dart';
import 'package:flutter_app/servicesAuth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  String parentEmail = '';
  String childEmail = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Text('SignUp for AppTracker'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Enter the Parents email below:',style: TextStyle(fontSize: 20),),
                TextFormField(
                  onChanged: (value){
                    setState(() { parentEmail = value;});
                  },
                ),
                SizedBox(height: 20.0),
                Text('Enter the Childs email below:',style: TextStyle(fontSize: 20),),
                TextFormField(
                  onChanged: (value){
                    setState(() { childEmail = value;});
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
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print(parentEmail);
                      print(childEmail);
                      print(password);
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
