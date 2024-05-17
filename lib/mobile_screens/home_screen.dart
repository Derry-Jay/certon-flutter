import 'package:audioplayers/audioplayers.dart';
import '../models/user_base.dart';
import '../widgets/custom_loader.dart';
import '../backend/api.dart';
import '../models/user.dart';
import '../helpers/helper.dart';
import 'package:badges/badges.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../models/pin_code_result.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/property_and_document_controller.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends StateMVC<HomeScreen> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  HomeScreenState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  UserBase users = UserBase.emptyValue;
  int roleID = 0;

  void waitForPropertyScanResult(Map<String, dynamic> body) async {
    hp.goTo('/add_property', args: RouteArgument(params: body), vcb: () {
      didUpdateWidget(widget);
    });
  }

  Widget badgeBuilder(BuildContext context, int i, Widget? child) {
    try {
      return Badge(
          showBadge: i > -1,
          badgeColor: Colors.redAccent,
          badgeContent:
              Text(i.toString(), style: const TextStyle(color: Colors.white)));
    } catch (e) {
      sendAppLog(e);
      return child ?? const EmptyWidget();
    }
  }

  Widget pageBuilder(BuildContext context, User user, Widget? child) {
    try {
      final hpp = Helper.of(context);
      hpp.getConnectStatus();
      log(user.userID);
      makeStatusBarVisibleInAndroid();
      final sf = Scaffold(
          body: user.isEmpty
              ? Center(
                  child: CustomLoader(
                      sizeFactor: 10,
                      duration: const Duration(seconds: 10),
                      color: hp.theme.primaryColor,
                      loaderType: LoaderType.fadingCircle))
              : SingleChildScrollView(
                  physics: hp.dimensions.orientation == Orientation.portrait
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
                  // physics: ((hpp.size.longestSide > 899 &&
                  //             hpp.dimensions.orientation == Orientation.portrait) ||
                  //         (hpp.size.longestSide > 999 &&
                  //             hpp.dimensions.orientation == Orientation.landscape))
                  //     ? const NeverScrollableScrollPhysics()
                  //     : hp.isMobile
                  //         ? hp.height < 737
                  //             ? const AlwaysScrollableScrollPhysics()
                  //             : const NeverScrollableScrollPhysics()
                  //         : const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      left: hp.isMobile ? 40 : 80,
                      right: hp.isMobile ? 40 : 80,
                      top:
                          0), //EdgeInsets.symmetric(horizontal: hpp.width / 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: hp.isMobile
                              ? hp.height > 700
                                  ? hp.height > 895
                                      ? 40
                                      : 35
                                  : 25
                              : 35,
                        ),
                        Image.asset('${assetImagePath}logo.png',
                            fit: hp.isTablet ? BoxFit.contain : BoxFit.contain,
                            // color: Colors.amber,
                            width: hp.dimensions.orientation ==
                                    Orientation.landscape
                                ? hpp.isTablet
                                    ? 170
                                    : 100
                                : hpp.isTablet
                                    ? 170
                                    : hpp.isMobile
                                        ? (hpp.width > 375 ? 120 : 80)
                                        : 0.64,
                            errorBuilder: errorBuilder,
                            // frameBuilder: getFrameBuilder,
                            height: hp.dimensions.orientation ==
                                    Orientation.landscape
                                ? hpp.isMobile
                                    ? 80
                                    : 120
                                : hpp.isMobile
                                    ? hpp.height > 850
                                        ? 85
                                        : 60
                                    : 120),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text('Welcome ${user.userName}',
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: hp.dimensions.orientation ==
                                            Orientation.portrait
                                        ? hp.isMobile
                                            ? hp.height > 700
                                                ? hp.height > 895
                                                    ? 22
                                                    : 20
                                                : 17
                                            : 20
                                        : 20,
                                    fontWeight: FontWeight.w500))),
                        Visibility(
                            visible: user.role.roleID == 5,
                            child: Text('Company: ${user.companyName ?? ''}',
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: hp.dimensions.orientation ==
                                            Orientation.portrait
                                        ? hp.isMobile
                                            ? hp.height > 700
                                                ? hp.height > 895
                                                    ? 22
                                                    : 20
                                                : 17
                                            : 20
                                        : 20,
                                    fontWeight: FontWeight.w500))),
                        Padding(
                            padding: EdgeInsets.only(
                              top: hp.dimensions.orientation ==
                                      Orientation.portrait
                                  ? hp.isMobile
                                      ? hp.height > 700
                                          ? hp.height > 895
                                              ? 25
                                              : 20
                                          : 15
                                      : 20
                                  : 20,
                            ),
                            child: Text(
                                'CertOn brings all important property related documents into one easy-to-access portal',
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: hp.dimensions.orientation ==
                                            Orientation.portrait
                                        ? hp.isMobile
                                            ? hp.height > 700
                                                ? hp.height > 895
                                                    ? 22
                                                    : 20
                                                : 17
                                            : 20
                                        : 20,
                                    fontWeight: FontWeight.w500))),
                        SizedBox(
                          height:
                              hp.dimensions.orientation == Orientation.portrait
                                  ? hp.isMobile
                                      ? hp.height > 700
                                          ? hp.height > 895
                                              ? 30
                                              : 25
                                          : 20
                                      : 25
                                  : 25,
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: hpp.height / 80),
                            child: GestureDetector(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.account_box,
                                          color: hpp.theme.primaryColor,
                                          size: hp.isMobile
                                              ? hp.height > 700
                                                  ? hp.height > 895
                                                      ? 45
                                                      : 40
                                                  : 30
                                              : 40),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: hp.width / 50),
                                          child: Text('My Profile',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  color: hpp.theme.primaryColor,
                                                  fontSize: hp.isMobile
                                                      ? hp.height > 700
                                                          ? hp.height > 895
                                                              ? 21
                                                              : 19
                                                          : 19
                                                      : 19)))
                                    ]),
                                onTap: () async {
                                  hpp.goTo('/profile', vcb: () {
                                    didUpdateWidget(widget);
                                  });
                                })),
                        GestureDetector(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.qr_code_scanner_sharp,
                                      color: hpp.theme.primaryColor,
                                      size: hp.isMobile
                                          ? hp.height > 700
                                              ? hp.height > 895
                                                  ? 45
                                                  : 40
                                              : 30
                                          : 40),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: hpp.width / 50),
                                      child: Text('Scan a QR Code     ',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: hp.theme.primaryColor,
                                              fontSize: hp.isMobile
                                                  ? hp.height > 700
                                                      ? hp.height > 895
                                                          ? 21
                                                          : 19
                                                      : 19
                                                  : 19)))
                                ]),
                            onTap: () async {
                              try {
                                AudioPlayer player = AudioPlayer();
                                String audioasset = 'sounds/camerashutter.mp3';
                                final code = await isRealDevice()
                                    ? await FlutterBarcodeScanner.scanBarcode(
                                        '#ffbb33', 'Back', true, ScanMode.QR)
                                    : 'QRP123456';
                                if (code.isNotEmpty) {
                                  final body = {
                                    'scancode': code,
                                    'user_id': user.userID.toString()
                                  };
                                  log(body);
                                  if (int.tryParse(code) != null) {
                                    if ((int.tryParse(code) ?? -1) > 0) {
                                      await player
                                          .play(AssetSource(audioasset));
                                      waitForPropertyScanResult(body);
                                    }
                                  } else {
                                    await player.play(AssetSource(audioasset));
                                    waitForPropertyScanResult(body);
                                  }
                                }
                              } catch (e) {
                                sendAppLog(e);
                              }
                            }),
                        Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: hpp.height / 80),
                            child: GestureDetector(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.home,
                                          color: hpp.theme.primaryColor,
                                          size: hp.isMobile
                                              ? hp.height > 700
                                                  ? hp.height > 895
                                                      ? 45
                                                      : 40
                                                  : 30
                                              : 40),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: hpp.width / 50),
                                          child: Text('My Properties         ',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  color: hpp.theme.primaryColor,
                                                  fontSize: hp.isMobile
                                                      ? hp.height > 700
                                                          ? hp.height > 895
                                                              ? 21
                                                              : 19
                                                          : 19
                                                      : 19)))
                                    ]),
                                onTap: () {
                                  hp.goTo('/contractor_properties', vcb: () {
                                    didUpdateWidget(widget);
                                  });
                                })),
                        GestureDetector(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.assignment,
                                      color: hpp.theme.primaryColor,
                                      size: hp.isMobile
                                          ? hp.height > 700
                                              ? hp.height > 895
                                                  ? 45
                                                  : 40
                                              : 30
                                          : 40),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: hpp.width / 50),
                                      child: Text('My Documents      ',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: hpp.theme.primaryColor,
                                              fontSize: hp.isMobile
                                                  ? hp.height > 700
                                                      ? hp.height > 895
                                                          ? 21
                                                          : 19
                                                      : 19
                                                  : 19)))
                                ]),
                            onTap: () async {
                              hpp.goTo('/all_documents', vcb: () {
                                didUpdateWidget(widget);
                              });
                            }),
                        Padding(
                            padding: EdgeInsets.only(top: hpp.height / 80),
                            child: GestureDetector(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.notifications,
                                          color: hpp.theme.primaryColor,
                                          size: hp.isMobile
                                              ? hp.height > 700
                                                  ? hp.height > 895
                                                      ? 45
                                                      : 40
                                                  : 30
                                              : 40),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: hpp.width / 50),
                                          child: Text('Notifications      ',
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  color: hpp.theme.primaryColor,
                                                  fontSize: hp.isMobile
                                                      ? hp.height > 700
                                                          ? hp.height > 895
                                                              ? 21
                                                              : 19
                                                          : 19
                                                      : 19))),
                                      ValueListenableBuilder<int>(
                                          builder: badgeBuilder,
                                          valueListenable: notificationCount)
                                    ]),
                                onTap: () {
                                  hpp.goTo('/notifications',
                                      args: RouteArgument(id: 0), vcb: () {
                                    didUpdateWidget(widget);
                                  });
                                }))
                      ])),
          bottomNavigationBar: const BottomWidget(),
          drawer: Drawer(width: hpp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: hpp.theme.primaryColor,
              foregroundColor: hpp.theme.scaffoldBackgroundColor,
              title: const Text('Welcome',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontWeight: FontWeight.w600))));
      return SafeArea(
          top: isAndroid,
          bottom: isAndroid,
          child: isAndroid
              ? sf
              : MediaQuery(
                  data:
                      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                          .copyWith(boldText: false, textScaleFactor: 1.0),
                  child: sf));
    } catch (e) {
      sendAppLog(e);
      return child ?? const EmptyWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return pageBuilder(context, users.user, const EmptyWidget());
    // return ValueListenableBuilder<User>(
    //     builder: pageBuilder,
    //     valueListenable: currentUser,
    //     child: const EmptyWidget());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCross();
    con.waitForNotificationCount();
  }

  void apiCross() async {
    final hp = Helper.of(context);
    final prefs = await sharedPrefs;
    roleID = prefs.getInt('RoleID') ?? 0;
    var val = await api.userDetails();

    users.user = val.user;
    users.user.onChange();
    log(val.user.role.roleID);
    log('val.user.role.roleID');
    // currentUser.value.onChange();
    log(val.user.firstName);
    log(currentUser.value.firstName);
    log('currentUser.value.role.roleID');
    hp.signOutIfAnyChanges(val.user.role.roleID);
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    log('kjadnfjsdnfjsanfa');
    location.value = PinCodeResult.emptyResult;
    location.value.onChange();
    con.waitForNotificationCount();
  }

  Future<Uri> playLocalAsset() {
    return AudioCache().load('sounds/myCustomSoundEffect.mp3');
  }
}
