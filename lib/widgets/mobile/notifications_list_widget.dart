import 'my_labelled_button.dart';
import '../../helpers/helper.dart';
import 'notification_item_widget.dart';
import 'package:flutter/material.dart';
import '../../models/user_notification.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/misc_controller.dart';
import '../../mobile_screens/notifications_screen.dart';

class NotificationsListWidget extends StatefulWidget {
  final List<UserNotification> notifications;
  const NotificationsListWidget({Key? key, required this.notifications})
      : super(key: key);

  static NotificationsScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<NotificationsScreenState>();

  @override
  NotificationsListWidgetState createState() => NotificationsListWidgetState();
}

class NotificationsListWidgetState extends StateMVC<NotificationsListWidget> {
  late OtherController con;
  NotificationsListWidgetState() : super(OtherController()) {
    con = controller as OtherController;
  }
  NotificationsScreenState? get nps => NotificationsListWidget.of(context);
  Widget getItemunread(BuildContext context, int index) {
    return NotificationItemWidget(
        notification: widget.notifications[index], index: index);
  }

  // Widget getItemread(BuildContext context, int index) {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    log(widget.notifications.length);
    List<UserNotification> unreadNotification = widget.notifications
        .where((element) => element.readStatus == 0)
        .toList();
    List<UserNotification> readNotification = widget.notifications
        .where((element) => element.readStatus == 1)
        .toList();
    unreadNotification.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    readNotification.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    log(unreadNotification.length);
    log(readNotification.length);
    final hp = Helper.of(context);
    return Padding(
        padding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
        child: Container(
            padding: const EdgeInsets.all(0),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return unreadNotification.length != index + 1
                      ? Card(
                          child: InkWell(
                              child: Padding(
                                  // padding: EdgeInsets.zero,
                                  padding: EdgeInsets.symmetric(
                                      vertical: hp.height / 64,
                                      horizontal: hp.width / 40),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: index == 0,
                                          child: const Center(
                                            child: Text(
                                              'Unread Notification',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: index == 0,
                                          child: const SizedBox(
                                            height: 20,
                                          ),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      unreadNotification[index]
                                                          .content,
                                                      style: parseBool(
                                                              unreadNotification[
                                                                      index]
                                                                  .readStatus
                                                                  .toString())
                                                          ? hp.textTheme
                                                              .bodyText2
                                                          : hp.textTheme
                                                              .bodyText1)),
                                              Flexible(
                                                  child: Checkbox(
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all<Color>(hp
                                                                  .theme
                                                                  .primaryColor),
                                                      value: false,
                                                      onChanged:
                                                          (bool? value) {},
                                                      checkColor: hp.theme
                                                          .scaffoldBackgroundColor))
                                            ]),
                                        // Text(widget.notification.time)
                                        // ,
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      unreadNotification[index]
                                                          .time)),
                                              Flexible(
                                                  child: IconButton(
                                                      onPressed: () {
                                                        // con.waitUntilNotificationDeleted(
                                                        //     unreadNotification[index], nls!.nps!);
                                                      },
                                                      icon: Icon(Icons.delete,
                                                          color: hp.theme
                                                              .primaryColor)))
                                            ])
                                      ])),
                              onTap: () {
                                if (unreadNotification[index].requestStatus ==
                                    0) {
                                } else if (unreadNotification[index]
                                        .requestStatus ==
                                    1) {
                                } else {}

                                // con.waitUntilNotificationMarkedRead(
                                //     widget.notification, nls!.nps!);
                              }))
                      : Card(
                          child: InkWell(
                              child: Padding(
                                  // padding: EdgeInsets.zero,
                                  padding: EdgeInsets.symmetric(
                                      vertical: hp.height / 64,
                                      horizontal: hp.width / 40),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: index == 0,
                                          child: const Center(
                                            child: Text(
                                              'Read Notification',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: index == 0,
                                          child: const SizedBox(
                                            height: 20,
                                          ),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      readNotification[index]
                                                          .content,
                                                      style: parseBool(
                                                              readNotification[
                                                                      index]
                                                                  .readStatus
                                                                  .toString())
                                                          ? hp.textTheme
                                                              .bodyText2
                                                          : hp.textTheme
                                                              .bodyText1)),
                                              Flexible(
                                                  child: Checkbox(
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all<Color>(hp
                                                                  .theme
                                                                  .primaryColor),
                                                      value: false,
                                                      onChanged:
                                                          (bool? value) {},
                                                      checkColor: hp.theme
                                                          .scaffoldBackgroundColor))
                                            ]),
                                        // Text(widget.notification.time)
                                        // ,
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      readNotification[index]
                                                          .time)),
                                              Flexible(
                                                  child: IconButton(
                                                      onPressed: () {
                                                        // con.waitUntilNotificationDeleted(
                                                        //     unreadNotification[index], nls!.nps!);
                                                      },
                                                      icon: Icon(Icons.delete,
                                                          color: hp.theme
                                                              .primaryColor)))
                                            ])
                                      ])),
                              onTap: () {
                                if (readNotification[index].requestStatus ==
                                    0) {
                                } else if (readNotification[index]
                                        .requestStatus ==
                                    1) {
                                } else {}

                                // con.waitUntilNotificationMarkedRead(
                                //     widget.notification, nls!.nps!);
                              }));
                },
                itemCount:
                    unreadNotification.length + readNotification.length)));
  }

  @override
  void didUpdateWidget(NotificationsListWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // con.waitForNotifications(nps!);
  }

  Widget tableStructure(BuildContext context) {
    log(con.notifications);
    var list = (con.notifications as List<UserNotification>)
        .map((item) => TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                      child:
                          //  Row(children: [
                          //    RadioButtonGroup(
                          //       labels: <String>[
                          //         "Option 1",
                          //       ],
                          //       onSelected: (String selected) => log(selected)
                          //     ),
                          Text(item.content,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
                decoration: BoxDecoration(
                    color:
                        // con.documents!.indexOf(item) % 2 == 0
                        //     ? Colors.white
                        // :
                        Colors.black12.withAlpha(20))))
        .toList();

    // list.insert(1, const TableRow(children: [
    //       TableCell(child: Text('Read Messages', textAlign: TextAlign.center, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),)
    // ]));

    //  list.insert(2, TableRow(children: [
    //               TableCell(child: Text('Unread Messages', textAlign: TextAlign.center, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),)
    // ]));

    list.insert(
      0,
      TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('View Notifications',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                Row(
                  children: const [
                    MyLabelledButton(
                        type: ButtonType.text, label: 'Select All'),
                    SizedBox(width: 5),
                    MyLabelledButton(type: ButtonType.text, label: 'Delete'),
                  ],
                )
              ],
            ),
          ),
        ),
      ], decoration: const BoxDecoration(color: Colors.black26)),
    );
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Table(
          children: list,
          columnWidths: const {
            0: FlexColumnWidth(1),
          },
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
              horizontalInside: BorderSide.none)),
    );

    //  Table(children: list,columnWidths: const {
    //                           0: FlexColumnWidth(1),

    //                         },
    //                         textDirection: TextDirection.ltr,
    //                         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    //                   border:
    //                   const TableBorder(top: BorderSide(color:  Colors.black,style: BorderStyle.solid,
    //                                   width: 1), left: BorderSide(color:  Colors.black,style: BorderStyle.solid,
    //                                   width: 1),right: BorderSide(color:  Colors.black,style: BorderStyle.solid,
    //                                   width: 1),bottom: BorderSide(color:  Colors.black,style: BorderStyle.solid,
    //                                   width: 1),verticalInside: BorderSide(color:  Colors.black,style: BorderStyle.solid,
    //                                   width: 1), horizontalInside: BorderSide.none )

    //   );
  }
}
