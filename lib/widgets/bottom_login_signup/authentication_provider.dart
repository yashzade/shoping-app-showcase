import 'package:flutter/cupertino.dart';

class AuthenticationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  get getSelectedIndex {
    return _selectedIndex;
  }

  void changeSelectedIndex(int index) {
    print('changeSelectedIndex() index: $index');
    _selectedIndex = index;
    notifyListeners();
  }
}
