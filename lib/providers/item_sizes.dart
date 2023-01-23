import 'package:flutter/foundation.dart';

class Item {
  final String title, url, weight, itemId, category;
  String itemDetaileReference;
  int price, quantity;

  Item(
      {@required this.title,
      @required this.url,
      @required this.weight,
      @required this.price,
      @required this.itemId,
      @required this.quantity,
      @required this.category});
}

// class ItemSizes with ChangeNotifier {
//   List<Item> differentSizeItems = [];
//   int selectedIndex = 0;

//   void changeIndex(int index) {
//     selectedIndex = index;
//     notifyListeners();
//   }
// }
