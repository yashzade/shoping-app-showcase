import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/widgets/instant_items.dart/instant_provider.dart';
import 'package:shop/widgets/item/item3.dart';

class InstantItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var items = context.read<InstantItemProvider>().getItems;
    print(items);
    return ListView.builder(
        itemCount: items.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Item3(item: items[index]);
        });
  }
}
