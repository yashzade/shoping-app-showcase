import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop/providers/cart_provider.dart';

import 'package:shop/widgets/product_detail/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'cart_bottom_button.dart';

class CartItemWidget2 extends StatelessWidget {
  final CartItem cartItem;
  CartItemWidget2({@required this.cartItem});
  @override
  Widget build(BuildContext context) {
    print('building CartItemWidget2');

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red[600],
          icon: Icons.delete,
          onTap: () {
            context.read<CartProvider>().removeItem(cartItem.itemId);
          },
        ),
        IconSlideAction(
          caption: 'Save For Later',
          color: Colors.indigo,
          icon: Icons.save_rounded,
          onTap: () => null,
        )
      ],
      child: InkWell(
        onTap: () => _openProductDetailScreen(context),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Row(
            children: [
              buildImage(cartItem),
              buildItemDetails(cartItem, context),
            ],
          ),
        ),
      ),
    );
  }

  void _openProductDetailScreen(BuildContext context) {
    print('_openProductDetailScreen()');
    pushNewScreen(
      context,
      pageTransitionAnimation: PageTransitionAnimation.scale,
      withNavBar: false,
      screen: ProductDetailScreen(),
    );
  }

  Widget buildItemDetails(CartItem item, BuildContext context) {
    return Flexible(
      child: Container(
        height: 110,
        padding: EdgeInsets.only(left: 8, right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[850], width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 13),
              child: Row(
                children: [
                  Text(
                    '${item.weight} . ₹${item.price}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            CartItemButton(
              cartItem: cartItem,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(CartItem item) {
    return Card(
      child: Container(
        height: 110,
        width: 110,
        child: CachedNetworkImage(
          imageUrl: item.imageUrl,
        ),
      ),
    );
  }
}
