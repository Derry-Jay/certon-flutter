import '../../helpers/helper.dart';
import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key, required num heightFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: hp.height / 32, horizontal: hp.width / 13.1072),
        color: hp.theme.primaryColor,
        child: SelectableText(
            '© CertOn 2021. All Rights Reserved | Terms and Conditions | Privacy Policy | Acceptable Use Policy |',
            style: TextStyle(
                color: hp.theme.scaffoldBackgroundColor, fontSize: 20)));
  }
}
