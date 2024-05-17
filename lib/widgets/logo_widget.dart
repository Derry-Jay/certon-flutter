import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? heightFactor, widthFactor;
  const LogoWidget({Key? key, this.heightFactor, this.widthFactor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    log(assetImagePath);
    return Image.asset('${assetImagePath}logo.png',
        fit: hp.isTablet ? BoxFit.contain : BoxFit.fitWidth,
        // color: Colors.amber,
        width: hp.dimensions.orientation == Orientation.landscape
            ? hp.isTablet
                ? 250
                : 250
            : hp.isTablet
                ? 250
                : hp.width /
                    (widthFactor ??
                        (hp.factor *
                            (hp.isMobile
                                ? (hp.width > 375 ? 0.8 : 0.8)
                                : 0.64))),
        errorBuilder: errorBuilder,
        // frameBuilder: getFrameBuilder,
        height: hp.dimensions.orientation == Orientation.landscape
            ? hp.isTablet
                ? 250
                : 170
            : hp.isMobile
                ? hp.height /
                    (heightFactor ?? (hp.factor * (hp.height > 850 ? 2 : 1.8)))
                : 250);
  }
}
