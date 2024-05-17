import '../models/user_base.dart';
import '../widgets/custom_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/user.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/mobile/documents_list_widget.dart';

class AllDocumentsScreen extends StatefulWidget {
  const AllDocumentsScreen({Key? key}) : super(key: key);

  @override
  AllDocumentsScreenState createState() => AllDocumentsScreenState();
}

class AllDocumentsScreenState extends StateMVC<AllDocumentsScreen> {
  UserBase users = UserBase.emptyValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCross();
  }

  void apiCross() async {
    var val = await api.userDetails();
    users.user = val.user;
    users.user.onChange();
    setState(() {});
  }

  Widget pageBuilder(BuildContext context, User user, Widget? child) {
    final hp = Helper.of(context);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          bottomNavigationBar: child,
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
                      children: [
                        Text('Welcome ${user.userName}',
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text('My Document Details ',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        const SizedBox(
                          height: 15,
                        ),
                        const DocumentsListWidget()
                      ])),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              leadingWidth: hp.leadingWidth,
              leading: const LeadingWidget(visible: false),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('My Documents',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pageBuilder(context, users.user, const BottomWidget());

    // ValueListenableBuilder<User>(
    //     valueListenable: currentUser,
    //     builder: pageBuilder,
    //     child: const BottomWidget());
  }
}
