import '../backend/api.dart';
import '../models/user.dart';
import '../helpers/helper.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/mobile/properties_table_widget.dart';

class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({Key? key}) : super(key: key);

  Widget pageBuilder(BuildContext context, User user, Widget? child) {
    final hp = Helper.of(context);
    return SafeArea(
        top: isAndroid,
        bottom: isAndroid,
        child: MediaQuery(
          data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .copyWith(boldText: false, textScaleFactor: 1.0),
          child: Scaffold(
              // key: hp.key,
              drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
              body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: hp.width / 25, vertical: hp.height / 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome ${user.userName}',
                        textScaleFactor: 1.0,
                            style: hp.textTheme.headline6),
                        const SizedBox(height: 15),
                        Text('My Properties ',
                            textScaleFactor: 1.0, style: hp.textTheme.headline6),
                        const SizedBox(height: 15),
                        const PropertiesTableWidget()
                      ])),
              bottomNavigationBar: const BottomWidget(),
              appBar: AppBar(
                  leadingWidth: hp.leadingWidth,
                  leading: const LeadingWidget(visible: false),
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: hp.theme.primaryColor,
                  foregroundColor: hp.theme.scaffoldBackgroundColor,
                  title: const Text('My Properties',
                      textScaleFactor: 1.0,
                      style: TextStyle(fontWeight: FontWeight.w600)))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    hp.getConnectStatus();
    return ValueListenableBuilder<User>(
        builder: pageBuilder,
        valueListenable: currentUser,
        child: const EmptyWidget());
  }
}
