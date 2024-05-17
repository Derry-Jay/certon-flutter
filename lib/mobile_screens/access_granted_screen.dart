import 'dart:convert';
import '../helpers/helper.dart';
import 'package:intl/intl.dart';
import '../models/property.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';

class AccessGrantedScreen extends StatefulWidget {
  final RouteArgument rar;
  const AccessGrantedScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AccessGrantedScreenState createState() => AccessGrantedScreenState();
}

class AccessGrantedScreenState extends StateMVC<AccessGrantedScreen> {
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    final address = widget.rar.params['address'];
    final createdAt = widget.rar.params['created_at'];
    final expiryDate = widget.rar.params['expiryDate'];
    DateTime tempDate, tempDate2;
    try {
      tempDate =
          DateFormat('yyyy-MM-dd hh:mm:ss').parse(createdAt?.toString() ?? '');
    } catch (e) {
      sendAppLog(e);
      tempDate = DateTime.now();
    }
    log(widget.rar.params['access_forever']);
    try {
      tempDate2 =
          DateFormat('dd/MM/yyyy hh:mm').parse(expiryDate?.toString() ?? '');
    } catch (e) {
      sendAppLog(e);
      tempDate2 = DateTime.now();
    }
    final diff = tempDate2.difference(tempDate);
    String date = DateFormat('dd-MMMM-yyyy').format(tempDate),
        daysDiffValue = diff.inDays.toString();
    log(daysDiffValue);
    if (diff.inDays <= 7 && diff.inDays >= 2) {
      daysDiffValue = '1 week';
    } else if (diff.inDays <= 1) {
      daysDiffValue = '1 day';
    } else if (diff.inDays <= 30 && diff.inDays >= 8) {
      daysDiffValue = '1 month';
    } else {
      if (widget.rar.params['access_forever'] == 1) {
        daysDiffValue = 'Forever';
      } else {
        daysDiffValue = '$daysDiffValue days';
      }
    }
    if (widget.rar.id == 1) {
      daysDiffValue = 'Forever';
    }
    log('^^^^^^^^^');
    log(DateTime.now().difference(tempDate2).inDays);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 10),
                  child: Text(
                    'Good News',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 10),
                    child: Text(
                      'You have now access to the stored documents for $address from \n$date for $daysDiffValue.',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                const SizedBox(height: 10),
                const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 10),
                    child: Text(
                      'This access was granted by the property account holder ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                Visibility(
                    visible: !parseBool(DateTime.now()
                            .difference(tempDate2)
                            .inDays
                            .toString()) ||
                        parseBool(
                            widget.rar.params['accessForever'].toString()),
                    child: GestureDetector(
                        child: Container(
                          height: 75,
                          width: 150,
                          padding: const EdgeInsets.only(
                              left: 20, top: 25, bottom: 15),
                          child: Text('View Property',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: hp.theme.focusColor)),
                        ),
                        onTap: () {
                          //  props.value = item;
                          //  item.onChange();
                          log(widget.rar.content);
                          hp.goTo('/single_property_view', vcb: () {
                            didUpdateWidget(widget);
                          },
                              args: RouteArgument(
                                  id: 0,
                                  params: Property.fromMap(
                                      jsonDecode(widget.rar.content ?? '')),
                                  content: 'true'));
                        }))
              ],
            ),
          ),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              leadingWidth: hp.leadingWidth,
              leading: const LeadingWidget(visible: false),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Access Granted',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }
}
