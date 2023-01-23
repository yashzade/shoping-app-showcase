import 'package:flutter/material.dart';
import 'package:shop/data%20json/product_detail.dart';
import 'package:shop/widgets/product_detail/image_carousel_custom.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      // margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      // decoration:
      //     BoxDecoration(border: Border.all(width: 5, color: Colors.green)),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCarouselCustom(),
              Container(
                padding: EdgeInsets.all(7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(productDetails['title'],
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 20)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      ' ₹${productDetails['price']} . ${productDetails['weight']}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 15),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        productDetails['discription'],
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontSize: 15, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
