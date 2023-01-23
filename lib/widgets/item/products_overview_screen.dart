import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/item/items_list.dart';
import 'package:shop/widgets/other/chips_row_main.dart';

import '../../providers/products_provider.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/ProductsOverviewScreen';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var isInit = false;
  var isLoading;
  List chipsLabels;

  @override
  void didChangeDependencies() async {
    if (!isInit) {
      isInit = true;
      isLoading = true;

      chipsLabels = ModalRoute.of(context).settings.arguments;
      await context.read<ProductsProvider>().fetchAndSetProducts2(
            searchQuery: '${chipsLabels[0]}',
          );
      setState(() {
        isLoading = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('building ProductsOverviewScreen');

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  ChipsRow(
                    chipsLabels: chipsLabels,
                  ),
                  Expanded(
                    child: ItemsList(),
                  ),
                ],
              ),
            ),
    );
  }
}
