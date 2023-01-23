import 'package:flutter/material.dart';
import 'package:shop/widgets/order_history/order_history_item.dart';

class SpecificOrderListView extends StatelessWidget {
  Map<String, dynamic> orderHistory;
  @override
  Widget build(BuildContext context) {
    orderHistory = ModalRoute.of(context).settings.arguments;
    var itemskey = (orderHistory['order items'] as Map).keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Total ${orderHistory['order amount']}',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          ...itemskey.map((e) {
            return OrderHistoryItem3(item: orderHistory['order items'][e]);
          })
        ],
      ),
    );
  }
}
