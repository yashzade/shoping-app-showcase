import 'package:flutter/material.dart';
import 'package:shop/data%20json/main_page_data.dart';
import 'package:shop/widgets/homePage/stack_1_item.dart';
import 'package:shop/widgets/homePage/stack_2_item.dart';
import 'package:shop/widgets/homePage/stack_3_item.dart';

class CategorieCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...data1.keys.map((key) {
          return Stack1Item(
            title: key,
            url: data1[key]['url'],
            chipLabels: data1[key]['chips data'],
          );
        }),
        Container(
          // width: double.infinity,
          margin: EdgeInsets.only(bottom: 15, top: 15),
          child: FittedBox(
            child: Row(
              children: [
                ...data2.keys.map((key) {
                  return Stack2Item(
                    title: key,
                    url: data2[key],
                  );
                })
              ],
            ),
          ),
        ),
        FittedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...data3.keys.toList().getRange(0, 3).map((key) {
              return Stack3Item(
                title: key,
                url: data3[key],
              );
            }),
          ],
        )),
        FittedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...data3.keys.toList().getRange(3, 6).map((key) {
              return Stack3Item(
                title: key,
                url: data3[key],
              );
            }),
          ],
        )),
        Container(
          // decoration: BoxDecoration(
          //     border: Border.all(color: Colors.white)),
          child: FittedBox(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...data3.keys.toList().getRange(6, 9).map((key) {
                return Stack3Item(
                  title: key,
                  url: data3[key],
                );
              }),
            ],
          )),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
