// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../screens/product_detail_screen.dart';
// import '../providers/product.dart';

// class ProductItem extends StatelessWidget {
//   // final String id;
//   // final String title;
//   // final String imageUrl;

//   // ProductItem(this.id, this.title, this.imageUrl);

//   @override
//   Widget build(BuildContext context) {
//     final product = Provider.of<Product>(context, listen: false);
//     // final cart = Provider.of<Cart>(context, listen: false);
//     // final authData = Provider.of<Auth>(context, listen: false);
//     // showDialog(context: context, builder: (_) {return InkWell(,child: ListTile(selected: ,))});
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: GridTile(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushNamed(
//               ProductDetailScreen.routeName,
//               arguments: product.id,
//             );
//           },
//           child: Hero(
//             tag: product.id,
//             child: FadeInImage(
//               placeholder: AssetImage('assets/images/product-placeholder.png'),
//               fadeInCurve: Curves.bounceIn,
//               image: NetworkImage(
//                 product.imageUrl,
//               ),
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         footer: GridTileBar(
//           backgroundColor: Colors.black87,
//           leading: Consumer<Product>(
//             builder: (ctx, product, _) => IconButton(
//               icon: Icon(
//                 product.isFavorite ? Icons.favorite : Icons.favorite_border,
//               ),
//               color: Theme.of(context).accentColor,
//               onPressed: () {
//                 product.toggleFavoriteStatus();
//               },
//             ),
//           ),
//           title: Text(
//             product.title,
//             textAlign: TextAlign.center,
//           ),
//           trailing: IconButton(
//             icon: Icon(
//               Icons.shopping_cart,
//             ),
//             onPressed: () {
//               // cart.addItem(product.id, product.price, product.title);
//               ScaffoldMessenger.of(context).hideCurrentSnackBar();

//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Added item to cart!',
//                   ),
//                   duration: Duration(seconds: 2),
//                   action: SnackBarAction(
//                     label: 'UNDO',
//                     onPressed: () {
//                       // cart.removeSingleItem(product.id);
//                     },
//                   ),
//                 ),
//               );
//             },
//             color: Theme.of(context).accentColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
