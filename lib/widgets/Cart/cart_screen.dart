import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/Cart/bottom_sheet.dart';
import 'package:shop/widgets/Cart/cart_items_list.dart';
import 'package:shop/widgets/order/order_screen.dart';

import '../../providers/cart_provider.dart' show CartProvider;

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  void rebuildList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Building CartScreen ');
    Provider.of<CartProvider>(context).getTotalAmount();
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        bottomSheet: CustomBottomSheet(),
        appBar: AppBar(
          brightness: Brightness.dark,
          leadingWidth: 25,
          title: title(),
          leading: leadingIcon(),
        ),
        body: CartItemsList());
  }

  Container leadingIcon() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Icon(
        Icons.shopping_cart,
      ),
    );
  }

  Text title() {
    return Text(
      'Your Cart',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  // var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance
    //     .collection('/pc/fruits-vegetables/fresh-vegetables')
    //     .snapshots()
    //     .listen((event) {});
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        child: Text(
          'Order',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[850]),
        ),
        onPressed: () => pushNewScreenWithRouteSettings(context,
            screen: OrderScreen(),
            settings: RouteSettings(name: 'name'),
            withNavBar: false),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(15),
            backgroundColor: MaterialStateProperty.all(Colors.deepOrange[300])),
      ),
    );
  }
}


// return SizedBox(
//       width: 100,
//       height: 40,
    //   child: ElevatedButton(
    //     child: _isLoading
    //         ? CircularProgressIndicator()
    //         : Text(
    //             'Order',
    //             style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.grey[850]),
    //           ),
    //     onPressed: (widget.cart.totalAmount2 <= 0 || _isLoading)
    //         ? pushNewScreenWithRouteSettings(context,
    //             screen: OrderScreen(),
    //             settings: RouteSettings(name: 'name'),
    //             withNavBar: false)
    //         : () async {
    //             setState(() {
    //               _isLoading = true;
    //             });

    //             setState(() {
    //               _isLoading = false;
    //             });
    //             // widget.cart.clear();
    //           },
    //     style: ButtonStyle(
    //         elevation: MaterialStateProperty.all(15),
    //         backgroundColor: MaterialStateProperty.all(Colors.deepOrange[300])),
    //   ),
    // );

// Column(
//         children: <Widget>[
//           SizedBox(height: 10),
//           Expanded(
//             child: ListView.separated(
//               separatorBuilder: (_, __) => Divider(
//                 height: 0,
//               ),
//               itemCount: cartProvider.cartItems.length,
//               itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
//                 value: cartItems[index],
//                 builder: (_, __) => CartItem(
//                   productId: cartItemsKeys[index],
//                   rebuildList: rebuildList,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),