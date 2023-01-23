import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/providers/item_sizes.dart';

class InstantItemProvider with ChangeNotifier {
  List _itemsPL = [];
  get getItems {
    return [..._itemsPL];
  }

  List<Item> makeItemObjects(DocumentSnapshot fetchedData) {
    // print('makeItemObjects()');
    List<Item> items = [];
    var documentData = fetchedData.data();
    documentData['instant data'].forEach((value) {
      items.add(
        Item(
            title: value['title'],
            weight: value['quantity'],
            price: value['price'] ~/ 1,
            url: value['url'],
            quantity: 1,
            category: 'instant data',
            itemId: value['title']),
      );
    });

    return items;
  }

  Future<void> fetchAndSetProducts2(
      {String searchQuery, bool fromProductOverviewScreen = false}) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('instant data')
        .doc('nagpur data')
        .get();

    _itemsPL = makeItemObjects(querySnapshot);
    print("_itempl.... $_itemsPL");
    // notifyListeners();
  }
}
