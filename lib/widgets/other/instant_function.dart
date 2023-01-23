import 'package:flutter/material.dart';

var containerBoxDecoration =
    BoxDecoration(border: Border.all(color: Colors.white));
var smallCircularIndicator = Container(
  height: 20,
  child: FittedBox(child: CircularProgressIndicator()),
);
