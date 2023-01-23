import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'package:shop/widgets/bottom_login_signup/bottom_authentication.dart';
import 'package:shop/widgets/drawer/drawer_screen.dart';

import 'package:shop/widgets/homePage/categorie_cards.dart';
import 'package:shop/widgets/search/search_provider.dart';

import 'package:shop/widgets/search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building HomeScreen');

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: appLogo(),
            actions: actions(context),
            floating: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return CategorieCards();
            }, childCount: 1, addAutomaticKeepAlives: false),
          ),
        ],
      ),
    );
  }

  List<Widget> actions(BuildContext context) {
    return [
      IconButton(
          onPressed: () async {
            await pushNewScreen(context,
                screen: ChangeNotifierProvider(
                  create: (ctx) => SearchProvider(),
                  child: SearchScreen(),
                ),
                pageTransitionAnimation: PageTransitionAnimation.scale);
          },
          icon: Icon(
            Icons.search_sharp,
            color: Colors.white,
          )),
      IconButton(
          onPressed: () {
            if (FirebaseAuth.instance.currentUser != null) {
              showBarModalBottomSheet(
                useRootNavigator: true,
                backgroundColor: Colors.grey[800],
                animationCurve: Curves.easeIn,
                context: context,
                builder: (ctx) => DrawerScreen(),
              );
            } else {
              showBarModalBottomSheet(
                useRootNavigator: true,

                animationCurve: Curves.easeIn,
                // secondAnimation: AnimationController(vsync: TickerProvider.),
                context: context,
                builder: (ctx) => BottomAuthenticationModal(),
              );
            }
          },
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          )),
    ];
  }

  Row appLogo() {
    return Row(
      children: [
        SizedBox(
          child: Image.asset('assets/images/insta cart2.png'),
          height: 33,
          width: 33,
        ),
        Text(
          ' ZMart',
          style: TextStyle(
              color: Colors.greenAccent[400],
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              // letterSpacing: 0.3,
              fontSize: 23),
        ),
      ],
    );
  }
}
