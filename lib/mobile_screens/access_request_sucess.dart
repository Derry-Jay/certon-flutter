import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';

class AccessRequestSuccess extends StatefulWidget {
  final RouteArgument rar;
  const AccessRequestSuccess({Key? key, required this.rar}) : super(key: key);

  @override
  AccessRequestSuccessState createState() => AccessRequestSuccessState();
}

class AccessRequestSuccessState extends StateMVC<AccessRequestSuccess> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Access Request to a Property',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 10),
                    child: Text(
                      'Thank You.',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                const SizedBox(height: 20),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 10),
                    child: Text(
                      '${widget.rar.params['company_name']} will have access to the stored documents for ${widget.rar.params['address']} for ${widget.rar.params['period']} days',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                GestureDetector(
                    child: Container(
                      height: 75,
                      width: 150,
                      padding: const EdgeInsets.only(
                          left: 20, top: 15, bottom: 15),
                      child: Text('Back to Home',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: hp.theme.focusColor)),
                    ),
                    onTap: () {
                      hp.gotoForever('/mobile_home');
                    }),
              ],
            ),
          ),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              leadingWidth: 50,
              leading:  const LeadingWidget(visible: true),
              elevation: 0,
              centerTitle: true,
              key: scaffoldKey,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Approve Request',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }
}
