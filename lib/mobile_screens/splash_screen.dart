import '../helpers/helper.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import '../controllers/misc_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  final ConnectivityResult result;
  const SplashScreen({Key? key, required this.result}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends StateMVC<SplashScreen> {
  late OtherController con;
  Helper get hp => Helper.of(context);
  SplashScreenState() : super(OtherController()) {
    con = controller as OtherController;
  }

  void packageno() async {
    try {
      
    } catch (e) {
      sendAppLog(e);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.result == ConnectivityResult.none
        ? hp.getConnectStatus(vcb: didChangeDependencies)
        : con.proceed();
  }

  @override
  void didUpdateWidget(SplashScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    widget.result == ConnectivityResult.none
        ? hp.getConnectStatus(vcb: didChangeDependencies)
        : con.proceed();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('${assetImagePath}logo.png',
            fit: hp.isTablet ? BoxFit.contain : BoxFit.fitWidth,
            // color: Colors.amber,
            width: hp.isTablet
                ? 300
                : hp.isMobile
                    ? (hp.width > 375 ? 250 : 200)
                    : 0,
            errorBuilder: errorBuilder,
            // frameBuilder: getFrameBuilder,
            height: hp.isMobile
                ? hp.height > 850
                    ? 165
                    : 125
                : 250),
        const SizedBox(
          height: 50,
        ),
        CustomLoader(
            sizeFactor: 10,
            duration: con.duration,
            color: hp.theme.primaryColor,
            loaderType: LoaderType.fadingCircle)
      ])),
    );
  }
}
