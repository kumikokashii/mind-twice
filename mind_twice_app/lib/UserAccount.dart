import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccount extends StatefulWidget {
  String actionType;
  BuildContext context;
  SharedPreferences prefs;
  TextEditingController emailInputController;
  TextEditingController passwordInputController;
  UserAccount(this.actionType, this.context, this.prefs)
      : emailInputController = TextEditingController(),
        passwordInputController = TextEditingController();

  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final _formKey = GlobalKey<FormState>();
  String formErrorMessage;

  _UserAccountState() : formErrorMessage = '';

  Future<FirebaseUser> getFirebaseAccount(actionType, email, password) async {
    try {
      AuthResult result;
      if (actionType == 'create') {
        result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {  //'login'
        result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      }
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> titleStr = {
      'create': 'Create account',
      'login': 'Log in to account'
    };
    Map<String, String> submitButonStr = {
      'create': 'Create',
      'login': 'Log in'
    };
    return AlertDialog(
        title: Center(child: Text(titleStr[widget.actionType])),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          //Error message
          formErrorMessage != ''
              ? Text(formErrorMessage, style: TextStyle(color: Colors.red))
              : SizedBox.shrink(),
          Form(
            key: _formKey,
            child: Column(children: <Widget>[
              //Email input
              TextFormField(
                controller: widget.emailInputController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value.isEmpty ? 'Please enter email' : null,
              ),

              //Password input
              TextFormField(
                controller: widget.passwordInputController,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) =>
                    value.isEmpty ? 'Please enter password' : null,
                obscureText: true,
              ),

              //Space
              SizedBox(
                height: 25,
              ),

              //Buttons
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                //Cancel button
                FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                    child: Text('Cancel',
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),

                //Submit button
                FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                    child: Text(submitButonStr[widget.actionType],
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          //Store the user id in shared preferences
                          FirebaseUser user = await getFirebaseAccount(
                              widget.actionType,
                              widget.emailInputController.text,
                              widget.passwordInputController.text);
                          widget.prefs.setString('userId', user.uid);
                          widget.prefs.setString('email', user.email);
                          Navigator.of(context).pop(true); //true is signal to setstate above
                        } catch (e) {
                          setState(() {
                            formErrorMessage = e.message;
                          });
                        }
                      }
                    }),
              ])
            ]),
          ),
        ]));
  }
}
