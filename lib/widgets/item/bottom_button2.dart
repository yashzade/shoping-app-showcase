import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';

import 'package:shop/providers/item_sizes.dart';
import 'package:shop/widgets/bottom_login_signup/bottom_authentication.dart';

class BottomButton2 extends StatefulWidget {
  final Item item;
  BottomButton2({@required this.item});
  @override
  _BottomButton2State createState() => _BottomButton2State();
}

class _BottomButton2State extends State<BottomButton2> {
  @override
  Widget build(BuildContext context) {
    // print('building BottomButton');

    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    var itemId = widget.item.itemId;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        cartProvider.isInCart(itemId)
            ? Container(
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.grey,
                        ),
                        onPressed: () => decrementItem(context, itemId)),
                    Text(
                      '${cartProvider.itemQuantity(itemId)}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                        onPressed: () => incrementItem(context, itemId))
                  ],
                ),
              )
            : TextButton(
                onPressed: () => addItem(context, itemId),
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
      ],
    );
  }

  void decrementItem(BuildContext context, itemId) async {
    await context.read<CartProvider>().decrementItem(itemId);
    setState(() {});
  }

  void incrementItem(BuildContext context, itemId) async {
    await context.read<CartProvider>().incrementItem(itemId);
    setState(() {});
  }

  void addItem(BuildContext context, itemId) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await context.read<CartProvider>().addItem(widget.item);
      setState(() {});
    } else {
      showBarModalBottomSheet(
        useRootNavigator: true,
        animationCurve: Curves.easeIn,
        context: context,
        builder: (ctx) => BottomAuthenticationModal(),
      );
    }
  }
}
