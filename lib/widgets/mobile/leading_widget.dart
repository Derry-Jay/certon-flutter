import '../../helpers/helper.dart';
import 'package:flutter/material.dart';

class LeadingWidget extends StatelessWidget {
  // VoidCallback onTap;
  final bool? visible;
  const LeadingWidget({Key? key, this.visible}) : super(key: key);

  Widget leadingBuilder(BuildContext context, BoxConstraints constraints) {
    final hp = Helper.of(context);
    log(hp.width);
    return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Row(
            mainAxisAlignment: (visible ?? true) || hp.isTablet
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              // const SizedBox(
              //   width: 5,
              // ),
              Visibility(
                  visible: !(visible ?? true),
                  child: Flexible(
                      child: IconButton(
                          onPressed: hp.goBack,
                          icon: const Icon(Icons.arrow_back_ios)))),
              Visibility(
                  visible: !(visible ?? true),
                  child: Flexible(
                      flex: (3 *
                          (hp.isTablet
                              ? 1
                              : (hp.isMobile
                                  ? (hp.height > 849
                                      ? (hp.dimensions.orientation ==
                                              Orientation.landscape
                                          ? 3
                                          : 2)
                                      : (hp.dimensions.orientation ==
                                              Orientation.landscape
                                          ? 3
                                          : 1))
                                  : 1))),
                      child: GestureDetector(
                          onTap: hp.goBack,
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: constraints.maxWidth / 25),
                              child: Text('Back',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize:
                                          hp.height > 599 ? 16 : 13.1072)))))),
              // const SizedBox(width: 15),
              // Visibility(child: Expanded(Text))
              Expanded(
                  child: IconButton(
                      constraints: constraints,
                      alignment: Alignment.centerLeft,
                      padding: visible == true
                          ? const EdgeInsets.only(left: 15)
                          : EdgeInsets.zero,
                      onPressed:
                          hp.sct.hasDrawer ? hp.sct.openDrawer : doNothing,
                      icon: const Icon(Icons.dehaze)))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: leadingBuilder);
  }
}
