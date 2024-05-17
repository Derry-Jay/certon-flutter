import 'drawer_item_widget.dart';
import '../../helpers/helper.dart';
import '../../models/quick_link.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return Container(
      color: hp.theme.primaryColor,
      child: SafeArea(
        child: Container(
          width: hp.drawerWidth,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                  width: hp.drawerWidth,
                  height: hp.appbarHeight,
                  color: hp.theme.primaryColor,
                  padding: EdgeInsets.symmetric(
                      vertical: hp.height / (hp.isMobile ? 60 : 80)),
                  child: const Text('Menu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500))),
              for (QuickLink link in hp.linkList) DrawerItemWidget(link: link)
            ],
          ),
        ),
      ),
    );
  }
}
