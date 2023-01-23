import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/chips_tab_provider.dart';

import 'package:shop/widgets/item/products_overview_screen.dart';

class Stack1Item extends StatelessWidget {
  final String title, url;
  final List chipLabels;
  Stack1Item({
    @required this.title,
    @required this.url,
    @required this.chipLabels,
  });

  @override
  Widget build(BuildContext context) {
    // print('building Stack1Item');
    return InkWell(
      onTap: () => openProductOverviewScreen(context),
      child: child(),
    );
  }

  Stack child() {
    return Stack(children: [
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: CachedNetworkImage(
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl: url,
        ),
      ),
      Positioned(
        top: 3,
        left: 3.3,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(20)),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    ]);
  }

  void openProductOverviewScreen(BuildContext context) {
    pushNewScreenWithRouteSettings(context,
            screen: ProductsOverviewScreen(),
            pageTransitionAnimation: PageTransitionAnimation.fade,
            withNavBar: true,
            settings: RouteSettings(name: '/home', arguments: chipLabels))
        .then((value) {
      context.read<ChipsTabProvider>().resetInitializedData();
    });
  }
}
