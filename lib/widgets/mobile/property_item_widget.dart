import 'hyperlink_text.dart';
import '../../backend/api.dart';
import '../../helpers/helper.dart';
import '../../models/property.dart';
import 'properties_list_widget.dart';
import 'package:flutter/material.dart';
import '../../models/route_argument.dart';
import '../../mobile_screens/contractor_properties_screen.dart';

class PropertyItemWidget extends StatelessWidget {
  final Property property;
  const PropertyItemWidget({Key? key, required this.property})
      : super(key: key);

  ContractorPropertiesScreenState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<ContractorPropertiesScreenState>();

  PropertiesListWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<PropertiesListWidgetState>();

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    final pls = of(context);
    final cps = maybeOf(context);
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.only(
                left: hp.width / 20,
                top: hp.height / 80,
                bottom: hp.height / 50),
            child: Text('Address: ${property.address}')),
        Padding(
            padding: EdgeInsets.only(left: hp.width / 20),
            child: Text('Added On: ${property.date}')),
        HyperLinkText(
            text: 'View Property',
            onTap: () {
              props.value = property;
              property.onChange();
              hp.goTo('/property_details', vcb: () {
                if (pls != null) {
                  pls.didUpdateWidget(pls.widget);
                }
                if (cps != null) {
                  cps.didUpdateWidget(cps.widget);
                }
              }, args: RouteArgument(params: property, content: 'false'));
            })
      ]),
    );
  }
}
