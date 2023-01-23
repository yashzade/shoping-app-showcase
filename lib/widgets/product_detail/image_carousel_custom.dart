import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/data%20json/product_detail.dart';

class ImageCarouselCustom extends StatefulWidget {
  @override
  _ImageCarouselCustomState createState() => _ImageCarouselCustomState();
}

class _ImageCarouselCustomState extends State<ImageCarouselCustom> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.15,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            // enlargeCenterPage: true,
            // height: 400.0,
            enableInfiniteScroll: false,
          ),
          items: (productDetails['url'] as List<String>).map((i) {
            return InteractiveViewer(
              panEnabled: true,
              child: Card(
                elevation: 5,
                child: Container(
                  // margin: EdgeInsets.all(10),
                  child: Image.network(i),
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: (productDetails['url'] as List<String>).map((url) {
            int index = productDetails['url'].indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.white : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
