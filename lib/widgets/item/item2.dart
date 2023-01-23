import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:shop/providers/item_sizes.dart';

import 'package:shop/widgets/product_detail/product_detail_screen.dart';
import 'package:shop/widgets/item/bottom_button.dart';

class Item2 extends StatelessWidget {
  final Item item;
  Item2({@required this.item});

  @override
  Widget build(BuildContext context) {
    print('building Item2');

    return InkWell(
      onTap: () => openProductDetailScreen(context),
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 2),
        child: Card(
          clipBehavior: Clip.none,
          color: Theme.of(context).primaryColor,
          child: Container(
            padding: EdgeInsets.only(right: 15),
            // margin: EdgeInsets.symmetric(vertical: 5),
            // decoration: containerBoxDecoration,
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
        height: 150,
        padding: EdgeInsets.only(left: 5),
        // decoration: BoxDecoration(border: Border.all()),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${item.weight} . ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '₹${item.price}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Container(
              child: BottomButton(
                item: item,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(Item item) {
    return Card(
      child: Container(
        height: 130,
        width: 130,
        child: CachedNetworkImage(
          imageUrl: item.url,
          placeholder: (_, __) => Image.asset(
            'assets/images/placeholder.png',
            height: 130,
            width: 130,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
