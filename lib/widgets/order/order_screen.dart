import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/user_detail_provider.dart';
import 'package:shop/widgets/order/bottom_sheet2.dart';
import 'package:shop/widgets/order/payment_options.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomSheet: BottomSheetCustom2(), //bottom botton
      appBar: AppBar(
        brightness: Brightness.dark,
        leadingWidth: 25,
        title: Text(
          'Payment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.payment,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paymentCard(context),
          addressField(context),
        ],
      ),
    );
  }

  Container paymentCard(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[800]),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTotalPrice(context),
          SizedBox(
            height: 18,
          ),
          Text(
            'Payment Options :',
            style: TextStyle(
                color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Paymentoptions(),
        ],
      ),
    );
  }

  Container addressField(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        '${context.read<UserDetailProvider>().getAddress()}',
        style: TextStyle(color: Colors.grey[400]),
      ),
    );
  }

  Row showTotalPrice(BuildContext context) {
    return Row(
      children: [
        Text(
          'Total : ',
          style: TextStyle(
              color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Text(
          '${Provider.of<CartProvider>(context, listen: false).totalAmount}',
          style: TextStyle(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
