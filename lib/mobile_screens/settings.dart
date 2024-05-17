import '../helpers/helper.dart';
import '../models/user_base.dart';
import '../widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:settings_ui/settings_ui.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends StateMVC<SettingScreen> {
  bool mailNotification = false;
  bool pushNotification = false;
  Helper get hp => Helper.of(context);
  UserBase userdetails = UserBase.emptyValue;
  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    hp.getConnectStatus();
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          body: SettingsList(
            sections: [
              SettingsSection(
                title: const Text('Notifications'),
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      mailNotification = value;
                      mailNotifications(context);
                    },
                    initialValue: mailNotification,
                    leading: const Icon(Icons.mail),
                    title: const Text('Mail Notifications'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      pushNotification = value;
                      pushNotifications(context);
                    },
                    initialValue: pushNotification,
                    leading: const Icon(Icons.notifications_none),
                    title: const Text('Push Notifications'),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: const BottomWidget(),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              leadingWidth: hp.leadingWidth,
              title: const Text(
                'Settings',
                textScaleFactor: 1.0,
              ),
              backgroundColor: hp.theme.primaryColor,
              leading: const LeadingWidget(visible: false),
              foregroundColor: hp.theme.scaffoldBackgroundColor)),
    );
  }

  void mailNotifications(BuildContext context) async {
    Loader.show(context);
    final rp = await api.notificationCheckBox(1, mailNotification ? 1 : 0);
    log(rp.message);
    Loader.hide();
    userDetails();
  }

  void pushNotifications(BuildContext context) async {
    Loader.show(context);
    final rp = await api.notificationCheckBox(2, pushNotification ? 1 : 0);
    log(rp.message);
    Future.delayed(Duration.zero);
    userdetails = await api.userDetails();
    log(userdetails.user);
    mailNotification = (userdetails.user.emailnotification == 1) ? true : false;
    pushNotification = (userdetails.user.pushnotification == 1) ? true : false;
    Loader.hide();
    setState(() {});
  }

  void userDetails() async {
    userdetails = await api.userDetails();
    log(userdetails.user);
    mailNotification = (userdetails.user.emailnotification == 1) ? true : false;
    pushNotification = (userdetails.user.pushnotification == 1) ? true : false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails();
  }
}
