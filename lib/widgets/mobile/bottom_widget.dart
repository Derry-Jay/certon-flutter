import '../../helpers/helper.dart';
import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  final double? heightFactor, widthFactor;
  const BottomWidget({Key? key, this.heightFactor, this.widthFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return Container(
      color: hp.theme.primaryColor,
      child: SafeArea(
          child: Container(
              padding: hp.screenPadding.bottom > 0
                  ? EdgeInsets.only(top: hp.height / 75)
                  : null,
              alignment: Alignment.topCenter,
              color: hp.theme.primaryColor,
              height: hp.dimensions.orientation == Orientation.landscape
                  ? hp.isMobile
                      ? 30
                      : 50
                  : (hp.height /
                      (heightFactor ??
                          (hp.factor *
                              (hp.isTablet
                                  ? 12
                                  : (hp.height > 650 ? 10 : 8))))),
              child: Center(
                  /*heightFactor: 10,*/
                  child: Text(title,
                      style: TextStyle(
                          color: hp.theme.scaffoldBackgroundColor,
                          fontSize: hp.isMobile
                              ? (hp.height > 850 ? 16 : 13)
                              : 20))))),
    );
  }
}
