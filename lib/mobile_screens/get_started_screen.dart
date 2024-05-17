import '../backend/api.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class GetStartedScreen extends StatefulWidget {
  final bool flag;
  const GetStartedScreen({Key? key, required this.flag}) : super(key: key);

  @override
  GetStartedScreenState createState() => GetStartedScreenState();
}

class GetStartedScreenState extends State<GetStartedScreen> {
  Helper get hp => Helper.of(context);

  PageViewModel slideMap(String e) {
    return PageViewModel(
        decoration: PageDecoration(pageColor: hp.theme.primaryColor),
        titleWidget: SizedBox(
          //  color: Colors.amber,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(''),
              IconButton(
                  iconSize: 40,
                  onPressed: proceed,
                  icon: const Icon(Icons.close))
            ],
          ),
        ),
        useScrollView: hp.dimensions.orientation == Orientation.landscape,
        bodyWidget: Center(
            heightFactor: hp.isTablet
                ? 1.37438953472
                : (hp.isMobile
                    ? (hp.size.longestSide < 600 &&
                            hp.dimensions.orientation == Orientation.landscape
                        ? 1
                        : 1.152921504606846976)
                    : 1.25),
            child: Image.asset(assetImagePath + e,
                errorBuilder: errorBuilder,
                // width: hp.dimensions.orientation == Orientation.landscape ? 500 : null,
                height: hp.height /
                    (hp.isTablet
                        ? 1.7179869184
                        : (hp.isMobile
                            ? (hp.dimensions.orientation ==
                                    Orientation.landscape
                                ? 1
                                : 1.8)
                            : 1.28)),
                fit: BoxFit.contain)));
  }

  void proceed() async {
    try {
      if (widget.flag) {
        hp.goBack();
      } else {
        final prefs = await sharedPrefs;
        final p = await prefs.setBool('gsf', true);
        p ? hp.gotoForever('/mobile_login') : doNothing();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: hp.theme.primaryColor,
      child: SafeArea(
        child: IntroductionScreen(
            isProgress: true,
            dotsDecorator: DotsDecorator(
                activeColor: hp.theme.primaryColor,
                color: hp.theme.primaryColor.withOpacity(0.5)),
            onDone: proceed,
            onSkip: proceed,
            next: const Icon(Icons.arrow_forward),
            pages: items.map<PageViewModel>(slideMap).toList(),
            skip: const Text('Skip',
                style: TextStyle(fontWeight: FontWeight.w600)),
            done: const Text('Done',
                style: TextStyle(fontWeight: FontWeight.w600))),
      ),
    );
  }
}
