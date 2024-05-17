import '../backend/api.dart';
import '../widgets/loader.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/route_argument.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_notification.dart';
import '../controllers/misc_controller.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationsScreen extends StatefulWidget {
  final RouteArgument rar;
  const NotificationsScreen({Key? key, required this.rar}) : super(key: key);

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends StateMVC<NotificationsScreen> {
  late OtherController con;
  List<bool> boolFlags = <bool>[];
  List<UserNotification> notifications = <UserNotification>[],
      unreadNotification = <UserNotification>[],
      readNotification = <UserNotification>[],
      finalizeNotification = <UserNotification>[];
  bool firstTimeClickFlag = false,
      selectionFlag = false,
      clicked = false,
      loaderFlag = false;
  List<int> selectedIndices = <int>[];
  List<String> selectedIDs = <String>[];
  Helper get hp => Helper.of(context);

  NotificationsScreenState() : super(OtherController()) {
    con = controller as OtherController;
  }

  int sorter(UserNotification a, UserNotification b) {
    log(a.content);
    DateTime aDate = DateTime.parse(a.createdAt);
    DateTime bDate = DateTime.parse(b.createdAt);
    return bDate.compareTo(aDate);
  }

  Widget leadingBuilder(BuildContext context, BoxConstraints constraints) {
    final hp = Helper.of(context);
    bool visible = false;
    log(hp.width);
    return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Row(
            mainAxisAlignment: (visible) || hp.isTablet
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              // const SizedBox(
              //   width: 5,
              // ),
              Visibility(
                  visible: !(visible),
                  child: Flexible(
                      child: IconButton(
                          onPressed: hp.goBack,
                          icon: const Icon(Icons.arrow_back_ios)))),
              Visibility(
                  visible: !(visible),
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
                          onTap: () {
                            if (!clicked) {
                              clicked = true;
                              // hp.gotoForever('/mobile_home');
                              if (widget.rar.id == 1) {
                                hp.goTo('/mobile_home');
                              } else {
                                hp.goBack();
                              }
                            } else {
                              clicked = false;
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: constraints.maxWidth / 25),
                              child: Text('Back',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize:
                                          hp.height > 599 ? 16 : 13.1072)))))),

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

  Widget listSample() {
    firstTimeClickFlag = boolFlags.contains(true);
    return SingleChildScrollView(
        child: Container(
            // color: Colors.grey[350],
            // height: totalheight.toDouble(),
            decoration: BoxDecoration(
                color: Colors.grey[350],
                border: Border.all(color: Colors.black)),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: finalizeNotification.length,
              itemBuilder: (BuildContext context, int index) {
                var item = finalizeNotification[index];
                log(item);
                if (index == 0) {
                  return Container(
                      // height: 30,
                      color: Colors.grey[350],
                      // padding: const EdgeInsets.only(top: 8, left: 10, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('View Notifications',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                          Visibility(
                              visible: firstTimeClickFlag,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 85,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (selectionFlag == true) {
                                          selectionFlag = false;
                                          boolFlags = boolFlags
                                              .map((c) => c = false)
                                              .toList();
                                          log(boolFlags);
                                        } else {
                                          selectionFlag = true;
                                          boolFlags = boolFlags
                                              .map((c) => c = true)
                                              .toList();
                                          log(boolFlags);
                                        }
                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: hp.theme.primaryColor,
                                          padding: EdgeInsets.zero,
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                      child: Text(
                                        selectionFlag
                                            ? 'Unselect All'
                                            : 'Select All',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 75,
                                    height: 35,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (selectionFlag) {
                                          List<String> lists = readNotification
                                              .map((e) =>
                                                  e.notificationID.toString())
                                              .toList();
                                          log(lists);
                                          waitUntilNotificationDelete(lists);
                                        } else {
                                          log(boolFlags);
                                          // var changesBool = boolFlags;
                                          // var lengths = unreadNotification.length + 3;
                                          //  log(lengths);
                                          // changesBool.re
                                          // log(changesBool);
                                          int k = 0;
                                          for (bool i in boolFlags) {
                                            final index =
                                                boolFlags.indexOf(i, k);
                                            if (i &&
                                                !selectedIndices
                                                    .contains(index)) {
                                              selectedIndices.add(index);
                                              k = (index);
                                              k = k + 1;
                                            } else {
                                              ++k;
                                            }
                                          }
                                          log(selectedIndices);
                                          selectedIndices.sort();
                                          if (selectedIndices.isNotEmpty) {
                                            for (int i in selectedIndices) {
                                              final id = readNotification[i]
                                                  .notificationID
                                                  .toString();
                                              if (!selectedIDs.contains(id)) {
                                                selectedIDs.add(id);
                                              }
                                            }
                                            log(selectedIDs);
                                          }

                                          final f2 = await hp.showDialogBox(
                                            title: const Text(
                                              'Confirm!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: const Text(
                                                'Are you sure want to delete?'),
                                            type: AlertType.cupertino,
                                            actions: <Widget>[
                                              CupertinoDialogAction(
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                onPressed: () {
                                                  hp.goBack();
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  hp.goBack();
                                                  waitUntilNotificationDelete(
                                                      selectedIDs);
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: hp.theme.primaryColor,
                                          padding: EdgeInsets.zero,
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal)),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ));
                } else if (index == 1) {
                  return unreadNotification.isNotEmpty
                      ? Container(
                          height: 40,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: const Text('Unread Messages',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )
                      : Container(
                          height: 0,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: const Text('',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        );
                } else if (index == (unreadNotification.length + 2)) {
                  log(index);
                  log('ena index da');
                  return readNotification.isNotEmpty
                      ? Container(
                          height: 40,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: const Text('Read Messages',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )
                      : Container(
                          height: 0,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: const Text('',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        );
                } else {
                  return unreadNotification.length + 2 <= index
                      ? Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: (BuildContext context) async {
                                  final i =
                                      index - (unreadNotification.length + 3);
                                  log(i);
                                  final f2 = await hp.showDialogBox(
                                    title: const Text(
                                      'Confirm!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                        'Are you sure want to delete?'),
                                    type: AlertType.cupertino,
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () {
                                          hp.goBack();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          hp.goBack();
                                          waitUntilNotificationDelete([
                                            readNotification[i]
                                                .notificationID
                                                .toString()
                                          ]);
                                        },
                                      ),
                                    ],
                                  );
                                },
                                backgroundColor: hp.theme.primaryColor,
                                foregroundColor: Colors.white,
                                // icon: Icons.save,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: GestureDetector(
                              onTap: () async {
                                final i =
                                    index - (unreadNotification.length + 3);
                                final not = readNotification[i];
                                log(readNotification[i].notificationType);
                                log(firstTimeClickFlag);
                                if (firstTimeClickFlag && mounted) {
                                  setState(() {
                                    boolFlags[i] = !boolFlags[i];
                                  });
                                } else {
                                  var type = not.notificationType;
                                  log(i);
                                  log(type);
                                  log('asjkdnjksanjnsjvsf');
                                  if (not.alert_msg.isEmpty) {
                                    if (not.notificationType == 1) {
                                      switch (not.requestStatus) {
                                        case 0:
                                          Map<String, dynamic> passParams = {
                                            'req_access_id':
                                                not.requestAccessID.toString(),
                                            'notification_id':
                                                not.notificationID,
                                          };
                                          waitUntilNotificationMarkedRead(
                                              not, passParams);
                                          break;
                                        case 1:
                                          log(Property.fromMap(not.json));
                                          props.value =
                                              Property.fromMap(not.json);
                                          props.value.onChange();
                                          log(props.value.json);
                                          Map<String, dynamic> passParams = {
                                            'address': not.address,
                                            'created_at': not.createdAt,
                                            'expiryDate': not.expiryDate,
                                            'accessForever': not.accessForever
                                          };
                                          log('Tom Cruise');
                                          log(passParams);
                                          log(Property.fromMap(not.json)
                                              .toString());
                                          // log(Property.fromMap(not.json));
                                          hp.goTo('/access_granted_screen',
                                              args: RouteArgument(
                                                  id: not.accessForever,
                                                  params: passParams,
                                                  content:
                                                      Property.fromMap(not.json)
                                                          .toString()),
                                              vcb: waitForNotifications);
                                          break;
                                        case 2:
                                          (await hp.showDialogBox(
                                                    title: const Text(
                                                      'Access is declined',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: const Text(
                                                        'Your Request Access to view this property has been Declined.'),
                                                    type: AlertType.cupertino,
                                                    actions: <Widget>[
                                                      CupertinoDialogAction(
                                                        child: const Text(
                                                          'OK',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                        onPressed: () {
                                                          hp.goBack(
                                                              result: true);
                                                        },
                                                      ),
                                                    ],
                                                  ) ??
                                                  false)
                                              ? log('Hi')
                                              : doNothing();
                                          break;
                                        default:
                                          doNothing();
                                          break;
                                      }
                                    } else if (not.notificationType == 5 &&
                                        (await hp.showDialogBox(
                                              title: const Text(
                                                'Access is Revoked',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: const Text(
                                                  'Your Access to view this property has been Revoked.'),
                                              type: AlertType.cupertino,
                                              actions: <Widget>[
                                                CupertinoDialogAction(
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  onPressed: () {
                                                    hp.goBack(result: true);
                                                  },
                                                ),
                                              ],
                                            ) ??
                                            false)) {
                                      log('revoked');
                                      deleteNotifications(not.notificationID, 0,
                                          not, <String, dynamic>{},
                                          alert: not.alert_msg);
                                    } else if (not.notificationType == 4 &&
                                        (await hp.showSimplePopup('OK', () {
                                          hp.goBack(result: true);
                                        },
                                            type: AlertType.cupertino,
                                            title: 'Message!!',
                                            action: not.content))) {
                                      waitForNotifications();
                                    } else {}
                                  } else if (await hp.showDialogBox(
                                        title: const Text(
                                          'Notifications',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(not.alert_msg),
                                        type: AlertType.cupertino,
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            onPressed: () {
                                              hp.goBack(result: true);
                                            },
                                          ),
                                        ],
                                      ) ??
                                      false) {
                                    log('object');
                                    deleteNotifications(not.notificationID, 0,
                                        not, <String, dynamic>{},
                                        alert: not.alert_msg);
                                  } else {
                                    deleteNotifications(not.notificationID, 0,
                                        not, <String, dynamic>{},
                                        alert: not.alert_msg);
                                  }
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                    top: 10,
                                    left: (hp.dimensions.orientation ==
                                            Orientation.landscape)
                                        ? 40
                                        : 0,
                                    bottom: 10),
                                color: Colors.grey[350],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              flex: 1,
                                              child: IconButton(
                                                icon: boolFlags[index -
                                                        (unreadNotification
                                                                .length +
                                                            3)]
                                                    ? Icon(Icons.check_circle,
                                                        size: 22,
                                                        color: hp
                                                            .theme.primaryColor)
                                                    : const Icon(Icons.circle,
                                                        size: 22,
                                                        color: Colors.white),
                                                onPressed: () {
                                                  final i = index -
                                                      (unreadNotification
                                                              .length +
                                                          3);
                                                  log(i);
                                                  setState(() {
                                                    boolFlags[i] =
                                                        !boolFlags[i];
                                                    selectionFlag = !boolFlags
                                                        .contains(false);
                                                  });
                                                },
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            flex: 7,
                                            child: Text(item.content,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff3880ff))),
                                          )
                                        ],
                                      ),
                                    ),
                                    //  const SizedBox(height: 5,),
                                    //  Divider(height: 1,thickness: 1,color: Colors.grey[700],)
                                  ],
                                ),
                              )))
                      : GestureDetector(
                          onTap: () async {
                            final i = index - 2;
                            final not = unreadNotification[i];
                            log(not.notificationType);
                            log(not.requestStatus);
                            log('nreadNotification[i].requestStatus');
                            final alert = not.alert_msg;
                            log(alert);
                            if (alert.isEmpty) {
                              if (not.notificationType == 1) {
                                if (not.requestStatus == 0) {
                                  // Loader.show(context);
                                  Map<String, dynamic> passParams = {
                                    'req_access_id':
                                        not.requestAccessID.toString(),
                                    'notification_id': not.notificationID,
                                  };
                                  waitUntilNotificationMarkedRead(
                                      not, passParams);
                                } else if (not.requestStatus == 1) {
                                  // Loader.show(context);
                                  Map<String, dynamic> passParams = {
                                    'address': not.address,
                                    'created_at': not.createdAt,
                                    'expiryDate': not.expiryDate,
                                  };
                                  waitUntilNotificationMarkedRead(
                                      not, passParams);
                                } else if (await hp.showDialogBox(
                                      title: const Text(
                                        'Access is declined',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: const Text(
                                          'Your Request Access to view this property has been Declined.'),
                                      type: AlertType.cupertino,
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          onPressed: () {
                                            hp.goBack(result: true);
                                          },
                                        ),
                                      ],
                                    ) ??
                                    false) {
                                  Map<String, dynamic> passParams = {
                                    'req_access_id':
                                        not.requestAccessID.toString(),
                                  };
                                  waitUntilNotificationMarkedRead(
                                      not, passParams);
                                } else {}
                              } else if (not.notificationType == 5 &&
                                  (await hp.showDialogBox(
                                        title: const Text(
                                          'Access is Revoked',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: const Text(
                                            'Your Access to view this property has been Revoked.'),
                                        type: AlertType.cupertino,
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            onPressed: () {
                                              hp.goBack(result: true);
                                            },
                                          ),
                                        ],
                                      ) ??
                                      false)) {
                                Map<String, dynamic> passParams = {
                                  'req_access_id':
                                      not.requestAccessID.toString(),
                                };
                                waitUntilNotificationMarkedRead(
                                    not, passParams);
                              } else if (not.notificationType == 4 &&
                                  (await hp.showSimplePopup('OK', () {
                                    hp.goBack(result: true);
                                  },
                                      type: AlertType.cupertino,
                                      title: title,
                                      action: not.content))) {
                                waitUntilNotificationMarkedRead(not, {
                                  'req_access_id':
                                      not.requestAccessID.toString()
                                });
                              } else if (await hp.showDialogBox(
                                    title: const Text(
                                      'Notifications',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(alert),
                                    type: AlertType.cupertino,
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        onPressed: () {
                                          hp.goBack(result: true);
                                        },
                                      ),
                                    ],
                                  ) ??
                                  false) {
                                Map<String, dynamic> passParams = {
                                  'req_access_id':
                                      not.requestAccessID.toString(),
                                  'notification_id': not.notificationID,
                                };
                                waitUntilNotificationMarkedRead(
                                    not, passParams);
                              }
                            } else if (await hp.showDialogBox(
                                  title: const Text(
                                    'Notifications',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(alert),
                                  type: AlertType.cupertino,
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onPressed: () {
                                        hp.goBack(result: true);
                                      },
                                    ),
                                  ],
                                ) ??
                                false) {
                              deleteNotifications(not.notificationID, 0, not,
                                  <String, dynamic>{},
                                  alert: alert);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: 10,
                                left: (hp.dimensions.orientation ==
                                        Orientation.landscape)
                                    ? 40
                                    : 0,
                                bottom: 10),
                            color: Colors.grey[350],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 7,
                                        child: Text(item.content,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff3880ff))),
                                      )
                                    ],
                                  ),
                                ),
                                // const SizedBox(height: 5,),
                                //  Divider(height: 1,thickness: 1,color: Colors.grey[700],)
                              ],
                            ),
                          ),
                        );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[700],
                );
              },
            )));
  }

  Widget noNotification() {
    List<String> listsample = ['No Notifications Found'];
    var list = listsample
        .map((item) => TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Container(
                      height: 40,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(item,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ),
                ],
                decoration: const BoxDecoration(
                    color: /*con.documents!.indexOf(item) % 2 == 0
                    ?*/
                        Colors.white /*: Colors.black12*/)))
        .toList();
    list.insert(
      0,
      TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            // height: 30,
            color: Colors.grey[350],
            padding: const EdgeInsets.only(top: 8, left: 10, bottom: 5),
            child: const Text('View Notifications',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
          ),
        ),
      ], decoration: const BoxDecoration(color: Colors.black26)),
    );
    return Table(
        children: list,
        columnWidths: const {0: FlexColumnWidth(1)},
        textDirection: TextDirection.ltr,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
            top: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            left: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            right: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            bottom: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            verticalInside: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            horizontalInside: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1)));
  }

  void waitForNotifications() async {
    try {
      loaderFlag = true;
      final list = await api.getNotifications();
      notifications = list;
      if (mounted) {
        setState(() {
          if (notifications.isNotEmpty) {
            unreadNotification = notifications
                .where((element) => !parseBool(element.readStatus.toString()))
                .toList();
            readNotification = notifications
                .where((element) => parseBool(element.readStatus.toString()))
                .toList();
            log(unreadNotification.length);
            log(readNotification.length);
            unreadNotification.sort(sorter);
            readNotification.sort(sorter);
            var sample = [
              UserNotification.emptyNotification,
              UserNotification.emptyNotification
            ];
            var sample1 = [UserNotification.emptyNotification];
            log(sample.length);
            log(sample1.length);
            log(unreadNotification.length);
            log(readNotification.length);
            finalizeNotification =
                sample + unreadNotification + sample1 + readNotification;
            boolFlags = List<bool>.filled(readNotification.length, false);
          } else {
            finalizeNotification = <UserNotification>[];
          }
          loaderFlag = false;
        });
      }
    } catch (e) {
      sendAppLog(e);
      if (mounted) {
        setState(() => notifications = <UserNotification>[]);
      }
    }
  }

  void waitUntilNotificationMarkedRead(
      UserNotification notification, Map<String, dynamic> value) async {
    try {
      log(notification.readStatus);
      Loader.show(context);
      final val = await api.readNotifications(notification);
      Loader.hide();
      if (val.reply.success) {
        if (notification.alert_msg.isEmpty) {
          switch (notification.notificationType) {
            case 1:
              switch (notification.requestStatus) {
                case 0:
                  hp.goTo('/notification_details',
                      args: RouteArgument(params: value), vcb: () {
                    waitForNotifications();
                  });
                  break;
                case 1:
                case 2:
                  deleteNotifications(notification.notificationID,
                      notification.requestStatus, notification, value,
                      alert: notification.alert_msg);
                  break;
                default:
                  doNothing();
                  break;
              }
              break;
            case 5:
              deleteNotifications(notification.notificationID,
                  notification.requestStatus, notification, value,
                  alert: notification.alert_msg);
              break;
            default:
              waitForNotifications();
              break;
          }
        } else {
          deleteNotifications(notification.notificationID,
              notification.requestStatus, notification, value,
              alert: notification.alert_msg);
          waitForNotifications();
        }
      }
    } catch (e) {
      Loader.hide();
      sendAppLog(e);
    }
  }

  void deleteNotifications(int notificationid, int status,
      UserNotification notification, Map<String, dynamic> value,
      {String? alert}) async {
    try {
      final values =
          await api.deleteNotificationUpdateAccess(notification.notificationID);
      log(values.success);
      log(values.message);
      log(status);
      log('Daniel Radcliffe');
      log(alert);
      log('came here');
      if (values.success) {
        if (status == 1 && (alert?.isEmpty ?? true)) {
          value['accessForever'] = notification.accessForever;
          log('Brad Pitt');
          log(value);
          log('accessForever');
          log(Property.fromMap(notification.json).toString());
          hp.goTo('/access_granted_screen',
              args: RouteArgument(
                  id: value['accessForever'],
                  params: value,
                  content: Property.fromMap(notification.json).toString()),
              vcb: waitForNotifications);
        } else {
          waitForNotifications();
        }
      } else {
        sendAppLog('${values.message}delete notification api');
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void waitUntilNotificationDelete(List<String> notificationid) async {
    try {
      Loader.show(context);
      Map<String, dynamic> notifiatoionids = {
        'notification_ids': notificationid,
      };
      final value = await api.deleteNotification(notifiatoionids);
      Loader.hide();
      if (await hp.showDialogBox(
            title: const Text(
              'Success',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            content: Text(value.message),
            type: AlertType.cupertino,
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  hp.goBack(result: true);
                },
              ),
            ],
          ) ??
          false) {
        selectedIDs = [];
        selectedIndices = [];
        boolFlags = [];
        waitForNotifications();
      }
    } catch (e) {
      Loader.hide();
      sendAppLog(e);
    }
  }

  @override
  void initState() {
    super.initState();
    waitForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
              leadingWidth: hp.leadingWidth,
              leading: LayoutBuilder(builder: leadingBuilder),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Notifications',
                  style: TextStyle(fontWeight: FontWeight.w600))),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          bottomNavigationBar: const BottomWidget(),
          body: loaderFlag
              ? CustomLoader(
                  duration: const Duration(seconds: 10),
                  color: hp.theme.primaryColor,
                  loaderType: LoaderType.fadingCircle)
              : (finalizeNotification.isNotEmpty
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: listSample())
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: noNotification()))),
    );
  }
}
