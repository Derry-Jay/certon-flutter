import 'package:mvc_pattern/mvc_pattern.dart';

import '../../backend/api.dart';
import '../../controllers/property_and_document_controller.dart';
import '../../helpers/helper.dart';
import '../../models/property.dart';
import 'package:flutter/material.dart';
import '../../models/route_argument.dart';

class OwnPropertyWidget extends StatefulWidget {
  final RouteArgument rar;
  const OwnPropertyWidget({Key? key, required this.rar}) : super(key: key);

  @override
  OwnPropertyWidgetState createState() => OwnPropertyWidgetState();
}

class OwnPropertyWidgetState extends StateMVC<OwnPropertyWidget> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);

  OwnPropertyWidgetState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  Widget pageBuilder(BuildContext context, Property prop, Widget? child) {
    final hp = Helper.of(context);
    log(widget.rar);
    log(widget.rar.id);
    log(widget.rar.tag);
    log(parseBool(widget.rar.id.toString()) || parseBool(widget.rar.tag));
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: hp.height /
              (hp.pageOrientation == Orientation.landscape ? 6.5536 : 13.1072),
          width: hp.width,
          decoration: BoxDecoration(
              color: hp.theme.hintColor,
              borderRadius: const BorderRadius.all(Radius.zero)),
          child: Row(
            children: [
             
               Flexible(
                child: Icon(Icons.qr_code_scanner_outlined,
                    color: hp.theme.scaffoldBackgroundColor,
                    size: hp.radius / 20),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('CODE SCANNED',
                        style: TextStyle(color: Colors.lightGreenAccent)),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Text('Property ID:  ${widget.rar.params['scancode'] ?? widget.rar.content}',
                        softWrap: false,
                        // maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(color: Colors.white))
                  ],
                ),
              )
            ],
          )),
      Padding(
          padding: EdgeInsets.only(left: hp.width / 32, top: hp.height / 50),
          child: Text('This property is in CertOn as:',
              style: hp.textTheme.bodyText1)),
      Padding(
          padding: EdgeInsets.only(left: hp.width / 32, top: hp.height / 80),
          child: Text(prop.fullAddress, style: hp.textTheme.bodyText1)),
      Padding(
          padding: EdgeInsets.only(
              left: hp.width / 32, top: hp.height / 80, bottom: hp.height / 32),
          child: Text(
              !parseBool(widget.rar.id.toString())
                  ? 'This property is owned by you.'
                  : (parseBool(widget.rar.tag)
                      ? 'You have Access to this property.'
                      : currentUser.value.isLandlord
                          ? 'This property is owned by another CertOn user.'
                          : 'This property is owned by another CertOn user. Request Access to view the documents from the owner'),
              style: hp.textTheme.bodyText1)),
      Padding(
          padding: EdgeInsets.only(left: hp.width / 32),
          child: !parseBool(widget.rar.id.toString()) ||
                  parseBool(widget.rar.tag)
              ? GestureDetector(
                  child: Text(
                    'View Property',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: hp.theme.focusColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    log('jeswin');
                    // prop.propertytypename = '';
                    log(prop);
                    hp.goTo('/property_details', vcb: () {
                      didUpdateWidget(widget);
                    },
                        args: RouteArgument(
                            id: currentUser.value.userID == prop.userID ? 0 : 1,
                            params: prop,
                            content: 'true'));
                  },
                )
              : currentUser.value.isLandlord
                  ? null
                  : GestureDetector(
                      child: Text(
                        'Request Access',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: hp.theme.focusColor,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      onTap: () async {
                        log('kjasgiseonfweonfweij');
                        log(prop.address);
                        log(prop.fullAddress);
                        log(currentUser.value.firstName);
                        log(currentUser.value.lastName);
                        log(currentUser.value.companyName);

                        var body = {
                          'address': prop.fullAddress,
                          'firstname': currentUser.value.firstName,
                          'lastname': currentUser.value.lastName,
                          'comp': currentUser.value.companyName,
                          'prop': prop
                        };
                        hp.goTo('/request_access_scanpage',
                            args: RouteArgument(params: body));

                       
                      },
                    )),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Property>(
        valueListenable: props, builder: pageBuilder);
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    con.waitForProperties();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.waitForProperties();
  }
}
