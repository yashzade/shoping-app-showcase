import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/data%20json/instant_items.dart';

void makeProductAndUpload() {
  // var finalData = fruitsData.map((value) {
  //   Map<String, dynamic> finalData = {};

  //   Map<String, dynamic> differentSize = makeDifferntSize(value);
  //   List<String> tags = makeTags(value);
  //   finalData['title'] = value['title'];
  //   finalData['category'] = 'fruits';
  //   finalData['different sizes'] = differentSize;
  //   finalData['tags'] = tags;

  //   return finalData;
  // });

  // finalData.toList().forEach((element) {
  //   // print(element['title']);
  //   // print(element['tags']);
  //   // print(element['different sizes']);
  //   // print('_________');
  //   // print(element);
  // });
  // print(makeDictionary(finalData.toList()));

  // addToFirebase(finalData.toList());
  // var dictionaryData = makeDictionary(finalData.toList());
  // addDictionaryFirebase(dictionaryData, 'vegetables ');

  // FirebaseFirestore.instance
  //     .collection('dictionary')
  //     .doc('total dictionary')
  //     .set({'dictionary': totalDictionary}).then(
  //         (value) => print('uploaded }'));
  var finaldata = instanData;
  FirebaseFirestore.instance
      .collection('instant data')
      .doc('nagpur data')
      .set({'instant data': finaldata});
}

void getDataAndSet() async {
  var response =
      await FirebaseFirestore.instance.collection('dictionary ').get();
  response.docs.forEach((element) async {
    Map<String, dynamic> newData = {};
    element.data().keys.toList().forEach((key) {
      newData['dictionary'] = element[key];
    });
    print(newData);
    await FirebaseFirestore.instance
        .collection('dictionary/')
        .doc(element.id)
        .set(newData);
  });
}

String makeProductId1(var value) {
  var title = value['title'];
  var qty = value['qty1'];

  return title.split(RegExp(r' |/'))[0] + qty.split(RegExp(r' '))[0];
}

String makeProductId2(var value) {
  var title = value['title'];
  var qty = value['qty2'];

  return title.split(RegExp(r' |/'))[0] + qty.split(RegExp(r' '))[0];
}

Map makeDifferntSize(Map<String, dynamic> value) {
  Map<String, dynamic> differentSize = {};
  differentSize[makeProductId1(value)] = {
    "price": value['price1'],
    'url': value['url'],
    'quantity': 3,
    'weight': value['qty1']
  };

  if (value['price2'] != -1) {
    differentSize[makeProductId2(value)] = {
      'price': value['price2'],
      'url': value['url'],
      'quantity': 3,
      'weight': value['qty2']
    };
  }

  return differentSize;
}

List makeTags(Map value) {
  List<String> tags = [];

  var str = (value['title'] as String).replaceAll('/', ' ');

  str = str.replaceAll('(', '');
  str = str.replaceAll(')', '');
  str = str.replaceAll('-', '');
  str = str.replaceAll(' ', ' ');

  tags = str.split(' ');

  tags.add('fruit');
// tags.map((e) => e.replaceAll('', replace))
  tags = tags.map((e) => e.toLowerCase()).toList();

//  print(tags.toSet());
  return tags.toSet().toList();
}

Map makeDictionary(List<Map> finalData) {
  print('making dictionary');
  List tagdictionary = [];
  List titleDictionary = [];
  finalData.forEach((element) {
    tagdictionary.addAll(element['tags']);
    titleDictionary.add(element['title']);
  });
  // print(tagdictionary.toSet());
  // print(titleDictionary.toSet());
  var dictionary = {
    'one word dictionary': tagdictionary.toSet().toList(),
    'title dictionary': titleDictionary.toSet().toList()
  };
  return dictionary;
}

void addToFirebase(List finaldata) async {
  print('uploading');
  print('uploading.......');

  finaldata.forEach((element) async {
    print(element);

    await FirebaseFirestore.instance
        .collection('/pc2/fruits/products')
        .doc()
        .set(element);
  });
  print('uploaded');
}

void addDictionaryFirebase(Map dictionaryData, String name) async {
  print('uploading dictionary');
  dictionaryData.forEach((key, value) async {
    await FirebaseFirestore.instance
        .collection('dictionary/')
        .doc(name + key)
        .set({key: value});
    print('uploaded $key');
    // print('$value');
  });
  print('uploaded');
}
