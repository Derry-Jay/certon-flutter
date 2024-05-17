import '../../helpers/helper.dart';
import '../../models/quick_link.dart';
import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final QuickLink link;
  const DrawerItemWidget({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return InkWell(
        onTap: link.action,
        child: Padding(
            padding: EdgeInsets.only(
                left: hp.width / 50, right: hp.width / 40, top: hp.height / 50),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(link.content, style: hp.textTheme.bodyMedium),
                  const Icon(Icons.arrow_forward_ios)
                ])));
  }
}
