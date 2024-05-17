import '../../helpers/helper.dart';
import '../../models/benefit_grid_item.dart';
import 'package:flutter/material.dart';

class BenefitGridItemWidget extends StatelessWidget {
  final BenefitGridItem item;
  const BenefitGridItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return Card(
        margin: EdgeInsets.only(bottom: hp.height / 10),
        elevation: 0,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(item.icon, size: hp.radius / 32),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(item.heading,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                SelectableText(item.content)
              ])
        ]));
  }
}
