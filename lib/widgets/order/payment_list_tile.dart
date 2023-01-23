import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/order/order_provider.dart';

class PaymentOptionListTile extends StatelessWidget {
  final String paymentName, logoPath;
  final bool isChoosen;

  PaymentOptionListTile(
      {@required this.paymentName,
      @required this.isChoosen,
      @required this.logoPath});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 35,
        width: 35,
        child: Image.asset(
          logoPath,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        '$paymentName',
        style: TextStyle(color: Colors.white),
      ),
      trailing: Checkbox(
        value: isChoosen,
        checkColor: Colors.blue,
        fillColor: MaterialStateProperty.all(Colors.white),
        onChanged: (value) {
          print('...................');
          context.read<OrderProvider>().changeOption(paymentName);
        },
      ),
    );
  }
}
