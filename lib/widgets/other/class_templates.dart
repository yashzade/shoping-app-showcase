// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class OrderHistory extends StatefulWidget {
//   @override
//   _OrderHistoryState createState() => _OrderHistoryState();
// }

// class _OrderHistoryState extends State<OrderHistory> {
//   var _isInit = false;
//   var _isDataFetched = false;
//   List<Map> orderHistoryList = [];
//   Future<void> fetchOrderHistory() async {
//     var uid = FirebaseAuth.instance.currentUser.uid;
//     var fetchedData = await FirebaseFirestore.instance
//         .collection('/user detail/$uid/orders')
//         .orderBy('order date')
//         .get();
//   }

//   @override
//   void didChangeDependencies() {
//     if (!_isInit) fetchOrderHistory();

//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isDataFetched ? Text('data') : CircularNotchedRectangle();
//   }
// }
