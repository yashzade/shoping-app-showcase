// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:shop/providers/item_sizes.dart';
// import 'package:shop/widgets/item/bottom_button.dart';

// class BasketItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final itemSizeProvider = Provider.of<ItemSizes>(context,
//         listen: true); // will rebuild for selected index i.e listne true
//     var item =
//         itemSizeProvider.differentSizeItems[itemSizeProvider.selectedIndex];
//     // final cartProvider = Provider.of<Cart>(context, listen: true);1.

//     print('insider BasketItem Widget ${item.title}----');

//     return Column(
//         // mainAxisSize: MainAxisSize.min,
//         // crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Row(
//             children: [
//               buildImage(item),
//               buildItemDetails(item, context, itemSizeProvider)
//             ],
//           ),
//           BottomButton(item: item),
//           Divider()
//         ]);
//   }

//   Flexible buildItemDetails(
//       Item item, BuildContext context, ItemSizes productProvider) {
//     return Flexible(
//       child: Container(
//         // decoration: BoxDecoration(border: Border.all()),
//         margin: EdgeInsets.only(left: 10),
//         child: Column(
//           // mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               item.title,
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
//             ),
//             SizedBox(height: 5),
//             Container(
//               // color: Colors.black45,

//               decoration: BoxDecoration(
//                 border: Border.all(width: 0.5, color: Colors.black45),
//               ),
//               child: InkWell(
//                 onTap: () => showDialog(
//                   context: context,
//                   barrierDismissible: false, // user must tap button!
//                   builder: (BuildContext context) {
//                     return SimpleDialog(
//                       title: Text('choose from available quantity'),
//                       children: <Widget>[
//                         ...productProvider.differentSizeItems
//                             .map((e) => SimpleDialogOption(
//                                   onPressed: () {
//                                     productProvider.changeIndex(productProvider
//                                         .differentSizeItems
//                                         .indexOf(e));
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text(e.weight.toString()),
//                                 ))
//                             .toList(),
//                       ],
//                     );
//                   },
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${item.weight}',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                           color: Colors.black45),
//                     ),
//                     Icon(
//                       Icons.expand_more,
//                       size: 20,
//                       color: Colors.black45,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               '₹${item.price}',
//               style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildImage(Item item) {
//     return Container(
//       height: 150,
//       width: 150,
//       child: Card(
//         clipBehavior: Clip.hardEdge,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         elevation: 2,
//         child: CachedNetworkImage(
//           imageUrl: item.url,
//           placeholder: (_, __) => Image.asset(
//             'assets/images/placeholder.png',
//             height: 150,
//             width: 150,
//           ),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//       ),
//     );
//   }
// }
