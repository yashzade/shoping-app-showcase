import 'package:flutter/material.dart';
import 'package:shop/widgets/order/outlined_button_custom.dart';

class BottomSheetCustom2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building BottomSheetCustom');
    return BottomSheet(
      backgroundColor: Theme.of(context).bottomSheetTheme.modalBackgroundColor,
      onClosing: () => null,
      builder: (_) => Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Row(
                children: [
                  Spacer(),
                  OrderOutlinedButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/providers/cart_provider.dart';
// import 'package:shop/screens/cart/cart_screen.dart';

// class BottomSheetCustom extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final cartProvider = Provider.of<CartProvider>(context, listen: true);
//     final cartProvider = context.select((CartProvider cp) => cp.totalAmount);
//     print('Building BottomSheetCustom');
//     return BottomSheet(
//       backgroundColor: Theme.of(context).bottomSheetTheme.modalBackgroundColor,
//       onClosing: () => null,
//       builder: (_) => Container(
//         height: 60,
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Flexible(
//               child: Row(
//                 children: [
//                   Text(
//                     'Total : ₹',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         .copyWith(fontSize: 17, color: Colors.grey),
//                   ),
//                   Consumer<CartProvider>(
//                     builder: (_, value, __) {
//                       return Text(
//                         '${cartProvider.totalAmount.toStringAsFixed(0)}',
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline6
//                             .copyWith(fontSize: 22),
//                       );
//                     },
//                   ),
//                   Text(
//                     '${cartProvider.totalAmount.toStringAsFixed(0)}',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         .copyWith(fontSize: 22),
//                   ),
//                   // SizedBox(
//                   //   width: ,
//                   // ),
//                   Spacer(),
//                   OrderButton(cart: cartProvider),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
