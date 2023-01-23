import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditScreen extends StatelessWidget {
  static String route = 'route';
  Map<String, dynamic> formFieldsData = {};
  static final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  Map userData;

  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    print('Buildding EditScreen');

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Edit Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                cardLabel(label: 'Personal Detail'),
                personalDetailCard(),
                SizedBox(height: 15),
                cardLabel(label: 'Address'),
                addressCard(),
                SizedBox(height: 12),
                addButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardLabel({@required String label}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '$label',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding addButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ElevatedButton(
        onPressed: () => uploadData(context),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        child: Text('Add'),
      ),
    );
  }

  void uploadData(BuildContext context) async {
    _formKey3.currentState.save();
    print(formFieldsData);
    await FirebaseFirestore.instance
        .collection('user detail')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(formFieldsData, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Added'),
      duration: Duration(seconds: 3),
    ));
  }

  TextFormField makeField(
      {@required String value, String label, int maxLines}) {
    return TextFormField(
      initialValue: userData['$value'],
      maxLines: maxLines,
      key: ValueKey('$value'),
      // validator: (value) {
      //   if (value.length <= 6) {
      //     print(value.length);
      //     return 'Password should contain greater than 5 characters';
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: label ?? value,
      ),
      onSaved: (onSavedValue) {
        formFieldsData[value] = onSavedValue;
      },
    );
  }

  Card addressCard() {
    return Card(
      margin: EdgeInsets.only(left: 10, top: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            makeField(
                value: 'address',
                label: 'House no, Building name, Plot no, Locality, Area*',
                maxLines: 3),
            makeField(value: 'city', label: 'City*'),
            makeField(value: 'state', label: 'State*'),
            makeField(value: 'pincode', label: 'Pincode*'),
            makeField(value: 'landmark', label: 'Landmark'),
          ],
        ),
      ),
    );
  }

  Card personalDetailCard() {
    return Card(
      margin: EdgeInsets.only(left: 10, top: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            makeField(value: 'name', label: 'name*'),
            makeField(value: 'phone number', label: 'Phone number*'),
            makeField(value: 'alternative number', label: 'Alternative number'),
          ],
        ),
      ),
    );
  }
}
