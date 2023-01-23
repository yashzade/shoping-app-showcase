import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Stack2Item extends StatelessWidget {
  final String title, url;
  Stack2Item({this.title, this.url});

  @override
  Widget build(BuildContext context) {
    // print('building Stack2Item');
    return Stack(children: [
      Card(
        elevation: 15,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(
          height: 190,
          width: 187,
          fit: BoxFit.fill,
          imageUrl: url,
        ),
      ),
      Positioned(
        top: 3,
        left: 3,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10)),
            ),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    ]);
  }
}
