import '../widgets/mobile/leading_widget.dart';

import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/faq_list_widget.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: hp.width / 25, vertical: hp.height / 50),
              child: Column(children: const [
                Text('Frequently Asked Questions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                FAQsListWidget()
              ])),
               drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
             leading: const LeadingWidget(visible: true),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Help',
                  style: TextStyle(fontWeight: FontWeight.w600))),
          // bottomNavigationBar: const BottomWidget()
          ),
    );
  }
}
