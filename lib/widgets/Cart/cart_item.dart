// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/providers/cart_provider.dart' as provider;
// import 'package:shop/widgets/Cart/cart_bottom_button.dart';

// class CartItemWidget extends StatefulWidget {
//   final String productId; // remove
//   final Function rebuildList;
//   CartItem({@required this.productId, @required this.rebuildList});

//   @override
//   _CartItemState createState() => _CartItemState();
// }

// class _CartItemState extends State<CartItem> {
//   @override
//   Widget build(BuildContext context) {
//     print('insider CartItem Widget----');
//     var cartItemProvider =
//         Provider.of<provider.CartItem>(context, listen: false);
//     var cartProvider =
//         Provider.of<provider.CartProvider>(context, listen: false);
//     return Slidable(
//       actionPane: SlidableDrawerActionPane(),
//       secondaryActions: <Widget>[
//         IconSlideAction(
//           caption: 'Delete',
//           color: Colors.red[600],
//           icon: Icons.delete,
//           onTap: () {
//             cartProvider.removeItem(cartItemProvider.itemId);
//           },
//         ),
//         IconSlideAction(
//           caption: 'Save For Later',
//           color: Colors.indigo,
//           icon: Icons.save_rounded,
//           onTap: () => null,
//         )
//       ],
//       child: Row(
//         children: [
//           imageBuilder2(cartItemProvider),
//           itemDetailsBuilder(cartItemProvider, cartProvider),
//         ],
//       ),
//     );
//   }

//   Flexible itemDetailsBuilder(
//       provider.CartItem cartItemProvider, provider.CartProvider cartProvider) {
//     return Flexible(
//         child: Container(
//             height: 150,
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     cartItemProvider.title,
//                     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
//                   ),
//                   Text(
//                     '${cartItemProvider.weight}',
//                     style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '₹${cartItemProvider.price * cartItemProvider.quantity}',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 17),
//                       ),
//                       CartItemButton(cartItem: cartItemProvider)
//                     ],
//                   ),
//                 ])));
//   }

//   Widget imageBuilder2(provider.CartItem cartItemProvider) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       child: SizedBox(
//         height: 110,
//         width: 110,
//         child: CachedNetworkImage(
//           imageUrl: cartItemProvider.imageUrl,
//           placeholder: (_, __) => Image.asset(
//             'assets/images/placeholder.png',
//             height: 130,
//             width: 150,
//           ),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//       ),
//     );
//   }
// }
