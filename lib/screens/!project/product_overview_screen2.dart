// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/providers/item_sizes.dart';
// import 'package:shop/screens/search_screen.dart';
// import 'package:shop/widgets/item/basket_item2.dart';
// import 'package:shop/widgets/item/basket_item_list.dart';
// import 'package:shop/widgets/other/app_drawer.dart';
// import 'package:shop/widgets/other/badge.dart';
// import 'package:shop/widgets/other/chips_row_main.dart';
// import 'package:shop/widgets/other/custom_chips.dart';
// import 'package:shop/widgets/search/search.dart';

// import '../../providers/cart.dart';
// import '../cart/cart_screen.dart';
// import '../../providers/products.dart';

// enum FilterOptions {
//   Favorites,
//   All,
// }

// class ProductsOverviewScreen2 extends StatefulWidget {
//   @override
//   _ProductsOverviewScreen2State createState() =>
//       _ProductsOverviewScreen2State();
// }

// class _ProductsOverviewScreen2State extends State<ProductsOverviewScreen2> {
//   var _isInit = true;
//   var _isLoading;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       _isLoading = true;

//       Provider.of<Products>(context).fetchAndSetProducts().then(
//         (_) {
//           Provider.of<Cart>(context, listen: false).fetchCartItems().then(
//                 (_) => setState(() {
//                   _isLoading = false;
//                 }),
//               );
//         },
//       );
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('insider ProductsOverviewScreen Screen SSSSSS');
//     final itemProvider = Provider.of<Products>(context, listen: false);
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         // appBar: AppBar(

//         //   backgroundColor: Colors.black,
//         //   centerTitle: true,
//         //   title: Text('MyShop'),
//         //   actions: actions(context),
//         // ),
//         // drawer: AppDrawer(),
//         body: CustomScrollView(
//           slivers: [
//             if (!_isLoading)
//               SliverAppBar(
//                 // expandedHeight: 110,

//                 pinned: true,
//                 // floating: true,
//                 // snap: dalse,

//                 // title: Text('Vegetable, Fruits'),
//                 bottom: PreferredSize(
//                   child: ChipsRow(),
//                   preferredSize: Size.fromHeight(100),
//                 ),
//                 backgroundColor: Colors.black,
//                 stretch: false,
//                 flexibleSpace: Stack(
//                   children: <Widget>[
//                     Positioned.fill(
//                         child: Image.asset(
//                       'assets/images/fruit&vegetable.jpg',
//                       fit: BoxFit.cover,
//                       scale: 3,
//                     )),
//                   ],
//                 ),
//               ),
//             if (!_isLoading)
//               SliverToBoxAdapter(
//                 child: ChipsRow(),
//               ),
//             _isLoading
//                 ? SliverToBoxAdapter(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   )
//                 : SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                     (ctx, index) {
//                       return ChangeNotifierProvider<ItemSizes>.value(
//                         value: itemProvider.itemsPL[index],
//                         child: BasketItem2(),
//                       );
//                     },
//                     childCount: itemProvider.itemsPL.length,
//                   ))
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> actions(BuildContext context) {
//     List<String> dictionary = Provider.of<Products>(context).dictionary;
//     return <Widget>[
//       Consumer<Cart>(
//         builder: (_, cart, ch) => Badge(
//           child: ch,
//           value: cart.cartItems.length.toString(),
//         ),
//         child: IconButton(
//           icon: Icon(
//             Icons.shopping_cart,
//           ),
//           onPressed: () {
//             Navigator.of(context)
//                 .pushNamed(CartScreen.routeName)
//                 .then((value) => setState(() {}));
//           },
//         ),
//       ),
//       IconButton(
//           onPressed: () async {
//             await showSearch<String>(
//               context: context,
//               delegate: CustomDelegate(data: dictionary),
//             );
//           },

//           // onPressed: () {
//           //   Navigator.of(context)
//           //       .pushNamed(SearchScreen.routeName)
//           //       .then((value) => setState(() {}));
//           // },
//           icon: Icon(Icons.search))
//     ];
//   }
// }
