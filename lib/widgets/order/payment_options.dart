import 'package:flutter/material.dart';
import 'package:shop/widgets/order/order_provider.dart';
import 'package:shop/widgets/order/payment_list_tile.dart';
import 'package:provider/provider.dart';

class Paymentoptions extends StatefulWidget {
  @override
  _PaymentoptionsState createState() => _PaymentoptionsState();
}

class _PaymentoptionsState extends State<Paymentoptions> {
  List<Map> paymentOptions = [
    {'title': 'GooglePay', 'logo path': 'assets/images/gpay2.png'},
    {'title': 'Cash On Delivery', 'logo path': 'assets/images/COD.png'}
  ];

  var optionChoosed = 'Cash On Delivery';

  @override
  Widget build(BuildContext context) {
    optionChoosed = context.select((OrderProvider op) => op.optionChoosed);
    return Column(
      children: [
        ...paymentOptions.map((element) {
          return PaymentOptionListTile(
            paymentName: element['title'],
            isChoosen: element['title'] == optionChoosed,
            logoPath: element['logo path'],
          );
        })
      ],
    );
  }
}
