import '../custom_loader.dart';
import '../../helpers/helper.dart';
import 'property_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/property_and_document_controller.dart';

class PropertiesListWidget extends StatefulWidget {
  const PropertiesListWidget({Key? key}) : super(key: key);

  @override
  PropertiesListWidgetState createState() => PropertiesListWidgetState();
}

class PropertiesListWidgetState extends StateMVC<PropertiesListWidget> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  PropertiesListWidgetState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  Widget getItem(BuildContext context, int index) {
    return PropertyItemWidget(property: con.properties![index]);
  }

  @override
  Widget build(BuildContext context) {
    return con.properties == null
        ? Center(
            heightFactor: hp.height / 160,
            child: CustomLoader(
                sizeFactor: 10,
                duration: const Duration(seconds: 10),
                color: hp.theme.primaryColor,
                loaderType: LoaderType.fadingCircle))
        : (con.properties!.isEmpty
            ? Center(
                heightFactor: hp.height / 40,
                child:
                    Text('No Properties Found', style: hp.textTheme.headline6))
            : ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: getItem,
                itemCount: con.properties!.length));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.waitForProperties();
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    con.waitForProperties();
  }
}
