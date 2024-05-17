import '../../helpers/helper.dart';
import '../../models/table_data.dart';
import 'package:flutter/material.dart';
import '../../widgets/web/table_widget.dart';
import 'package:global_configuration/global_configuration.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  NotificationWidgetState createState() => NotificationWidgetState();
}

class NotificationWidgetState extends State<NotificationWidget> {
  List<String> buttons = ['Un', ''];
  int index = 1;
  Helper get hp => Helper.of(context);

  Widget mapButton(String e) => Padding(
      padding: buttons.first == e
          ? EdgeInsets.only(bottom: hp.height / 80)
          : (buttons.last == e
              ? EdgeInsets.only(top: hp.height / 80)
              : EdgeInsets.zero),
      child: TextButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(1.0),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                      horizontal:
                          hp.width / (('${e}Read Messages').length * 10))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade400),
              foregroundColor: MaterialStateProperty.all<Color>(
                  hp.theme.secondaryHeaderColor)),
          onHover: (flag) {
            // setState(() {
            //   buttonLayouts[buttons.indexOf(val)] = flag;
            // });
          },
          onFocusChange: (flag) {
            // setState(() {
            //   buttonLayouts[buttons.indexOf(val)] = flag;
            // });
          },
          onPressed: () {
            // log(index);
            setState(() {
              index = buttons.indexOf(e);
            });
          },
          child: Text('${e}Read Messages', style: hp.theme.textTheme.button)));

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: buttons.map<Widget>(mapButton).toList())),
      SizedBox(width: hp.width / 80),
      Expanded(
          child: NormalTableWidget(
              tableData: TableData.fromString(
                  GlobalConfiguration().getValue<String>('table_data_1'),
                  TableType.notification,
                  context: context),
              tableTitle: '${buttons[index]}Read Messages'))
    ]);
  }
}
