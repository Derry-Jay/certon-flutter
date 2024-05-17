import '../backend/api.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/bottom_widget.dart';

class OwnPropertyScanScreen extends StatelessWidget {
  final RouteArgument rar;
  const OwnPropertyScanScreen({Key? key, required this.rar}) : super(key: key);

  Widget pageBuilder(BuildContext context, Property prop, Widget? child) {
    final hp = Helper.of(context);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          bottomNavigationBar: child,
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: hp.width / 25, vertical: hp.height / 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 25,
                    ),
                    Text('This property is in CertOn as:',
                        style: hp.textTheme.bodyText2),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: hp.height / 40),
                        child: Text(prop.fullAddress,
                            style: hp.textTheme.bodyText2)),
    
                    Text(
                        !parseBool(rar.id.toString())
                            ? 'This property is owned by you.'
                            : 'This property is owned by another CertOn user. Request Access to view the documents from the owner',
                        style: hp.textTheme.bodyText2),
                    const SizedBox(
                      height: 25,
                    ),
                    // log(index);
    
                    !parseBool(rar.id.toString())
                        ? GestureDetector(
                            child: Text(
                              'View Property',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: hp.theme.focusColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            onTap: () {
                              hp.goTo('/property_details',
                                  args: RouteArgument(
                                      id: 0, params: prop, content: 'true'));
                            },
                          )
                        : GestureDetector(
                            child: SizedBox(
                              width: 150,
                              height: 70,
                              child: Text(
                                'Request Access',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: hp.theme.focusColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            onTap: () async {
                              log('afljaksbdjkfsbakfjbas');
                              log(prop.address);
                              log(prop.fullAddress);
                              log(currentUser.value.firstName);
                              log(currentUser.value.lastName);
                              log(currentUser.value.companyName);
                              hp.goTo('/request_access_scanpage');
    
                              // if (prop.userID != currentUser.value.userID &&
                              //     currentUser.value.isContractor) {
                              //   final v = await requestAccess(prop);
                              //   if (await revealToast(v.message) && v.success) {}
                              //   hp.gotoForever('/mobile_home');
                              // } else  {
    
                              // }
                              // else if (await hp.revealDialogBox(
                              //   ['Ok'],
                              //   [
                              //     () {
                              //       hp.gotoForever('/mobile_home');
                              //     }
                              //   ],
                              //   type: AlertType.cupertino,
                              //   action:
                              //       'You cannot request the property of another Owner!!!!',
                              // )) {
                              // } else {
                              //   hp.gotoForever('/mobile_home');
                              // }
                            },
                          ),
    
                    // HyperLinkText(
                    //     text: 'View Property',
                    //     onTap: () {
                    //       hp.goTo('/property_details');
                    //     })
                  ])),
          appBar: AppBar(
              bottom: PreferredSize(
                  preferredSize: const Size(double.infinity, kToolbarHeight),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: hp.theme.hintColor,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0),
                          BoxShadow(
                              color: hp.theme.hintColor,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0),
                        ],
                        gradient: LinearGradient(
                            colors: [hp.theme.hintColor, hp.theme.hintColor],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp)),
                    child: Center(
                        child: Row(
                      children: [
                        Icon(Icons.qr_code_scanner_outlined,
                            color: hp.theme.scaffoldBackgroundColor,
                            size: hp.radius / 20),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('CODE SCANNED',
                                style: TextStyle(color: Colors.lightGreenAccent)),
                            const SizedBox(height: 5),
                            Text('Property ID: ${rar.tag}',
                                style: const TextStyle(color: Colors.white))
                          ],
                        )
                      ],
                    )),
                  )),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Scan Code',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder<Property>(
        valueListenable: props,
        builder: pageBuilder,
        child: const BottomWidget());
  }
}
