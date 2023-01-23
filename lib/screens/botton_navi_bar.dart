import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/helpers/test_small_widget.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/user_detail_provider.dart';

import 'package:shop/widgets/Cart/cart_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop/widgets/drawer/edit_scree.dart';
import 'package:shop/widgets/homePage/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:shop/widgets/instant_items.dart/instant_product_overview_Screen.dart';
import 'package:shop/widgets/search/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PersistentTabController _controller;
  var isDataFetched = false;
  bool _isInit = false;

  void fetchData() async {
    _isInit = true;
    if (FirebaseAuth.instance.currentUser != null) {
      print('1');
      Provider.of<CartProvider>(context, listen: false).fetchCartItems();
      print('2');
      await Provider.of<UserDetailProvider>(context, listen: false)
          .fetchUserDetails();
      print('3');

      setState(() {
        isDataFetched = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      fetchData();
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    print('Building BottomNavBar $isDataFetched');
    return isDataFetched
        ? PersistentTabView(
            context,
            hideNavigationBar: false,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            stateManagement: true,
            confineInSafeArea: true,
            backgroundColor: Colors.grey[900], // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            // navBarHeight: 52,
            resizeToAvoidBottomInset:
                false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.

            hideNavigationBarWhenKeyboardShows:
                false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            // itemAnimationProperties: ItemAnimationProperties(
            //   // Navigation Bar's items animation properties.
            //   duration: Duration(milliseconds: 500),
            //   curve: Curves.bounceOut,
            // ),
            // screenTransitionAnimation: ScreenTransitionAnimation(
            //   // Screen transition animation on change of selected tab.
            //   animateTabTransition: true,
            //   curve: Curves.easeInOutBack, //decelerate

            //   duration: Duration(milliseconds: 500),
            // ),

            navBarStyle: NavBarStyle.simple,
          )
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Loading',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ));
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), IntantProductOverviewScreen(), CartScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        inactiveIcon: Icon(Icons.home_outlined),
        icon: Icon(
          Icons.home,
        ),
        title: ("Home"),
        routeAndNavigatorSettings:
            RouteAndNavigatorSettings(initialRoute: "home", routes: {
          SearchScreen.routeName: (ctx) => SearchScreen(),
          ChildWidget.route: (ctx) => ChildWidget(),
          EditScreen.route: (ctx) => EditScreen(),
        }),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        inactiveIcon: Icon(Icons.view_list),
        icon: Icon(Icons.view_list_outlined),
        title: ("List"),
      ),
      PersistentBottomNavBarItem(
        // routeAndNavigatorSettings:
        //     RouteAndNavigatorSettings(initialRoute: "home", ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        inactiveIcon: Icon(Icons.shopping_basket_outlined),
        icon: Icon(Icons.shopping_basket),
        title: ("Cart"),
        onPressed: (_) {
          pushNewScreen(
            context,
            pageTransitionAnimation: PageTransitionAnimation.scale,
            withNavBar: false,
            screen: CartScreen(),
          );
        },
      ),
    ];
  }
}
