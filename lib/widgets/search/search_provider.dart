import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop/data%20json/dictionary.dart';
import 'package:shop/data%20json/suggestions_list_data.dart';

import 'package:string_similarity/string_similarity.dart';

import '../../providers/item_sizes.dart';

class SearchProvider with ChangeNotifier {
  bool _isTextFieldEmpty = true;
  bool _isSearchingPage = true;
  bool isDataFetched = false;
  List<Item> _items = [];
  List<String> autoCompleteResults = [];
  TextEditingController textEditingController = TextEditingController();

  bool get getIsSearchingPage {
    return _isSearchingPage;
  }

  get isFieldhasValue {
    return _isTextFieldEmpty;
  }

  get getItems {
    return [..._items];
  }

  void clearSuggestion() {
    autoCompleteResults = [];
    notifyListeners();
  }

  void clearTextfield() {
    textEditingController.clear();
    changeIsSearching(to: true);
    clearSuggestion();
  }

  void changeIsSearching({bool to}) {
    _isSearchingPage = to;
    notifyListeners();
  }

  void changeIsTextFieldEmpty(bool value) {
    _isTextFieldEmpty = value;
    notifyListeners();
  }

  // List trie(String target) {
  //   print('..............indeie trie');
  //   Trie trie = new Trie.list(trieData);
  //   return trie.getAllWordsWithPrefix(target);
  // }

  List<Item> makeItemObjects(List<DocumentSnapshot> fetchedData, String query) {
    List<Item> items = [];
    fetchedData.forEach((document) {
      var documentData = document.data();

      List<String> queryWords = query.split(' ');
      bool isPresent = queryWords
          .every((element) => (documentData['tags'] as List).contains(element));

      if (isPresent) {
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
      }
    });
    return items;
  }

  Future<void> searchQuery({@required String searchQuery}) async {
    isDataFetched = false;
    var query = searchQuery.split(' ');
    textEditingController.text = searchQuery;

    print('searchQuery() : $searchQuery');

    var querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('products')
        .where('tags', arrayContainsAny: query)
        .limit(8)
        .get();

    _items = makeItemObjects(querySnapshot.docs, searchQuery);

    await Future.delayed(Duration(milliseconds: 500));
    isDataFetched = true;
    notifyListeners();
  }

  String correctSpellingMistake(String spelling) {
    var target = spelling.bestMatch(totalDictionary).bestMatch.target;
    return target;
  }

  void getSuggestions(String query) {
    print('getSuggestions()');
    var correctSpelling = correctSpellingMistake(query);
    if (suggestionListData.keys.contains(correctSpelling)) {
      autoCompleteResults = suggestionListData[correctSpelling];
    } else
      autoCompleteResults = [correctSpelling];

    notifyListeners();
  }
}
