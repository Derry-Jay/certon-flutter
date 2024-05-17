import 'faq_item_widget.dart';
import '../custom_loader.dart';
import '../../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/misc_controller.dart';

class FAQsListWidget extends StatefulWidget {
  const FAQsListWidget({Key? key}) : super(key: key);

  @override
  FAQsListWidgetState createState() => FAQsListWidgetState();
}

class FAQsListWidgetState extends StateMVC<FAQsListWidget> {
  late OtherController con;
  Helper get hp => Helper.of(context);
  FAQsListWidgetState() : super(OtherController()) {
    con = controller as OtherController;
  }

  Widget getItem(BuildContext context, int index) {
    return FAQItemWidget(faq: con.faqs![index], index: index);
  }

  @override
  Widget build(BuildContext context) {
    return con.faqs == null
        ? Center(
            heightFactor: hp.height / 160,
            child: CustomLoader(
                duration: const Duration(seconds: 10),
                color: hp.theme.primaryColor,
                loaderType: LoaderType.fadingCircle))
        : (con.faqs!.isEmpty
            ? Center(
                child: Text('No FAQs Found', style: hp.textTheme.bodyText2))
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                 padding: EdgeInsets.only(top: hp.height / 50),
                itemBuilder: getItem,
                itemCount: con.faqs!.length,
                shrinkWrap: true));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.waitForFAQs();
  }
}
