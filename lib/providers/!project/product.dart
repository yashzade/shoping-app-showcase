import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    var oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final uid = FirebaseAuth.instance.currentUser.uid;
    final favoriteData = {id: isFavorite};

    await FirebaseFirestore.instance
        .collection('userFavorites')
        .doc(uid)
        .update(favoriteData)
        .catchError((error) {
      _setFavValue(oldStatus);
    });

    // final url =
    //     'https://shop-5ffe4-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    // try {
    //   final response = await http.put(
    //     url,
    //     body: json.encode(
    //       isFavorite,
    //     ),
    //   );
    //   print(jsonDecode(response.body));
    //   if (response.statusCode >= 400) {
    //     _setFavValue(oldStatus);
    //   }
    // } catch (error) {
    //   _setFavValue(oldStatus);
    // }
  }
}
