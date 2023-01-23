import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/instant_items.dart/instant_item_list.dart';
import 'package:shop/widgets/instant_items.dart/instant_provider.dart';
import 'package:shop/widgets/search/search_screen.dart';

class IntantProductOverviewScreen extends StatefulWidget {
  @override
  _IntantProductOverviewScreenState createState() =>
      _IntantProductOverviewScreenState();
}

class _IntantProductOverviewScreenState
    extends State<IntantProductOverviewScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<InstantItemProvider>(context, listen: false)
          .fetchAndSetProducts2()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.tour_sharp),
        title: Text('Top Searches'),
        actions: [
          IconButton(
              onPressed: () => pushNewScreen(context,
                  screen: SearchScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.scale),
              icon: Icon(Icons.search))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Expanded(
                    child: InstantItemList(),
                  ),
                ],
              ),
            ),
    );
  }
}
