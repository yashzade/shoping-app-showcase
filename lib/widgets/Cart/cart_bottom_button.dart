import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';

class CartItemButton extends StatefulWidget {
  final CartItem cartItem;
  CartItemButton({@required this.cartItem});
  @override
  _CartItemButtonState createState() => _CartItemButtonState();
}

class _CartItemButtonState extends State<CartItemButton> {
  @override
  Widget build(BuildContext context) {
    print('_CartItemButtonState ${widget.cartItem.title}');
    return Row(
      children: [
        Spacer(),
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.grey,
          ),
          onPressed: () async {
            //decrement()
            await context
                .read<CartProvider>()
                .decrementItem(widget.cartItem.itemId);
            setState(() {});
          },
          splashRadius: 20,
        ),
        Text(
          '${widget.cartItem.quantity}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.grey,
          ),
          onPressed: () async {
            //increment()
            await context
                .read<CartProvider>()
                .incrementItem(widget.cartItem.itemId);
            setState(() {});
          },
        ),
      ],
    );
  }
}
