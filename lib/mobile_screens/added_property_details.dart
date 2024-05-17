import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/bottom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/leading_widget.dart';
import '../controllers/property_and_document_controller.dart';

class AddedPropertyDetails extends StatefulWidget {
  final RouteArgument rar;
  const AddedPropertyDetails({Key? key, required this.rar}) : super(key: key);

  @override
  AddedPropertyDetailsState createState() => AddedPropertyDetailsState();
}

class AddedPropertyDetailsState extends StateMVC<AddedPropertyDetails> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);

  AddedPropertyDetailsState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
        bottomNavigationBar: const BottomWidget(),
        appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, kToolbarHeight),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(0.0)),
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
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Property ID: ${widget.rar.tag}',
                          style: const TextStyle(color: Colors.white))
                    ],
                  )
                ],
              )),
            )),
        leadingWidth: hp.leadingWidth,
        leading: const LeadingWidget(visible: false),
        elevation: 0,
        centerTitle: true,
        backgroundColor: hp.theme.primaryColor,
        foregroundColor: hp.theme.scaffoldBackgroundColor,
        title: const Text('Scan Code',
            style: TextStyle(fontWeight: FontWeight.w600))),
        body: SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'This property is in CertOn as:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'This property is in CertOn as:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'This property is in CertOn as:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  'View Property',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: hp.theme.focusColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {},
              )
            ],
          ),
        )
      ],
        )),
      ),
    );
  }
}
