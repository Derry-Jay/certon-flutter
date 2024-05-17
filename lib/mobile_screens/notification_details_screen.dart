import '../models/user_base.dart';
import '../widgets/loader.dart';
import '../helpers/helper.dart';
import '../models/read_request.dart';
import '../models/route_argument.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../mobile_screens/notifications_screen.dart';

class NotificationDetailsScreen extends StatefulWidget {
  final RouteArgument reqaccid;
  const NotificationDetailsScreen({Key? key, required this.reqaccid})
      : super(key: key);

  static NotificationsScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<NotificationsScreenState>();

  @override
  NotificationDetailsScreens createState() => NotificationDetailsScreens();
}

class NotificationDetailsScreens extends State<NotificationDetailsScreen> {
  bool first = false,
      second = false,
      third = false,
      forth = false,
      flag = false;
  ReadRequest readRequest = ReadRequest.emptyReply;
  UserBase users = UserBase.emptyValue;
  Helper get hp => Helper.of(context);
  NotificationsScreenState? get nps => NotificationDetailsScreen.of(context);

  @override
  void initState() {
    super.initState();
    apiCall();
    apiCross();
  }

  void apiCross() async {
    var val = await api.userDetails();
    users.user = val.user;
    users.user.onChange();
    log(val.user.role.roleID);
    log('val.user.role.roleID');
    setState(() {});
  }

  void apiCall() async {
    log(widget.reqaccid.params['req_access_id'].toString());
    var id = widget.reqaccid.params['req_access_id'];
    log(id);
    final val = await api.readRequestNotification(id);
    if (val.success && mounted) {
      setState(() {
        readRequest = val;
      });
    }
  }

  Widget pageBuilder(BuildContext context) {
    final hp = Helper.of(context);
    return SafeArea(
      top: isAndroid,
      bottom: isAndroid,
      child: MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(boldText: false, textScaleFactor: 1.0),
        child: Scaffold(
            bottomNavigationBar: const BottomWidget(),
            drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
            body: SingleChildScrollView(
                child: readRequest.success == false
                    ? CustomLoader(
                        duration: const Duration(seconds: 10),
                        color: hp.theme.primaryColor,
                        loaderType: LoaderType.fadingCircle)
                    : Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Access Request to a Property',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${'${readRequest.usersData.firstName} ${readRequest.usersData.lastName}'} from ${(readRequest.usersData.companyname.isNotEmpty) ? readRequest.usersData.companyname : readRequest.usersData.name} would like to access the documents for ${readRequest.propData.fullAddress}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Only Authorise requests from companies you know and are expecting.',
                              style: TextStyle(fontSize: 13),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Allow for:',
                              style: TextStyle(fontSize: 13),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0,
                                  right: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('1 Day (Selected)'),
                                  Checkbox(
                                      activeColor: hp.theme.primaryColor,
                                      value: first,
                                      onChanged: (value) {
                                        setState(() {
                                          first = value ?? false;
                                          second = false;
                                          third = false;
                                          forth = false;
                                        });
                                      })
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0,
                                  right: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('1 Week'),
                                  Checkbox(
                                      activeColor: hp.theme.primaryColor,
                                      value: second,
                                      onChanged: (value) {
                                        setState(() {
                                          second = value ?? false;
                                          first = false;
                                          third = false;
                                          forth = false;
                                        });
                                      })
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0,
                                  right: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('1 Month'),
                                  Checkbox(
                                      activeColor: hp.theme.primaryColor,
                                      value: third,
                                      onChanged: (value) {
                                        setState(() {
                                          third = value ?? false;
                                          first = false;
                                          second = false;
                                          forth = false;
                                        });
                                      })
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0,
                                  right: hp.dimensions.orientation ==
                                          Orientation.landscape
                                      ? 60
                                      : 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Forever'),
                                  Checkbox(
                                      activeColor: hp.theme.primaryColor,
                                      value: forth,
                                      onChanged: (value) {
                                        setState(() {
                                          forth = value ?? false;
                                          first = false;
                                          second = false;
                                          third = false;
                                        });
                                      })
                                ],
                              ),
                            ),
                            Visibility(
                              visible: flag,
                              child: const Text(
                                'Select Duration',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: hp.theme.primaryColor),
                                onPressed: () {
                                  var accNotId =
                                          readRequest.requestAccess.id ?? 0,
                                      allwedDuration = '',
                                      status = 1,
                                      notificationId = widget.reqaccid
                                              .params['notification_id'] ??
                                          0;
                                  if (first) {
                                    allwedDuration = '1';
                                  } else if (second) {
                                    allwedDuration = '7';
                                  } else if (third) {
                                    allwedDuration = '30';
                                  } else if (forth) {
                                    allwedDuration = 'forever';
                                  } else {}

                                  if (first == false &&
                                      second == false &&
                                      third == false &&
                                      forth == false) {
                                    flag = true;
                                    setState(() {});
                                  } else {
                                    flag = false;
                                    updateaccess(
                                        accNotId,
                                        allwedDuration,
                                        status,
                                        notificationId,
                                        readRequest.propData.fullAddress,
                                        allwedDuration,
                                        (readRequest.usersData.companyname !=
                                                '')
                                            ? readRequest.usersData.companyname
                                            : readRequest.usersData.name);
                                    setState(() {});
                                  }
                                },
                                child: const Text(
                                  'Authorise Access',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'I was not expecting this request',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: hp.theme.primaryColor),

                                // color: Colors.cyan,

                                // textColor: Colors.black,

                                onPressed: () {
                                  var accNotId =
                                      readRequest.requestAccess.id ?? 0;

                                  var allwedDuration = '';

                                  const status = 2;

                                  final notificationId = widget
                                          .reqaccid.params['notification_id'] ??
                                      0;

                                  updateaccess(
                                      accNotId,
                                      allwedDuration,
                                      status,
                                      notificationId,
                                      readRequest.propData.fullAddress,
                                      allwedDuration,
                                      (readRequest
                                              .usersData.companyname.isNotEmpty)
                                          ? readRequest.usersData.companyname
                                          : readRequest.usersData.name);
                                },

                                child: const Text(
                                  'Decline Access',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ))),
            appBar: AppBar(
                leadingWidth: hp.leadingWidth,
                leading: const LeadingWidget(visible: false),
                elevation: 0,
                centerTitle: true,
                backgroundColor: hp.theme.primaryColor,
                foregroundColor: hp.theme.scaffoldBackgroundColor,
                title: const Text('Notification Details',
                    style: TextStyle(fontWeight: FontWeight.w600)))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageBuilder(context);

