import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddPropertyOtherSuccess extends StatefulWidget {
  final RouteArgument rar;
  const AddPropertyOtherSuccess({Key? key, required this.rar})
      : super(key: key);

  @override
  AddPropertyOtherSuccessState createState() => AddPropertyOtherSuccessState();
}

class AddPropertyOtherSuccessState extends StateMVC<AddPropertyOtherSuccess> {
  Helper get hp => Helper.of(context);
  final now = DateFormat('hh:mm:ss').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    log(widget.rar);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Property Added',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Good news!',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'You now have successfully added the new Property to the new account of ${widget.rar.params['first_name']} ${widget.rar.params['last_name']}.',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.rar.params['address'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Type: ${widget.rar.tag}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'QR Code Installation Date: ${widget.rar.params['purchased_date']} $now',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                      'The Property will now appear in your Other Properties Section, You have been Granted Access to this Property for 1 Month.',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'The customer will receive a welcome email to: ${widget.rar.params['email']}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal)),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      child: Text('Back to home',
                          style: TextStyle(
                              fontSize: 15,
                              color: hp.theme.focusColor,
                              decoration: TextDecoration.underline)),
                      onTap: () {
                        hp.goBackForeverTo('/mobile_home');
                      })
                ],
              )),
          appBar: AppBar(
              leading: const LeadingWidget(visible: true),
              leadingWidth: 110,
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Property Success',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }
}
