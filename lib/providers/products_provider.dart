import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shop/providers/item_sizes.dart';

// enum FetchStatus { NoData, HaveData }

class ProductsProvider with ChangeNotifier {
//----------------------------------variables
  List _itemsPL = []; //itemProviderList <Items>

  String _currentItemLabel = '';

  Map<String, List<Item>> _queryItems =
      {}; // { fru:[Item,Item,Item], veg:[...]] }
  Map<String, QueryDocumentSnapshot> _queryItemsLastIndex =
      {}; // { fru:QueryDocumentSnapshot }

  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

//----------------------------------get
  get getrefreshController {
    return _refreshController;
  }

  get getCurrentItemLabel {
    return _currentItemLabel;
  }

  get getItems {
    return [..._itemsPL];
  }

//----------------------------------functions
  void resetInitializedData() {
    print('resetInitializedData()');
    _itemsPL = [];
    _queryItems = {};
    print('resetInitialized productsData');
  }

  List<Item> makeItemObjects(List<DocumentSnapshot> fetchedData) {
    // print('makeItemObjects()');
    List<Item> items = [];
    fetchedData.forEach((document) {
      var documentData = document.data(); //Map<String,..>

      documentData['different sizes'].forEach((key, value) {
        // print(value['price']);
        items.add(
          Item(
              title: documentData['title'],
              weight: value['weight'],
              price: value['price'] ~/ 1,
              url: value['url'],
              quantity: value['quantity'],
              category: documentData['category'],
              itemId: key),
        );
      });
    });
    return items;
  }

  Future<void> fetchNextItems() async {
    print('fetchNextItems()');

    var response = await FirebaseFirestore.instance
        .collectionGroup('products')
        .limit(20)
        .startAfterDocument(_queryItemsLastIndex[_currentItemLabel])
        .where('tags', arrayContains: '$_currentItemLabel')
        .get();

    if (response.size == 0) {
      _refreshController.loadNoData();
    } else {
      _queryItemsLastIndex[_currentItemLabel] = response.docs.last;
      _queryItems[_currentItemLabel].addAll(makeItemObjects(response.docs));
      _refreshController.loadComplete();
    }
  }

  Future<void> fetchAndSetProducts2({String searchQuery}) async {
    print('fetchAndSetProducts2()  query: $searchQuery');
    _currentItemLabel = searchQuery;
    _refreshController.loadComplete();
    if (_queryItems.containsKey(searchQuery)) {
      await Future(() {}); //otherwise get get error
      _itemsPL = _queryItems[searchQuery];
      notifyListeners();
    } else {
      var querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('products')
          .where('tags', arrayContains: searchQuery)
          .limit(8)
          .get();

      _queryItems['$searchQuery'] = makeItemObjects(querySnapshot.docs);
      // { fru:[Item,Item,Item], veg:[...]] }
      _queryItemsLastIndex['$searchQuery'] = querySnapshot.docs.last;
      // { fru:QueryDocumentSnapshot }

      _itemsPL = _queryItems['$searchQuery'];
      //_itemPL=list ref
      notifyListeners();
      //itemList Widget
    }
  }
}
