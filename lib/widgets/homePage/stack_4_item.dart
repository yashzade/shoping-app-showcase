import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Stack4Item extends StatelessWidget {
  final String title, url;
  Stack4Item({this.title, this.url});

  @override
  Widget build(BuildContext context) {
    // print('building Stack4Item');
    return Stack(children: [
      Card(
        elevation: 5,
        // clipBehavior: Clip.hardEdge,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: CachedNetworkImage(
          height: 150,
          width: double.infinity,
          fit: BoxFit.fitWidth,
          imageUrl: url,
        ),
      ),
      Positioned(
        top: 4,
        child: Container(
            // clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
            ),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        left: 4,
      ),
    ]);
  }
}
