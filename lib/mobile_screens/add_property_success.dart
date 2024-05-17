import '../helpers/helper.dart';
import 'package:intl/intl.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/property_and_document_controller.dart';

class AddPropertySuccess extends StatefulWidget {
  final RouteArgument rar;
  const AddPropertySuccess({Key? key, required this.rar}) : super(key: key);

  @override
  AddPropertySuccessState createState() => AddPropertySuccessState();
}

class AddPropertySuccessState extends StateMVC<AddPropertySuccess> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  final now = DateFormat('hh:mm:ss').format(DateTime.now());

  AddPropertySuccessState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }
  Widget leadingBuilder(BuildContext context, BoxConstraints constraints) {
    final hp = Helper.of(context);
    return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: IconButton(
                  constraints: constraints,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.zero,
                  onPressed: hp.sct.hasDrawer ? hp.sct.openDrawer : doNothing,
                  icon: const Icon(Icons.dehaze)))
        ]));
  }

  @override
  Widget build(BuildContext context) {
     var outputDate = '';
    if (widget.rar.params['correctDate'] != null) {
      DateTime tempDate =
          DateFormat('yyyy-MM-dd').parse(widget.rar.params['correctDate']);
      log(tempDate);
      var outputFormat = DateFormat('dd/MM/yyyy');
      outputDate = outputFormat.format(tempDate);
      //final String formatted = formatter.format(widget.rar.params['correctDate']);
    }
    // TODO: implement build
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
        drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
        bottomNavigationBar: const BottomWidget(),
        appBar: AppBar(
        leadingWidth: 50,
        leading: LayoutBuilder(builder: leadingBuilder),
        elevation: 0,
        centerTitle: true,
        backgroundColor: hp.theme.primaryColor,
        foregroundColor: hp.theme.scaffoldBackgroundColor,
        title: const Text('Property Success',
            style: TextStyle(fontWeight: FontWeight.w600))),
        body: SingleChildScrollView(
        child: Padding(
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
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
              'You now have successfully added the new Property to your account${parseBool(widget.rar.id.toString()) ? '.' : ' of'}',
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal)),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.rar.params['address'],
            style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Type: ${widget.rar.params['type']}',
            style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'QR Code Installation Date: $outputDate $now',
            style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
              'The Property will now appear in your ${parseBool(widget.rar.id.toString()) ? 'My' : 'Other'} Properties.${parseBool(widget.rar.id.toString()) ? '' : ' You have been Granted Access to this Property for 1 Month'}',
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.normal)),
          const SizedBox(
            height: 20,
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
      ),
        )),
      ),
    );
  }
}
