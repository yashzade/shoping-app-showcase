import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/widgets/Cart/cart_screen.dart';

class CustomBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context, listen: true);
    // final cartProvider = context.select((CartProvider cp) => cp.totalAmount);
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
                  Text(
                    'Total : ₹',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 17, color: Colors.grey),
                  ),
                  Selector<CartProvider, double>(
                      builder: (_, data, __) {
                        print('BottomSheetCustom selector');
                        return Text(
                          '${data.toStringAsFixed(0)}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontSize: 22),
                        );
                      },
                      selector: (ctx, cp) => cp.totalAmount),
                  Spacer(),
                  OrderButton(cart: context.read<CartProvider>()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
