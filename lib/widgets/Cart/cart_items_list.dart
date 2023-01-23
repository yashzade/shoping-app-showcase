import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';

import 'cart_item2.dart';

class CartItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.select(
      (CartProvider cp) => cp.getCartItems.length,
    ); //when we delete item rebuilding the list
    Map<String, CartItem> cartitems = context.read<CartProvider>().getCartItems;
    var cartItemsValues = cartitems.values.toList();

    return cartitems.isEmpty
        ? Center(
            child: Image.asset('assets/images/empty_cart.png', height: 150),
            heightFactor: 2.9)
        : ListView.builder(
            itemCount: cartitems.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return CartItemWidget2(cartItem: cartItemsValues[index]);
            });
  }
}
