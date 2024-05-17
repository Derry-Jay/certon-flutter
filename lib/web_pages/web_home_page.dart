import '../helpers/helper.dart';
import '../models/table_data.dart';
import '../web_pages/login_page.dart';
import '../widgets/empty_widget.dart';
import '../widgets/home_page_widget.dart';
import '../widgets/web/bottom_widget.dart';
import '../widgets/web/notification_widget.dart';
import '../widgets/web/paginated_table_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class WebHomePage extends StatefulWidget {
  const WebHomePage({Key? key}) : super(key: key);

  @override
  State<WebHomePage> createState() => WebHomePageState();
}

class WebHomePageState extends State<WebHomePage> {
  int? index;
  int counter = 34, perPage = 5;
  double elevation = 0.0;
  bool elevateField = false, showFAQ = false, editProfileMode = true;
  List<String> actions = ['Home', 'My Profile', 'Help', 'Logout', ''],
      buttons = [
        'My Properties',
        'My Documents',
        'Edit Details',
        'Notifications',
        'Add a Document'
      ];
  List<bool> actionTexts = [false, false, false, false],
      buttonLayouts = [false, false, false, false, false];
  TextEditingController tc = TextEditingController(),
      fnc = TextEditingController(),
      lnc = TextEditingController(),
      emc = TextEditingController(),
      pwc = TextEditingController(),
      vpwc = TextEditingController(),
      phc = TextEditingController(),
      ac1 = TextEditingController(),
      ac2 = TextEditingController(),
      twc = TextEditingController(),
      cc1 = TextEditingController(),
      cc2 = TextEditingController(),
      pcc = TextEditingController(),
      vcc = TextEditingController();
  List<int> perPageValues = [5, 10, 20];
  Helper get hp => Helper.of(context);

