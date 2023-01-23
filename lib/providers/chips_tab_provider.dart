import 'package:flutter/cupertino.dart';

class ChipsTabProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  String keye = 'vegetable';
  void changeKey(String name) {
    keye = name;
  }

  get getselectedIndex {
    return _selectedIndex;
  }

  void changeSelectedIndex(int index) {
    print('changeSelectedIndex() index: $index');
    _selectedIndex = index;
    notifyListeners();
  }

  void resetInitializedData() {
    _selectedIndex = 0;
    print('resetInitialized ChipsData');
  }
}
