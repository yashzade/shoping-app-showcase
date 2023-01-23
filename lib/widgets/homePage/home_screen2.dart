// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:provider/provider.dart';

// import 'package:shop/providers/cart_provider.dart';
// import 'package:shop/widgets/drawer/modal_screen.dart';
// import 'package:shop/widgets/search/search_screen.dart';

// import 'categorie_cards.dart';

// class HomeScreen2 extends StatefulWidget {
//   static String route = 'dsa';
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   @override
//   _HomeScreen2State createState() => _HomeScreen2State();
// }

// class _HomeScreen2State extends State<HomeScreen2> {
//   var isCartDataFetched = false;
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<CartProvider>(context, listen: false)
//         .fetchCartItems()
//         .then((value) {
//       setState(() {
//         isCartDataFetched = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('building HomeScreen $isCartDataFetched');

//     return isCartDataFetched
//         ? Scaffold(
//             // backgroundColor: Colors.white,
//             backgroundColor: Theme.of(context).primaryColor,
//             appBar: AppBar(
//               title: Row(
//                 children: [
//                   SizedBox(
//                     child: Image.asset('assets/images/insta cart2.png'),
//                     height: 30,
//                     width: 30,
//                   ),
//                   Text(
//                     'ZMart',
//                     style: TextStyle(
//                         color: Colors.greenAccent[700],
//                         fontWeight: FontWeight.w700,
//                         fontStyle: FontStyle.italic,
//                         letterSpacing: 0.3,
//                         fontSize: 20),
//                   ),
//                 ],
//               ),
//               actions: [
//                 IconButton(
//                     onPressed: () {
//                       pushDynamicScreen(context,
//                           screen: SampleModalScreen(), withNavBar: true);
//                     },
//                     icon: Icon(
//                       Icons.search_sharp,
//                       color: Colors.white,
//                     )),
//                 IconButton(
//                     onPressed: () => pushNewScreen(context,
//                         screen: SearchScreen(),
//                         pageTransitionAnimation: PageTransitionAnimation.scale),
//                     icon: Icon(
//                       Icons.settings,
//                       color: Colors.white,
//                     )),
//               ],
//             ),
//             body: SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.only(top: 40),
//                 child: CategorieCards(),
//               ),
//             ),
//           )
//         : Container(
//             color: Theme.of(context).primaryColor,
//             child: Center(
//                 child: CircularProgressIndicator(
//               color: Colors.amber,
//               backgroundColor: Colors.green[400],
//             )));
//   }
// }
