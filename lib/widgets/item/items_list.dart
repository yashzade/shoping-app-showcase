import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop/providers/chips_tab_provider.dart';

import 'package:shop/providers/products_provider.dart';

import 'item3.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  void onLoading() async {
    print('onLoading()');
    await context.read<ProductsProvider>().fetchNextItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Building ItemsList');

    String labelKey = context.read<ProductsProvider>().getCurrentItemLabel;
    context.select((ChipsTabProvider ctp) =>
        ctp.getselectedIndex); //change with the chip click
    final itemsPL =
        Provider.of<ProductsProvider>(context, listen: false).getItems;

    return SmartRefresher(
      controller: context.read<ProductsProvider>().getrefreshController,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: () => onLoading(),
      child: ListView.builder(
        key: Key(labelKey),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: itemsPL.length,
        itemBuilder: (_, index) {
          return Item3(item: itemsPL[index]);
        },
      ),
    );
  }
}
