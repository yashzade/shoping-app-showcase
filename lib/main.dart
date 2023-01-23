import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/helpers/test_small_widget.dart';

import 'package:shop/providers/chips_tab_provider.dart';
import 'package:shop/providers/user_detail_provider.dart';
import 'package:shop/widgets/bottom_login_signup/authentication_provider.dart';
import 'package:shop/widgets/instant_items.dart/instant_provider.dart';

import 'package:shop/widgets/order/order_provider.dart';

import 'screens/botton_navi_bar.dart';

import 'providers/products_provider.dart';
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.light,
      // statusBarBrightness: Brightness.light,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final lightTheme = ThemeData(
    // brightness: Brightness.dark,
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black,
    accentColor: Colors.black,

    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.white,
        elevation: 5),

    textTheme: TextTheme(
        headline6: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
    chipTheme: ChipThemeData(
      shape: StadiumBorder(side: BorderSide(color: Colors.grey)),
      selectedColor: Colors.black, //
      disabledColor: Colors.grey[900],
      labelStyle: TextStyle(color: Colors.white), //
      brightness: Brightness.light, //
      secondaryLabelStyle: TextStyle(color: Colors.black), //
      padding: EdgeInsets.all(7),

      backgroundColor: Colors.transparent, //
      secondarySelectedColor: Colors.green,
      checkmarkColor: Colors.white, //
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontWeight: FontWeight.bold)))),
    fontFamily: 'Lato',
  );
  final darkTheme = ThemeData(
    // brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      brightness: Brightness.dark,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[900],
      modalBackgroundColor: Colors.grey[900],
    ),
    primaryColor: Colors.black,
    dividerColor: Colors.white,
    accentColor: Colors.white,

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      // shadowColor: Colors.white,
    ),
    chipTheme: ChipThemeData(
      // shape: StadiumBorder(side: BorderSide()),
      selectedColor: Colors.white, //
      disabledColor: Colors.blue,
      labelStyle: TextStyle(color: Colors.black), //
      brightness: Brightness.dark, //
      secondaryLabelStyle: TextStyle(color: Colors.white), //
      padding: EdgeInsets.all(7),

      backgroundColor: Colors.grey[900], //
      secondarySelectedColor: Colors.green,
      checkmarkColor: Colors.black, //
    ),

    textTheme: TextTheme(
        headline6: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontWeight: FontWeight.bold)))),
    fontFamily: 'Lato',
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(
            create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider<ChipsTabProvider>(
            create: (ctx) => ChipsTabProvider()),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(create: (ctx) => OrderProvider()),
        ChangeNotifierProvider<InstantItemProvider>(
            create: (ctx) => InstantItemProvider()),
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (ctx) => AuthenticationProvider()),
        ChangeNotifierProvider<UserDetailProvider>(
            create: (ctx) => UserDetailProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        darkTheme: darkTheme,
        theme: lightTheme,
        // themeMode: ThemeMode.light,
        home: BottomNavBar(),
        // home: SmallTestWidget(),
        routes: {ChildWidget.route: (ctx) => ChildWidget()},
      ),
    );
  }
}