    // ValueListenableBuilder<UserNotification>(

    //     valueListenable: notifier,

    //     builder: pageBuilder,

    //     child: const BottomWidget());
  }

  void updateaccess(
      int reqaccid,
      String allowedduration,
      int status,
      int notificationid,
      String address,
      String period,
      String companyname) async {
    try {
      Loader.show(context);

      var apiSuccess = await api.updateRequestAccess(
          reqaccid, allowedduration, status, notificationid);

      Loader.hide();

      log(apiSuccess.success);

      log(apiSuccess.message);

      showDialog1(apiSuccess.message, apiSuccess.success, notificationid,
          address, period, companyname, status);
    } catch (e) {
      Loader.hide();

      sendAppLog(e);
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void showDialog1(String message, bool success, int notificationid,
      String address, String period, String companyname, int status) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(
            capitalize('${success ? 'Success' : 'Failure'}!'),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xffe09c58), fontWeight: FontWeight.w500),
          ),
          content: Text(message),
          actions: [
            TextButton(
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();

                  if (success) {
                    if (status == 1) {
                      deleteNotifications(
                          notificationid, address, period, companyname, status);
                    } else {
                      hp.goTo('/notifications', args: RouteArgument(id: 1),
                          vcb: () {
                        nps?.didUpdateWidget(nps!.widget);
                      });
                    }
                  }
                }),
          ],
        );
      }),
    );

/*    showCupertinoDialog(

      context: context,

      builder: (context) {

        return CupertinoAlertDialog(

          title: Text(capitalize('${success ? 'Success' : 'Failure'}!')),

          content: Text(message),

          actions: [

            CupertinoDialogAction(

                child: const Text('OK'),

                onPressed: () {

                  Navigator.of(context).pop();

                  if (success) {

                    deleteNotifications(

                        notificationid, address, period, companyname, status);

                  }

                }),

          ],

        );

      },

    );*/
  }

  void deleteNotifications(int notificationid, String address, String period,
      String companyname, int status) async {
    final hp = Helper.of(context);

    var value = await api.deleteNotificationUpdateAccess(notificationid);

    log(value.success);

    log(value.message);

    Map<String, String> paramsPass = {
      'company_name': companyname,
      'period': period,
      'address': address
    };

    log(status);

    if (status == 1) {
      hp.goTo('/access_request_success',
          args: RouteArgument(params: paramsPass));
    } else {
      hp.goTo('/notifications', args: RouteArgument(id: 1), vcb: () {
        nps?.didUpdateWidget(nps!.widget);
      });
    }
  }
}
