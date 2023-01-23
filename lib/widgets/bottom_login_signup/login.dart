import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  static final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  String email, password;
  void login(BuildContext context) async {
    _formKey3.currentState.save();

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('login SuccessFull')));

      Navigator.pop(context);
    }).catchError((error) {
      print('................error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${error.code}'),
        behavior: SnackBarBehavior.floating,
      ));
      print(error.code);
      print('................error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          height: 300,
          child: Form(
            key: _formKey3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('Email Address'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                  ),
                  onSaved: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  key: ValueKey('Password'),
                  validator: (value) {
                    if (value.length <= 6) {
                      print(value.length);
                      return 'Password should contain greater than 5 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  onSaved: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () => login(context),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: Text('Sign in'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
