import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/widgets/order/order_provider.dart';

class OrderOutlinedButton extends StatefulWidget {
  @override
  _OrderOutlinedButtonState createState() => _OrderOutlinedButtonState();
}

class _OrderOutlinedButtonState extends State<OrderOutlinedButton> {
  var isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    // var path = FirebaseFirestore.instance.collection('user detail').doc();
    // print(path);

    return isButtonPressed ? CircularProgressIndicator() : orderButton(context);
  }

  OutlinedButton orderButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => placeOrder(context),
      child: Selector<OrderProvider, String>(
          builder: (_, optionChoosedData, __) =>
              optionChoosedData == 'Cash On Delivery'
                  ? Text(
                      'order',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Pay  ₹${context.read<CartProvider>().totalAmount}',
                      style: TextStyle(color: Colors.white),
                    ),
          selector: (ctx, op) => op.optionChoosed),
      style: ButtonStyle(
        enableFeedback: true,
        side: MaterialStateProperty.all(
          BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void placeOrder(BuildContext context) async {
    setState(() {
      isButtonPressed = true;
    });

    context.read<OrderProvider>().placeOrder(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('order Placed')));

    await context.read<CartProvider>().deleteCart();
    await Future.delayed(Duration(seconds: 2));

    Navigator.popUntil(context, (route) {
      return route.settings.name == "/";
    });
  }
}