  Widget mapButton(String val) => Container(
      margin: buttons.indexOf(val) == 0
          ? EdgeInsets.only(right: hp.width / 512)
          : (buttons.indexOf(val) == (buttons.length - 1)
              ? EdgeInsets.only(left: hp.width / 512)
              : EdgeInsets.symmetric(horizontal: hp.width / 512)),
      child: TextButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(
                  buttonLayouts[buttons.indexOf(val)] ? 2.0 : 1.0),
              // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              //     EdgeInsets.symmetric(
              //         vertical: hp.height / 40, horizontal: hp.width / 128)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  index != null && index == buttons.indexOf(val)
                      ? Colors.grey.shade400
                      : Colors.grey.shade200),
              foregroundColor: MaterialStateProperty.all<Color>(
                  hp.theme.secondaryHeaderColor)),
          onHover: (flag) {
            setState(() {
              buttonLayouts[buttons.indexOf(val)] = flag;
            });
          },
          onFocusChange: (flag) {
            setState(() {
              buttonLayouts[buttons.indexOf(val)] = flag;
            });
          },
          onPressed: () {
            log(index);
            setState(() {
              index = buttons.indexOf(val);
              if (!editProfileMode) {
                editProfileMode = index == 2;
              }
            });
          },
          child: Text(val, style: hp.theme.textTheme.button)));

  Widget mapAction(String val) => val.isEmpty
      ? Padding(
          padding: EdgeInsets.only(right: hp.width / 80),
          child: Row(children: [
            Container(
                height: hp.height / 12.8,
                padding: EdgeInsets.only(top: hp.height / 64),
                width: hp.width / 4,
                child: Material(
                    elevation: elevateField ? 2.5 : 0.0,
                    shadowColor: Colors.blue,
                    child: TextField(
                        // onTap: () {
                        //   setState(() {
                        //     elevateField = !elevateField;
                        //   });
                        // },
                        controller: tc,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            hintText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(hp.radius / 200))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(hp.radius / 200)),
                                borderSide:
                                    const BorderSide(color: Colors.blue)))))),
            Container(
                margin: EdgeInsets.only(top: hp.height / 64),
                padding: EdgeInsets.only(
                    left: hp.radius / 200,
                    top: hp.radius / 200,
                    bottom: hp.radius / 200,
                    right: hp.width / 200),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(hp.radius / 200)),
                    border: Border.all(color: Colors.grey)),
                child: Icon(Icons.search, color: hp.theme.secondaryHeaderColor))
          ]))
      : MouseRegion(
          cursor: MouseCursor.defer,
          onEnter: (PointerEnterEvent event) {
            log(event);
            // tc.text = "Width: " +
            //     hp.width.toString() +
            //     " Height: " +
            //     hp.height.toString();
            setState(() {
              actionTexts[actions.indexOf(val)] =
                  !actionTexts[actions.indexOf(val)];
            });
          },
          onExit: (PointerExitEvent event) {
            log(event);
            // tc.text = "";
            setState(() {
              actionTexts[actions.indexOf(val)] =
                  !actionTexts[actions.indexOf(val)];
            });
          },
          child: GestureDetector(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: hp.height / 32, right: hp.width / 100),
                  child: Text(val,
                      style: TextStyle(
                          color: actionTexts[actions.indexOf(val)]
                              ? Colors.grey
                              : Colors.black))),
              onTap: () async {
                if (actions.indexOf(val) == 3) {
                  final p = await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false);
                  log(p);
                } else {
                  setState(() {
                    index = null;
                    showFAQ = actions.indexOf(val) == 2;
                  });
                }
              }));

  DropdownMenuItem<int> mapValues(int e) =>
      DropdownMenuItem(value: e, child: Text(e.toString()));

  void onChanged(int? i) {
    setState(() {
      perPage = i ?? 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: const BottomWidget(
              heightFactor: 20,
            ),
            appBar: AppBar(
                leading: Padding(
                    padding: EdgeInsets.only(left: hp.width / 100),
                    child: DropdownButton(
                        value: perPage,
                        items: perPageValues.map(mapValues).toList(),
                        onChanged: onChanged)),
                actions: actions.map(mapAction).toList(),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0),
            body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hp.width / 12.8),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      const HomePageWidget(),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: hp.height / (index == 3 ? 20 : 100)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: buttons.map(mapButton).toList())),
                      index == null
                          ? Padding(
                              padding: EdgeInsets.only(top: hp.height / 40),
                              child: SelectableText(showFAQ
                                  ? 'iOS and Android'
                                  : 'Welcome to your CertOn homepage'))
                          : (index == buttons.indexOf('Notifications')
                              ? const NotificationWidget()
                              : (index == buttons.indexOf('Edit Details')
                                  ? Visibility(
                                      visible: editProfileMode,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: hp.height / 40),
                                          child: SelectableText('Account Details',
                                              style: hp
                                                  .theme.textTheme.headline6)))
                                  : (index == buttons.indexOf('My Properties') ||
                                          index ==
                                              buttons.indexOf('My Documents')
                                      ? PaginatedTableWidget(
                                          tableData: TableData.fromIterable(
                                              GlobalConfiguration().getValue(
                                                  'table_data${index == buttons.indexOf("My Documents") ? "_2" : ""}'),
                                              TableType.document,
                                              context: context),
                                          tableTitle: '')
                                      : const EmptyWidget()))),
                      index == null || index == buttons.indexOf('Edit Details')
                          ? Padding(
                              padding: EdgeInsets.only(top: hp.height / 40),
                              child: index == null
                                  ? SelectableText(
                                      showFAQ
                                          ? '1.How do I download CertOn App'
                                          : 'You have 23 Properties stored on the system',
                                      style: showFAQ
                                          ? hp.theme.textTheme.headline6
                                          : hp.theme.textTheme.bodyText1)
                                  : Visibility(
                                      visible: editProfileMode,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                                child: SelectableText(
                                                    'First Name* ',
                                                    style: hp.theme.textTheme
                                                        .headline6)),
                                            Expanded(
                                                child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                    controller: fnc)),
                                            const Spacer(),
                                            Expanded(
                                                child: SelectableText(
                                                    'Last Name* ',
                                                    style: hp.theme.textTheme
                                                        .headline6)),
                                            Expanded(
                                                child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                    controller: lnc))
                                          ])))
                          : const EmptyWidget(),
                      index == null || index == buttons.indexOf('Edit Details')
                          ? Padding(
                              padding: EdgeInsets.only(top: hp.height / 40),
                              child: index == null
                                  ? SelectableText(showFAQ
                                      ? 'Visit the Mobile App page on our website - https://www.certon.co.uk/mobile-app/ and there are links to our App in the Apple and Google Play stores there'
                                      : 'You have 4 Document spaces available in your account')
                                  : Visibility(
                                      visible: editProfileMode,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                                child: SelectableText('Email* ',
                                                    style: hp.theme.textTheme
                                                        .headline6)),
                                            SizedBox(width: hp.width / 8.192),
                                            Expanded(
                                                child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                    controller: emc))
                                          ])))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Visibility(
                              visible: editProfileMode,
                              child: Padding(
                                  padding: EdgeInsets.only(top: hp.height / 40),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: SelectableText('Password ',
                                                style: hp.theme.textTheme
                                                    .headline6)),
                                        Expanded(
                                            child: TextFormField(
                                                decoration: const InputDecoration(
                                                    border:
                                                        OutlineInputBorder()),
                                                controller: pwc)),
                                        const Spacer(),
                                        Expanded(
                                            child: SelectableText(
                                                'Verify Password ',
                                                style: hp.theme.textTheme
                                                    .headline6)),
                                        Expanded(
                                            child: TextFormField(
                                                decoration: const InputDecoration(
                                                    border:
                                                        OutlineInputBorder()),
                                                controller: vpwc))
                                      ])))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Padding(
                              padding: EdgeInsets.only(top: hp.height / 40),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Visibility(
                                        visible: editProfileMode,
                                        child: Flexible(
                                            child: SelectableText(
                                                'Contact Tel* ',
                                                style: hp.theme.textTheme
                                                    .headline6))),
                                    Visibility(
                                        visible: editProfileMode,
                                        child: SizedBox(
                                            width: hp.width /
                                                11.52921504606846976)),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            controller: emc)),
                                    Visibility(
                                        visible: !editProfileMode,
                                        child: SizedBox(
                                            width: hp.width /
                                                11.52921504606846976)),
                                    Visibility(
                                        visible: !editProfileMode,
                                        child: OutlinedButton(
                                            child: Text('Find Your Address',
                                                style:
                                                    hp.theme.textTheme.button),
                                            onPressed: () {}))
                                  ]))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Visibility(
                              visible: editProfileMode,
                              child: Padding(
                                  padding: EdgeInsets.only(top: hp.height / 40),
                                  child: SelectableText('Contact Address',
                                      style: hp.theme.textTheme.headline6)))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Padding(
                              padding: EdgeInsets.only(top: hp.height / 40),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: SelectableText('Address 1* ',
                                            style:
                                                hp.theme.textTheme.headline6)),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            controller: pwc)),
                                    const Spacer(),
                                    Expanded(
                                        child: SelectableText('Address 2 ',
                                            style:
                                                hp.theme.textTheme.headline6)),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            controller: vpwc))
                                  ]))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Padding(
                              padding: EdgeInsets.only(top: hp.height / 40),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: SelectableText('Town* ',
                                            style:
                                                hp.theme.textTheme.headline6)),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            controller: pwc)),
                                    const Spacer(),
                                    Expanded(
                                        child: SelectableText('County ',
                                            style:
                                                hp.theme.textTheme.headline6)),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            controller: vpwc))
                                  ]))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Padding(
                              padding: EdgeInsets.only(top: hp.height / 40),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: SelectableText('Postcode* ',
                                            style:
                                                hp.theme.textTheme.headline6)),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            controller: pcc)),
                                    const Spacer(),
                                    Expanded(
                                        child: SelectableText('Country* ',
                                            style:
                                                hp.theme.textTheme.headline6)),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            controller: cc1))
                                  ]))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Visibility(
                              visible: editProfileMode,
                              child: Padding(
                                  padding: EdgeInsets.only(top: hp.height / 40),
                                  child: SelectableText('Voucher Code',
                                      style: hp.theme.textTheme.headline6)))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details')
                          ? Visibility(
                              child: Padding(
                                  padding: EdgeInsets.only(top: hp.height / 40),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: SelectableText('Code ',
                                                style: hp.theme.textTheme
                                                    .headline6)),
                                        SizedBox(width: hp.width / 7.8125),
                                        Expanded(
                                            child: TextFormField(
                                                decoration: const InputDecoration(
                                                    border:
                                                        OutlineInputBorder()),
                                                controller: cc2))
                                      ])))
                          : const EmptyWidget(),
                      index == buttons.indexOf('Edit Details') ||
                              index == buttons.indexOf('My Properties')
                          ? Center(
                              heightFactor: hp.height / 160,
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (index !=
                                        buttons.indexOf('Edit Details')) {
                                      setState(() {
                                        index = buttons.indexOf('Edit Details');
                                        editProfileMode = !editProfileMode;
                                      });
                                    }
                                  },
                                  child: Text(
                                      index == buttons.indexOf('Edit Details')
                                          ? 'Save'
                                          : 'Add Property',
                                      style: hp.theme.textTheme.button)))
                          : const EmptyWidget()
                    ])))));
  }
}
