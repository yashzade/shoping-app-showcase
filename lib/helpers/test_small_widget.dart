import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SmallTestWidget extends StatefulWidget {
  @override
  _SmallTestWidgetState createState() => _SmallTestWidgetState();
}

class _SmallTestWidgetState extends State<SmallTestWidget> {
  PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [Home(), Home()];
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
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
        inactiveIcon: Icon(Icons.car_rental),
        icon: Icon(
          Icons.home,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
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

      navBarStyle: NavBarStyle.simple,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Home');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, 'child');
                pushNewScreen(context, screen: ChildWidget());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Text('product adder Small widgett '),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({Key key}) : super(key: key);
  static String route = 'child';
  @override
  Widget build(BuildContext context) {
    print('ChildWidget');
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [Text('child screen '), TextFormField()],
        ),
      ),
    );
  }
}
