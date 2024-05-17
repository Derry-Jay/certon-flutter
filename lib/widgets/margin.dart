import 'package:flutter/material.dart';

class Margin extends Container {
  final Widget? inner;
  final EdgeInsets? childMargin;
  final double? length;
  Margin({Key? key, this.inner, this.childMargin, this.length})
      : super(key: key, child: inner, margin: childMargin, height: length);
}
