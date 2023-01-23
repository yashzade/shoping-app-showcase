import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop/providers/item_sizes.dart';
import 'package:shop/widgets/item/bottom_button2.dart';

import 'package:shop/widgets/product_detail/product_detail_screen.dart';

class Item3 extends StatelessWidget {
  final Item item;
  Item3({@required this.item});

  @override
  Widget build(BuildContext context) {
    print('building Item2');

    return InkWell(
      onTap: () => openProductDetailScreen(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: Column(
          children: [
            Row(
              children: [
                buildImage(item),
                buildItemDetails(item, context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openProductDetailScreen(BuildContext context) {
    print('pushing sliding');
    pushNewScreen(
      context,
      pageTransitionAnimation: PageTransitionAnimation.scale,
      withNavBar: false,
      screen: ProductDetailScreen(),
    );
  }

  Widget buildItemDetails(Item item, BuildContext context) {
    return Flexible(
      child: Container(
        height: 120,
        padding: EdgeInsets.only(left: 10, right: 10),
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
            Container(
                child: BottomButton2(
              item: item,
            )),
          ],
        ),
      ),
    );
  }

  Widget buildImage(Item item) {
    return Container(
      child: FittedBox(
        child: Card(
          child: Container(
            height: 120,
            width: 120,
            child: CachedNetworkImage(
              imageUrl: item.url,
            ),
          ),
        ),
      ),
    );
  }
}
