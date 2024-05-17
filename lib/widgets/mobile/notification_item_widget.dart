import '../../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'notifications_list_widget.dart';
import '../../models/user_notification.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/misc_controller.dart';

class NotificationItemWidget extends StatefulWidget {
  final UserNotification notification;
  final int index;
  const NotificationItemWidget(
      {Key? key, required this.notification, required this.index})
      : super(key: key);

  static NotificationsListWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<NotificationsListWidgetState>();

  @override
  NotificationItemWidgetState createState() => NotificationItemWidgetState();
}

class NotificationItemWidgetState extends StateMVC<NotificationItemWidget> {
  late OtherController con;
  Helper get hp => Helper.of(context);

  NotificationItemWidgetState() : super(OtherController()) {
    con = controller as OtherController;
  }
  NotificationsListWidgetState? get nls => NotificationItemWidget.of(context);

  void setVal(bool? val) {
    // nls!.setState(() =>
    //     nls!.nps!.flags[widget.index] = val ?? !nls!.nps!.flags[widget.index]);
  }

  @override
  Widget build(BuildContext context) {
    bool? value;
    try {
      // value = nls!
      //     .nps!.flags[nls!.widget.notifications.indexOf(widget.notification)];
    } catch (e) {
      value = false;
    }
    return Card(
        child: InkWell(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: hp.height / 64, horizontal: hp.width / 40),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                        child: Text(widget.notification.content,
                            style: parseBool(
                                    widget.notification.readStatus.toString())
                                ? hp.textTheme.bodyText2
                                : hp.textTheme.bodyText1)),
                    Flexible(
                        child: Checkbox(
                            fillColor: MaterialStateProperty.all<Color>(
                                hp.theme.primaryColor),
                            value: value,
                            onChanged: setVal,
                            checkColor: hp.theme.scaffoldBackgroundColor))
                  ]),
                  // Text(widget.notification.time)
                  // ,
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(child: Text(widget.notification.time)),
                    Flexible(
                        child: IconButton(
                            onPressed: () {
                              con.waitUntilNotificationDeleted(
                                  widget.notification, nls!.nps!);
                            },
                            icon: Icon(Icons.delete,
                                color: hp.theme.primaryColor)))
                  ])
                ])),
            onTap: () {
              if (widget.notification.requestStatus == 0) {
              } else if (widget.notification.requestStatus == 1) {
              } else {}

              // con.waitUntilNotificationMarkedRead(
              //     widget.notification, nls!.nps!);
            }));
  }
}
