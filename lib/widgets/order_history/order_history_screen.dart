import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'dynamic_list_view.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  var _isInit = false;
  var _isDataFetched = false;
  List<Map> orderHistoryList = [];
  Future<void> fetchOrderHistory() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    var fetchedData = await FirebaseFirestore.instance
        .collection('/user detail/$uid/orders')
        .orderBy('order date', descending: true)
        .get();
    fetchedData.docs.forEach((element) {
      orderHistoryList.add(element.data());
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isDataFetched = true;
    });
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) fetchOrderHistory();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Orders History'),
      ),
      body: _isDataFetched
          ? orderHistoryListView(context)
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget orderHistoryListView(BuildContext context) {
    return ListView.builder(
        itemCount: orderHistoryList.length,
        itemBuilder: (ctx, index) {
          var time =
              (orderHistoryList[index]['order date'] as Timestamp).toDate();
          DateFormat.yM().format(time);

          return InkWell(
            onTap: () {
              pushNewScreenWithRouteSettings(context,
                  screen: SpecificOrderListView(),
                  settings: RouteSettings(
                      arguments: orderHistoryList[index], name: '1'));
            },
            child: Container(
              color: Colors.grey[900],
              margin: EdgeInsets.symmetric(vertical: 2),
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('order amount',
                              style: TextStyle(color: Colors.white70)),
                          Text('Items quantity',
                              style: TextStyle(color: Colors.white70)),
                          Text('order date',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(': ${orderHistoryList[index]['order amount']}',
                              style: TextStyle(color: Colors.white70)),
                          Text(': ${orderHistoryList[index]['items count']}',
                              style: TextStyle(color: Colors.white70)),
                          Text(': ${DateFormat.yMMMMEEEEd().format(time)}',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  )),
            ),
          );
        });
  }

  Text labelValue(String text, int index) {
    return Text(': ${orderHistoryList[index][text]}',
        style: TextStyle(color: Colors.white70));
  }
}
