import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:shop/providers/item_sizes.dart';

class CartItem {
  final String title;
  int quantity;
  final int price;
  final String imageUrl;
  final String weight;
  final String category;
  final String itemId;
  final DocumentReference ref;

  CartItem(
      {@required this.title,
      @required this.quantity,
      @required this.price,
      @required this.imageUrl,
      @required this.weight,
      @required this.category,
      @required this.itemId,
      this.ref});
}

class CartProvider with ChangeNotifier {
  var collectionPath = '/user cart';

  Map<String, CartItem> _items = {};
  bool _isCartItemsFetched = false;
  double totalAmount = 0;

  Future<void> deleteCart() async {
    await FirebaseFirestore.instance
        .collection('/user cart')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .delete();
    _items = {};
  }

  bool isInCart(String itemId) {
    if (_items.containsKey(itemId))
      return true;
    else
      return false;
  }

  Map<String, CartItem> get getCartItems {
    return {..._items};
  }

  int itemQuantity(String typeId) {
    if (_items.containsKey(typeId))
      return _items[typeId].quantity;
    else
      return 0;
  }

  Map makeItemsJson() {
    Map<String, dynamic> itemJson = {};
    _items.forEach((key, value) {
      itemJson[key] = {
        'title': value.title,
        'price': value.price,
        'quantity': value.quantity,
        'imageUrl': value.imageUrl,
        'weight': value.weight,
      };
    });
    return itemJson;
  }

  Map getDetailsForOrder() {
    print(_items);
    return {
      'order amount': totalAmount,
      'order items': makeItemsJson(),
      'items count': _items.length,
    };
  }

  void getTotalAmount() {
    print('totalAmount()');
    totalAmount = 0;
    _items.forEach((key, cartItem) {
      totalAmount += cartItem.price * cartItem.quantity;
    });
  }

  void updateTotalAmount(String id, {bool isAddition}) {
    if (isAddition) {
      totalAmount += _items[id].price;
    } else {
      //substraction
      totalAmount -= _items[id].price;
    }
    notifyListeners();
  }

  Future<void> addItem(Item item) async {
    // var uid = FirebaseAuth.instance.currentUser.uid;
    String uid = FirebaseAuth.instance.currentUser.uid;
    if (!_items.containsKey(item.itemId)) {
      var data = CartItem(
          title: item.title,
          price: item.price,
          quantity: 1,
          imageUrl: item.url,
          weight: item.weight,
          category: item.category,
          itemId: item.itemId);

      await FirebaseFirestore.instance.collection(collectionPath).doc(uid).set({
        'cart items': {
          '${item.itemId}': {
            'title': item.title,
            'price': item.price,
            'quantity': 1,
            'imageUrl': item.url,
            'weight': item.weight,
          }
        }
      }, SetOptions(merge: true)).then((value) {
        _items['${item.itemId}'] = data;
        // notifyListeners();
      });
    }
  }

  Future<void> fetchCartItems() async {
    print('fetchCartItems().......................');
    String uid = FirebaseAuth.instance.currentUser.uid;
    if (_isCartItemsFetched)
      return;
    else {
      // var uid = FirebaseAuth.instance.currentUser.uid;

      var cartResponse = await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc('$uid')
          .get();

      var cartDocument = cartResponse.data();
      print('--->');
      print(cartDocument['cart items']);
      if (cartDocument['cart items'] != null)
        cartDocument['cart items'].forEach((key, value) {
          _items[key] = CartItem(
            title: value['title'],
            quantity: value['quantity'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            weight: value['weight'],
            category: 'vegetables',
            itemId: key,
          );
        });

      notifyListeners();

      _isCartItemsFetched = true;
    }
  }

  Future<void> decrementItem(String itemId) async {
    print("decrementItem()");
    String uid = FirebaseAuth.instance.currentUser.uid;
    // var uid = FirebaseAuth.instance.currentUser.uid;

    var itemQuantity = _items[itemId].quantity;

    var docPath =
        FirebaseFirestore.instance.collection('$collectionPath').doc('$uid');

    if (itemQuantity > 1) {
      await docPath
          .update({'cart items.$itemId.quantity': FieldValue.increment(-1)});
      updateTotalAmount(itemId, isAddition: false);
      --_items[itemId].quantity;
    } else {
      await docPath.update({'cart items.$itemId': FieldValue.delete()});
      updateTotalAmount(itemId, isAddition: false);
      _items.remove(itemId);
    }
  }

  Future<void> incrementItem(String itemId) async {
    print('incremnting()');
    String uid = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance
        .collection('$collectionPath')
        .doc('$uid')
        .update({'cart items.$itemId.quantity': FieldValue.increment(1)});
    _items[itemId].quantity++;
    updateTotalAmount(itemId, isAddition: true);
  }

  Future<void> removeItem(String itemId) async {
    print('removeItem()');
    String uid = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('$collectionPath')
        .doc('$uid')
        .update({'cart items.$itemId': FieldValue.delete()}).then((value) {
      _items.remove(itemId);
    });
    notifyListeners(); //for CartItemsList
  }
}
