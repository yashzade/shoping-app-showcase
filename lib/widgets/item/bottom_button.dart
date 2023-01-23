import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';

import 'package:shop/providers/item_sizes.dart';

class BottomButton extends StatefulWidget {
  final Item item;
  BottomButton({@required this.item});
  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
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
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).accentColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.remove,
                        ),
                        onPressed: () async {
                          print('1');

                          context.read<CartProvider>().decrementItem(itemId);
                          print('3');
                          setState(() {});
                          // cartProvider.decrementItem(itemId).then(
                          //       (value) => setState(
                          //         () {
                          //           // Provider.of<ProductsProvider>();
                          //           print(
                          //               context.read<CartProvider>().cartItems);
                          //         },
                          //       ),
                          //     );
                        }),
                    Text(
                      '${cartProvider.itemQuantity(itemId)}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          cartProvider
                              .incrementItem(itemId)
                              .then((value) => setState(() {}));
                        })
                  ],
                ),
              )
            : SizedBox(
                // width: 90,
                child: TextButton(
                  // style: ButtonStyle(co),
                  onPressed: () {
                    cartProvider.addItem(widget.item).then((value) {
                      setState(() {});
                    });
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
      ],
    );
  }
}
