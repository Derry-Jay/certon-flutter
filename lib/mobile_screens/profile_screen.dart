import '../models/route_argument.dart';
import '../widgets/custom_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/api.dart';
import '../models/user.dart';
import '../helpers/helper.dart';
import '../models/user_base.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends StateMVC<ProfileScreen> {
  UserBase users = UserBase.emptyValue;
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  int roleID = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCross();
  }

  void apiCross() async {
    final hp = Helper.of(context);
    final prefs = await sharedPrefs;
    roleID = prefs.getInt('RoleID') ?? 0;
    var val = await api.userDetails();

    users.user = val.user;
    users.user.onChange();
    log(val.user.role.roleID);
    log('val.user.role.roleID');
    // currentUser.value.onChange();
    log(val.user.firstName);
    log(currentUser.value.firstName);
    log('currentUser.value.role.roleID');
    hp.signOutIfAnyChanges(val.user.role.roleID);
    setState(() {});
  }

  Widget pageBuilder(BuildContext context, User user, Widget? child) {
    final hp = Helper.of(context);
    makeStatusBarVisibleInAndroid();
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          // key: hp.key,
          bottomNavigationBar: const BottomWidget(),
          body: user.isEmpty
              ? Center(
                  child: CustomLoader(
                      sizeFactor: 10,
                      duration: const Duration(seconds: 10),
                      color: hp.theme.primaryColor,
                      loaderType: LoaderType.fadingCircle))
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: hp.width / 25, vertical: hp.height / 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('My Profile',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: hp.height / 50),
                            child: Text('Name: ${user.userName}',
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal))),
                        Text('Email: ${user.userEmail}',
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal)),
                        Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: hp.height / 50),
                            child: Text('Contact Number: ${user.phoneNo}',
                                textScaleFactor: 1.0,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal))),
                        Text('Address: ${user.address1} , ${user.address2}',
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal)),
                        Visibility(
                            visible: user.role.roleID == 5,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: hp.height / 80),
                                child: const Text('Company Details',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)))),
                        Visibility(
                            visible: user.role.roleID == 5,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: hp.height / 80),
                                child: Text(
                                    'Company Name: ${user.companyName ?? ''}',
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal)))),
                        Visibility(
                            visible: user.role.roleID == 5,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: hp.height / 80),
                                child: Text(
                                    'Company Reg No: ${user.companyNo ?? ''}',
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal)))),
                        Visibility(
                            visible: user.role.roleID == 5,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: hp.height / 80),
                                child: Text(
                                    'Company Tel No: ${user.companyPhone ?? ''}',
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal)))),
                        Visibility(
                            visible: user.role.roleID == 5,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: hp.height / 80),
                                child: Text(
                                    'Sectors: ${user.sectors?.map((e) => e != 0 ? sectors[e - 1] : '').join(', ') ?? ''}',
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal)))),
                        Center(
                            child: GestureDetector(
                          child: const Text(
                            'Edit My Profile',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            hp.goTo('/profile_edit', vcb: () {
                              apiCross();
                            },
                                args: RouteArgument(
                                  params: user,
                                ));
                          },
                        )

                            // HyperLinkText(
                            //     text: 'Edit My Profile',
                            //     onTap: () {
                            //       hp.goTo('/profile_edit');
                            //     })
                            )
                      ])),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              leadingWidth: hp.leadingWidth,
              title: const Text(
                'My Profile',
                textScaleFactor: 1.0,
              ),
              backgroundColor: hp.theme.primaryColor,
              leading: const LeadingWidget(visible: false),
              foregroundColor: hp.theme.scaffoldBackgroundColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageBuilder(context, users.user, const EmptyWidget());
    // return ValueListenableBuilder<User>(
    //     builder: pageBuilder,
    //     valueListenable: currentUser,
    //     child: const EmptyWidget());
  }
}
