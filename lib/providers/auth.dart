// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/http_exception.dart';

// class Auth with ChangeNotifier {
//   String _token;
//   DateTime _expiryDate;
//   String _userId;
//   Timer logoutExpiry;
//   bool get isAuth {
//     return token != null;
//   }

//   String get token {
//     if (_expiryDate != null &&
//         _expiryDate.isAfter(DateTime.now()) &&
//         _token != null) {
//       return _token;
//     }
//     return null;
//   }

//   String get userId {
//     return _userId;
//   }

//   Future<void> _authenticate(
//       String email, String password, String urlSegment) async {
//     final url =
//         'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCScxIBhzQTTf1q9TJy3JFG_FsTmF_WGgc';
//     var u = Uri();
//     print('inside _authenticate');
//     try {
//       final response = await http.post(
//         url,
//         body: json.encode(
//           {
//             'email': email,
//             'password': password,
//             'returnSecureToken': true,
//           },
//         ),
//       );
//       final responseData = json.decode(response.body);
//       // print(responseData);

//       if (responseData['error'] != null) {
//         throw HttpException(responseData['error']['message']);
//       }

//       _token = responseData['idToken'];
//       _userId = responseData['localId'];
//       _expiryDate = DateTime.now().add(
//         Duration(
//           seconds: int.parse(
//             responseData['expiresIn'],
//           ),
//         ),
//       );
//       _autoLogoutTimer();
//       notifyListeners();
//       final prefs = await SharedPreferences.getInstance();
//       final userData = jsonEncode({
//         'token': _token,
//         'expiryDate': _expiryDate.toIso8601String(),
//         'userId': _userId
//       });
//       prefs.setString('userData', userData);

//       print(prefs.getString('userData'));
//       print('completed authentication function');
//     } catch (error) {
//       print(error);
//       throw error;
//     }
//   }

//   Future<void> signup(String email, String password) async {
//     return _authenticate(email, password, 'signUp');
//   }

//   Future<void> login(String email, String password) async {
//     return _authenticate(email, password, 'signInWithPassword');
//   }

//   Future<void> logout() async {
//     _token = null;
//     _userId = null;
//     _expiryDate = null;
//     if (logoutExpiry != null) {
//       logoutExpiry.cancel();
//       logoutExpiry = null;
//     }
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     // prefs.remove('userData');
//     prefs.clear();
//   }

//   void _autoLogoutTimer() {
//     if (logoutExpiry != null) {
//       logoutExpiry.cancel();
//     }
//     final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
//     print(timeToExpire);
//     logoutExpiry = Timer(Duration(seconds: timeToExpire), logout);
//   }

//   Future<bool> tryAutoLogin() async {
//     // await Future.delayed(Duration(seconds: 3));
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }
//     final extractedUserData =
//         json.decode(prefs.getString('userData')) as Map<String, Object>;
//     final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

//     if (expiryDate.isBefore(DateTime.now())) {
//       return false;
//     }
//     _token = extractedUserData['token'];
//     _userId = extractedUserData['userId'];
//     _expiryDate = expiryDate;
//     notifyListeners();
//     _autoLogoutTimer();
//     return true;
//   }
// }
