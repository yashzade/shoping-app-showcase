import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shop/providers/user_detail_provider.dart';
import 'package:shop/widgets/drawer/edit_scree.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/order_history/order_history_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List data = [
    {
      'leading': Icons.history_sharp,
      'title': 'Orders',
      'function': () {},
    },
    {
      'leading': Icons.account_balance_wallet_outlined,
      'title': 'Wallet',
      'function': () => null
    },
    {
      'leading': Icons.help_outline_rounded,
      'title': 'Help and feedback',
      'function': () => null
    },
    {
      'leading': Icons.exit_to_app,
      'title': 'Sign out',
      'function': () {
        FirebaseAuth.instance.signOut();
      }
    },
  ];

  void initializeFunction(BuildContext context) {
    data[0]['function'] = () {
      pushNewScreen(context, screen: OrderHistory());
    };
  }

  @override
  Widget build(BuildContext context) {
    initializeFunction(context);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            UserDetailsArea(),
            Divider(
              color: Colors.white70,
            ),
            ...buttons()
          ],
        ),
      ),
    );
  }

  List<Widget> buttons() {
    return data
        .map((e) => ListTile(
              onTap: e['function'],
              leading: Icon(
                e['leading'],
                color: Colors.white54,
              ),
              title: Text(
                e['title'],
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ))
        .toList();
  }
}

class UserDetailsArea extends StatefulWidget {
  @override
  _UserDetailsAreaState createState() => _UserDetailsAreaState();
}

class _UserDetailsAreaState extends State<UserDetailsArea> {
  Map userData = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userData = context.read<UserDetailProvider>().userDetails;
    print(userData);
    return userDetailCard(context);
  }

  Container userDetailCard(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      child: Card(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              makeField('name'),
              makeField('phone number'),
              Text(
                FirebaseAuth.instance.currentUser.email,
                style: TextStyle(color: Colors.white70),
              ),
              makeField('address', color: Colors.blue[300]),
              Align(
                child: InkWell(
                    onTap: () {
                      pushNewScreenWithRouteSettings(context,
                          screen: EditScreen(),
                          settings: RouteSettings(
                              name: 'DrawerScreen', arguments: userData));
                    },
                    child: Icon(Icons.edit)),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeField(String name, {Color color = Colors.white70}) {
    if (userData[name] != null) {
      var str = userData[name];
      if (name == 'address' && userData['pincode'] != null)
        str = '${context.read<UserDetailProvider>().getAddress()}';

      return Text(
        str,
        style: TextStyle(color: color),
      );
    } else {
      return Row(
        children: [
          Text(
            '$name',
            style: TextStyle(color: Colors.red[400]),
          ),
          Spacer(),
          Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          Text(
            'not present',
            style: TextStyle(color: Colors.red[400]),
          ),
        ],
      );
    }
  }

  fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    await FirebaseFirestore.instance
        .collection('user detail')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      value.data().forEach((key, value) {
        userData[key] = value;
        print(value);
      });
    });
  }
}
