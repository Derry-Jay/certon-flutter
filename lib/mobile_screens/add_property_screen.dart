import '../backend/api.dart';
import '../models/reply.dart';
import '../helpers/helper.dart';
import '../models/misc_data.dart';
import '../models/user_base.dart';
import '../models/route_argument.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/pin_code_result.dart';
import '../models/status_property_base.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/mobile/own_property_widget.dart';
import '../widgets/mobile/add_property_form_widget.dart';

class AddPropertyScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddPropertyScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddPropertyScreenState createState() => AddPropertyScreenState();
}

class AddPropertyScreenState extends State<AddPropertyScreen> {
  Helper get hp => Helper.of(context);
  int? fl;
  int status = 0;
  String? tag;
  bool flag = false;

  UserBase users = UserBase.emptyValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCross();
    hp.getConnectStatus();
    funcOfConvert();
  }

  void funcOfConvert() async {
    status = await waitForPropertyScanResult(widget.rar.params);
    location = ValueNotifier(PinCodeResult.emptyResult);
    if (mounted) {
      setState(() {});
      location.value.onChange();
    }
  }

  Future<int> waitForPropertyScanResult(Map<String, dynamic> body) async {
    try {
      // final p =
      //     await revealToast('Please Wait.....', length: Toast.LENGTH_LONG);

      final value = await api.getPropertyStatus(body);
      final rp = Reply.fromMap(value);
      // final q = await revealToast(rp.message);
      if (mounted) {
        if (rp.success) {
          log('came here');
          final val = StatusPropertyBase.fromMap(value);
          final prop = val.property;
          final isOwner = parseBool(val.owned.toString());
          final haveAccess = parseBool(val.access.toString());
          log(prop);
          remainingSpace.value = val.docCount;
          totalDocsCount.value = val.count;
          props.value = prop;
          setState(() {
            flag = true;
            tag = haveAccess.toString();
          });
          prop.onChange();
          val.onChange();
          if (isOwner) {
            // final fl2 = await revealToast(
            //     'This is your property. You can witness the same at the "Owned" Section under Properties');
            setState(() {
              fl = 0;
            });
            return 1;
          } else {
            setState(() {
              fl = 1;
            });
            if (haveAccess) {
              final map = body;
              log(map);
              return 3;
            } else {
              return 1;
            }
          }
        } else {
          final f2 = await showCupertinoDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return MediaQuery(
                        data: MediaQueryData.fromWindow(
                                wb?.window ?? WidgetsBinding.instance.window)
                            .copyWith(boldText: false, textScaleFactor: 1.0),
                        child: CupertinoAlertDialog(
                            title: const Text(
                              'Confirm',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                                '${rp.message} ${rp.message.contains('This Property is not in CertOn!') ? 'Do you want to add a new property?' : ''}'),
                            actions: rp.message
                                    .contains('This Property is not in CertOn!')
                                ? <Widget>[
                                    CupertinoDialogAction(
                                      child: const Text(
                                        'CANCEL',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        hp.goBack(result: false);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        hp.goBack(result: true);
                                        // hp.goTo('/add_property',
                                        //     args: RouteArgument(
                                        //         content: val.reply.message,
                                        //         tag: body['scancode']), vcb: () {
                                        //   location.value = PinCodeResult.emptyResult;
                                        //   location.value.onChange();
                                        // });
                                      },
                                    ),
                                  ]
                                : [
                                    CupertinoDialogAction(
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        hp.goBack(result: false);
                                      },
                                    )
                                  ]));
                  }) /*hp.showDialogBox(
                  title: const Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                      '${rp.message} ${rp.message.contains('This Property is not in CertOn!') ? 'Do you want to add a new property?' : 'You cannot access it as you are a user!!!'}'),
                  actions:
                      rp.message.contains('This Property is not in CertOn!')
                          ? <Widget>[
                              CupertinoDialogAction(
                                child: const Text(
                                  'CANCEL',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  hp.goBack(result: false);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  hp.goBack(result: true);
                                  // hp.goTo('/add_property',
                                  //     args: RouteArgument(
                                  //         content: val.reply.message,
                                  //         tag: body['scancode']), vcb: () {
                                  //   location.value = PinCodeResult.emptyResult;
                                  //   location.value.onChange();
                                  // });
                                },
                              ),
                            ]
                          : [
                              CupertinoDialogAction(
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  hp.goBack(result: false);
                                },
                              )
                            ],
                  type: AlertType.cupertino)*/
              ??
              false;
          if (f2) {
            final v =
                int.tryParse(OtherData.fromMap(value).data.toString()) ?? 0;
            setState(() {
              flag = true;
            });
            return v;
          } else {
            hp.goBack();
            return 0;
          }
        }
      } else {
        return 0;
      }
    } catch (e) {
      sendAppLog(e);
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    log(status);
    log(widget.rar);
    log(fl);
    log(tag);
    makeStatusBarVisibleInAndroid();
    final sf = Scaffold(
        bottomNavigationBar: const BottomWidget(),
        drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
        appBar: AppBar(
            leading: const LeadingWidget(visible: false),
            leadingWidth: hp.leadingWidth,
            elevation: 0,
            centerTitle: true,
            backgroundColor: hp.theme.primaryColor,
            foregroundColor: hp.theme.scaffoldBackgroundColor,
            title: const Text('Scan Code',
                style: TextStyle(fontWeight: FontWeight.w600))),
        body: users.user.isEmpty
            ? Center(
                child: CustomLoader(
                    sizeFactor: 10,
                    duration: const Duration(seconds: 10),
                    color: hp.theme.primaryColor,
                    loaderType: LoaderType.fadingCircle))
            : parseBool(status.toString())
                ? OwnPropertyWidget(
                    rar: RouteArgument(
                        id: fl,
                        tag: tag,
                        content: widget.rar.params['scancode'],
                        params: widget.rar.params))
                : (flag
                    ? AddPropertyFormWidget(rar: widget.rar)
                    : loaderScreen()));
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
            top: isAndroid,
            bottom: isAndroid,
            right: hp.pageOrientation == Orientation.landscape,
            left: hp.pageOrientation == Orientation.landscape,
            child: isAndroid
                ? sf
                : MediaQuery(
                    data: MediaQueryData.fromWindow(
                            WidgetsBinding.instance.window)
                        .copyWith(boldText: false, textScaleFactor: 1.0),
                    child: sf)));
  }

  Widget loaderScreen() {
    return Column(
      children: [
        Container(
            height: hp.height /
                (hp.pageOrientation == Orientation.landscape
                    ? 6.5536
                    : 13.1072),
            width: hp.width,
            decoration: BoxDecoration(
                color: hp.theme.hintColor,
                borderRadius: const BorderRadius.all(Radius.zero)),
            child: Row(
              children: [
                Flexible(
                  child: Icon(Icons.qr_code_scanner_outlined,
                      color: hp.theme.scaffoldBackgroundColor,
                      size: hp.radius / 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('CODE SCANNED',
                          style: TextStyle(color: Colors.lightGreenAccent)),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Text('Property ID:  ${widget.rar.params['scancode']}',
                          softWrap: false,
                          // maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                )
              ],
            )),
        Center(
          child: CustomLoader(
              color: hp.theme.primaryColor,
              duration: const Duration(seconds: 10),
              loaderType: LoaderType.fadingCircle),
        )
      ],
    );
  }

  void apiCross() async {
    final hp = Helper.of(context);
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
}
