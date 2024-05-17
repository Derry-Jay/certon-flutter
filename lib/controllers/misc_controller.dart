import '../models/user.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/faq.dart';
import '../backend/api.dart';
import '../widgets/loader.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../models/user_notification.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../mobile_screens/notifications_screen.dart';

class OtherController extends ControllerMVC {
  List<FrequentlyAskedQuestion>? faqs;
  List<UserNotification>? notifications;
  Duration duration = const Duration(seconds: 5);
  List<bool> flags = <bool>[];
  TextEditingController pc = TextEditingController();
  Helper get hp => Helper.of(state?.context ?? states.first.context);

  void proceed() async {
    await Future.delayed(Duration.zero, start);
  }

  void start() async {
    final prefs = await sharedPrefs;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    log(appName);
    log(packageName);
    log(version);
    log(buildNumber);
    if (buildNumber == prefs.getString('BuildNo')) {
      log('object');
    } else if (!prefs.containsKey('BuildNo') &&
        await prefs.setString('BuildNo', buildNumber)) {
      currentUser.value = User.emptyUser;
    }
    log('builfnuam');
    log(prefs.getString('BuildNo'));

    currentUser.value.isNotEmpty
        ? hp.gotoForever('/mobile_home')
        : hp.gotoOnce(
            '/${prefs.containsKey('gsf') && (prefs.getBool('gsf') ?? false) ? 'mobile_login' : 'get_started'}',
            args: currentUser.value.isNotEmpty);
  }

  void setNot(UserNotification notification) async {
    notifier.value = notification;
    notification.onChange();
  }

  // void waitForNotifications(NotificationsScreenState state) async {
  //   try {
  //     final list = await getNotifications();
  //     setState(() => notifications = list);
  //     if ((state.flags.isEmpty || !state.flags.contains(false)) &&
  //         list.isNotEmpty) {
  //       state.flags = List<bool>.filled(list.length, false);
  //     }
  //   } catch (e) {
  //     if (await revealToast(e.toString())) {
  //       setState(() => notifications = <UserNotification>[]);
  //       rethrow;
  //     }
  //   }
  // }

  // void waitUntilNotificationsDeleted(NotificationsScreenState state) async {
  //   try {
  // int k = 0;
  // for (bool i in state.flags) {
  //   final index = state.flags.indexOf(i, k);
  //   if (i && !state.selectedIndices.contains(index)) {
  //     state.selectedIndices.add(index);
  //     k = index + 1;
  //   } else {
  //     ++k;
  //   }
  // }
  //     state.selectedIndices.sort();
  // if (!(notifications == null || state.selectedIndices.isEmpty)) {
  //   for (int i in state.selectedIndices) {
  //     final id = notifications![i].notificationID.toString();
  //     if (!state.selectedIDs.contains(id)) {
  //       state.selectedIDs.add(id);
  //     }
  //   }
  //       final body = {'notification_ids': state.selectedIDs};
  //       final f1 =
  //           await revealToast('Please Wait....', length: Toast.LENGTH_LONG);
  //       final value = await deleteNotification(body);
  //       final f2 = await revealToast(value.message);
  //       if (f1 && f2 && value.success) {
  //         state.didUpdateWidget(state.widget);
  //       }
  //     } else {
  //       final pr =
  //           await revealToast('Please Select a Notification to Delete');
  //       if (pr)
  //     }
  //   } catch (e) {
  //     final er = await revealToast(e.toString());
  //     if (er) rethrow;
  //   }
  // }

  void waitUntilNotificationDeleted(
      UserNotification notification, NotificationsScreenState state) async {
    try {
      // final f1 =
      //     await revealToast('Please Wait....', length: Toast.LENGTH_LONG);
      Loader.show(state.context);
      final value = await api.deleteNotification(notification.thd);
      Loader.hide();
      final f = await hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      }, action: value.message, type: AlertType.cupertino);
      if (f && value.success) {
        state.didUpdateWidget(state.widget);
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void waitForFAQs() async {
    try {
      final list = await api.getFAQs();
      setState(() => faqs = list);
    } catch (e) {
      setState(() => faqs = <FrequentlyAskedQuestion>[]);
      log(e);
    }
  }

  void waitUntilNotificationMarkedRead(UserNotification notification,
      NotificationsScreenState state, Map<String, dynamic> value) async {
    try {
      if (parseBool(notification.readStatus.toString())) {
        log(parseBool(notification.readStatus.toString()));
        setNot(notification);
        log(notification.requestStatus);
        hp.goTo('/notification_details', args: RouteArgument(params: value));
      } else {
        log(notification.requestStatus);
        final val = await api.readNotifications(notification);
        if (val.reply.success) {
          setNot(notification);
          if (notification.requestStatus == 0) {
            hp.goTo('/notification_details', args: RouteArgument(params: value),
                vcb: () {
              state.didUpdateWidget(state.widget);
            });
          }
        }
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void waitUntilAddressObtained(String val) async {
    try {
      if (val.isNotEmpty && val.trim().isNotEmpty) {
        final value = await api.getAddresses({'postcode': val});
        location.value = value;
        if (location.value.addresses.isNotEmpty) {
          flags = List<bool>.filled(location.value.addresses.length, false);
        }
      }
    } catch (e) {
      sendAppLog(e);
    }
  }
}
