import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  static final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  String address, name, phoneNumber, emailId, password;
  void signup(BuildContext context) async {
    _formKey2.currentState.save();
    try {
      var credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailId, password: password);

      var additionalData = {
        'name': name,
        'phone number': phoneNumber,
        'email': emailId,
      };
      await FirebaseFirestore.instance
          .collection('user detail')
          .doc(credentials.user.uid)
          .set(additionalData);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('signup SuccessFull')));
      Navigator.pop(context);
    } catch (error) {
      print('................error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${error.code}'),
        behavior: SnackBarBehavior.floating,
      ));
      print(error.code);
      print('................error');
    }

    // print(credentials.credential);
    // print('................');
    // print(additionalData);
    // print(credentials.additionalUserInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey2,
            child: Column(
              // mainAxisSize: MainAxisSize.min,   mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextFormField(
                  key: ValueKey('Name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name*',
                  ),
                  onSaved: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  key: ValueKey('Pno.'),
                  validator: (value) {
                    if (value.isEmpty || value.length == 9) {
                      return 'Enter Correct Number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Phone Number*',
                  ),
                  onSaved: (value) {
                    phoneNumber = value;
                  },
                ),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email address*',
                      hintText: 'For account recovery'),
                  onSaved: (value) {
                    emailId = value;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.length >= 5) {
                      return 'Password lenght greater than 5 ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password*'),
                  // obscureText: true,
                  onSaved: (value) {
                    password = value;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () => signup(context),
                    child: Text('Sign up'),
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
