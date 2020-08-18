import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register_card extends StatefulWidget {
  @override
  _Register_cardState createState() => _Register_cardState();
}

class _Register_cardState extends State<Register_card> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          TextFormField(
              validator: (val) => val.isEmpty ? 'Enter an Email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
              decoration: InputDecoration(
                  labelText: "Email", hintText: "Enter your Email")),
          SizedBox(height: 20.0),
          TextFormField(
              obscureText: true,
              validator: (val) =>
                  val.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
              decoration: InputDecoration(
                  labelText: "Password", hintText: "Enter your password")),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                dynamic result =
                    await _auth.RegisterWithEmailAndPassword(email, password);
                if (result == null) {
                  setState(() => error = 'Please supply a valid email');
                }
              }
            },
          ),
          SizedBox(height: 12.0),
          Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
        ]),
      ),
    );
  }
}
