import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserDetailProvider extends ChangeNotifier {
  Map userDetails;
  String getAddress() {
    return userDetails['address'] + ', ' + userDetails['pincode'];
  }

  Future<void> fetchUserDetails() async {
    print('UserDetailProvider fetchUserDetails()');
    var data = await FirebaseFirestore.instance
        .collection('user detail')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    userDetails = data.data();
  }
}
