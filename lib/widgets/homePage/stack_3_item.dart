import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Stack3Item extends StatelessWidget {
  final String title, url;
  final bool isradial;
  Stack3Item({this.title, this.url, this.isradial = false});

  @override
  Widget build(BuildContext context) {
    // print('building Stack3Item');
    return InkWell(
      onTap: () {
        print('dialog....');
        showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/meme1.jpg')),
              );
            });
      },
      child: Stack(children: [
        Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: isradial
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              : null,
          child: CachedNetworkImage(
            height: 120,
            width: 120,
            fit: BoxFit.fill,
            imageUrl: url,
          ),
        ),
        Positioned(
          top: 3,
          left: 3,
          child: Container(
              // clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: isradial ? Radius.circular(10) : Radius.zero),
              ),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ),
      ]),
    );
  }
}
