import '../../models/benefit_grid_item.dart';
import '../../widgets/web/benefit_grid_item_widget.dart';
import 'package:flutter/material.dart';

class BenefitGridWidget extends StatelessWidget {
  final List<BenefitGridItem> items;
  const BenefitGridWidget({Key? key, required this.items}) : super(key: key);

  Widget getItem(BuildContext context, int index) {
    return BenefitGridItemWidget(item: items[index]);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 6.4),
        itemBuilder: getItem);
  }
}
