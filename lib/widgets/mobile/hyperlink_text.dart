import '../../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HyperLinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? heightFactor, widthFactor;
  const HyperLinkText(
      {Key? key,
      required this.text,
      required this.onTap,
      this.heightFactor,
      this.widthFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: //EdgeInsets.only(left: 20, top: 20, bottom: 20),
                EdgeInsets.symmetric(
                vertical: hp.height / (heightFactor ?? (hp.factor * 25.6)),
                horizontal: hp.width / (widthFactor ?? (hp.factor * 10))),
            child: Text(text,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: hp.theme.focusColor))));
  }
}
