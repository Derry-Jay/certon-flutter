import '../helpers/helper.dart';
import '../web_pages/web_home_page.dart';
import '../widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  HomePageWidgetState createState() => HomePageWidgetState();

  static WebHomePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<WebHomePageState>();
}

class HomePageWidgetState extends State<HomePageWidget> {
  Helper get hp => Helper.of(context);
  WebHomePageState? get hps => HomePageWidget.of(context);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(bottom: hp.height / 64),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LogoWidget(heightFactor: 4, widthFactor: 10),
                SelectableText('Welcome Diya')
              ])),
      Padding(
          padding: EdgeInsets.only(right: hp.width / 131.072),
          child: Stack(
            children: [
              SizedBox(
                  height: hp.height / 4,
                  width: hp.width / 8,
                  child: CircularProgressIndicator(
                      strokeWidth: hp.width / 160,
                      value: hps!.counter / 100,
                      color: hp.theme.splashColor,
                      backgroundColor: Colors.black12)),
              Positioned(
                  left: hp.width / 20,
                  top: hp.height / 10,
                  child: SelectableText(hps!.counter.toString()))
            ],
          ))
    ]);
  }
}
