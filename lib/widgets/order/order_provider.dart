import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/user_detail_provider.dart';

class OrderProvider with ChangeNotifier {
  var optionChoosed = 'Cash On Delivery';
  void changeOption(String selectedoption) {
    print('changeOption()');

    optionChoosed = selectedoption;
    notifyListeners();
  }

  Future<void> placeOrder(BuildContext context) async {
    Map cartDetails =
        Provider.of<CartProvider>(context, listen: false).getDetailsForOrder();
    var address = Provider.of<UserDetailProvider>(context, listen: false)
        .userDetails['address'];

    Map<String, dynamic> data = {
      'order date': Timestamp.now(),
      'address': address,
      ...cartDetails
    };

    await FirebaseFirestore.instance
        .collection(
            '/user detail/${FirebaseAuth.instance.currentUser.uid}/orders')
        .doc()
        .set(data);
  }
}
