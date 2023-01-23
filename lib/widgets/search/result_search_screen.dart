///isSearchingPage: because we are showing same screen for items list and suggestion list, and
///due to this it is not hanging
///
///

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop/widgets/search/search_item_list_page.dart';

import 'package:shop/widgets/search/search_provider.dart';
import 'package:shop/widgets/search/searching_page.dart';

class ResultSearchScreen extends StatefulWidget {
  @override
  _ResultSearchScreenState createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  @override
  Widget build(BuildContext context) {
    print('building ResultSearchScreen');

    var isSearchingPage =
        context.select((SearchProvider sp) => sp.getIsSearchingPage);

    return isSearchingPage ? SearchingPage() : SearchItemListPage();
  }
}
