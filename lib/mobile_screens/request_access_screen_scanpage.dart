import '../backend/api.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/loader.dart';

class RequestAccessScanPageScreen extends StatefulWidget {
  final RouteArgument rar;
  const RequestAccessScanPageScreen({Key? key, required this.rar})
      : super(key: key);

  @override
  RequestAccessScanPageScreenScreenState createState() =>
      RequestAccessScanPageScreenScreenState();
}

class RequestAccessScanPageScreenScreenState
    extends StateMVC<RequestAccessScanPageScreen> {
  Helper get hp => Helper.of(context);
  Property prop = Property.emptyProperty;

  @override
  Widget build(BuildContext context) {
    log(widget.rar.params['prop']);
    prop = widget.rar.params['prop'];
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
              leadingWidth: hp.leadingWidth,
              leading: const LeadingWidget(visible: false),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Request Access',
                  style: TextStyle(fontWeight: FontWeight.w600))),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          bottomNavigationBar: const BottomWidget(),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Request Access to a Property',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'You would like to access the property:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.rar.params['address'],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Your details:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.rar.params['comp'] ?? '',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.rar.params['firstname'] +
                      ' ' +
                      widget.rar.params['lastname'],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'will be sent to the Account holder to request access to the documents for this property.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: Text(
                    'Request Access',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: hp.theme.focusColor,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () async {
                    requestaccessAPI(context);
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ))),
    );
  }

  void requestaccessAPI(BuildContext context) async {
    try {
      if (prop.userID != currentUser.value.userID) {
        Loader.show(context);
        final v = await api.requestAccess(prop);
        Loader.hide();
        log(v);
        if (v.success) {
          hp.showSimplePopup('OK', () {
            hp.goBack();
            hp.gotoForever('/mobile_home');
          },
              action: 'Property access Request sent to the Property owner!',
              type: AlertType.cupertino);
        } else {
          hp.showSimplePopup('OK', () {
            hp.goBack();
          }, action: v.message, type: AlertType.cupertino);
        }
      } else {}
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) {
        Loader.hide();
      }
    }
  }
}
