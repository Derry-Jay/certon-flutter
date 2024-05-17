import 'dart:math';
import '../widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../backend/api.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/route_argument.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/mobile/property_item_widget.dart';
import '../controllers/property_and_document_controller.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ContractorPropertiesScreen extends StatefulWidget {
  const ContractorPropertiesScreen({Key? key}) : super(key: key);

  @override
  ContractorPropertiesScreenState createState() =>
      ContractorPropertiesScreenState();
}

class ContractorPropertiesScreenState
    extends StateMVC<ContractorPropertiesScreen> with TickerProviderStateMixin {
  late PropertyAndDocumentController con;
  late TabController cont;
  bool selection = false;
  // final prefs = SharedPreferences.getInstance();
  Helper get hp => Helper.of(context);
  // RefreshController refreshController =
  //     RefreshController(initialRefresh: false);
  String dropdownvalue = '1 Day';
  List<String> selectedItemValue = <String>[];

  var accessTime = ['1 Day', '1 Week', '1 Month', 'Forever'];

  TabBar get _tabBar => TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          labelStyle: const TextStyle(),
          unselectedLabelStyle:
              const TextStyle(decoration: TextDecoration.none),
          tabs: [
            Tab(
                child: Text(
              'My Properties',
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: hp.dimensions.orientation == Orientation.portrait
                    ? hp.isMobile
                        ? hp.height > 700
                            ? 17
                            : 15
                        : 17
                    : 17,
                fontWeight: FontWeight.w500,
              ),
            )),
            Tab(
                child: Text(
              'Other Properties',
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontSize: hp.dimensions.orientation == Orientation.portrait
                      ? hp.isMobile
                          ? hp.height > 700
                              ? 17
                              : 15
                          : 17
                      : 17,
                  fontWeight: FontWeight.w500),
            ))
          ]
          // ,controller: cont
          );

  ContractorPropertiesScreenState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  Widget getOwnedItem(BuildContext context, int index) {
    return PropertyItemWidget(property: con.properties![index]);
  }

  Widget getOtherItem(BuildContext context, int index) {
    return PropertyItemWidget(property: con.othersProps![index]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cont = TabController(length: 2, vsync: this);
    con.waitForContractorProperties();
    selection = false;
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    con.waitForContractorProperties();
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 2));
    // tasks.value = null;
    // dueDeliveries.value = null;
    // hp.notifyTasks();
    // hp.notifyDues();
    getData();
  }

  void getData() async {
    await Future.delayed(Duration.zero, assignData);
  }

  void assignData() {
    try {
      // refreshController.refreshToIdle();
      cont = TabController(length: 2, vsync: this);
      con.waitForContractorProperties();
      selection = false;
      // refreshController.refreshCompleted();
    } catch (e) {
      sendAppLog(e);
      // refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: DefaultTabController(
          length: 2,
          child: SafeArea(
            top: isAndroid,
            bottom: isAndroid,
            child: Scaffold(
                key: _scaffoldKey,
                body: TabBarView(children: [
                  con.properties == null
                      ? Center(
                          child: CustomLoader(
                              sizeFactor: 10,
                              duration: const Duration(seconds: 10),
                              color: hp.theme.primaryColor,
                              loaderType: LoaderType.fadingCircle))
                      : (RefreshIndicator(
                          onRefresh: refreshList,
                          child: (con.properties?.isEmpty ?? true)
                              ? emptyBuilder(context)
                              : SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 30,
                                          bottom: 10),
                                      child: hp.isTablet
                                          ? tableStructure(context)
                                          : hp.dimensions.orientation ==
                                                  Orientation.landscape
                                              ? tableStructure(context)
                                              : mobiletableStructure(context)),
                                ))),
                  con.othersProps == null
                      ? Center(
                          child: CustomLoader(
                              sizeFactor: 10,
                              duration: const Duration(seconds: 10),
                              color: hp.theme.primaryColor,
                              loaderType: LoaderType.fadingCircle))
                      : (RefreshIndicator(
                          onRefresh: refreshList,
                          child: (con.othersProps?.isEmpty ?? true)
                              ? emptyBuilder(context)
                              : SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 30,
                                          bottom: 10),
                                      child: hp.isTablet
                                          ? otherProtableStructure(context)
                                          : hp.dimensions.orientation ==
                                                  Orientation.landscape
                                              ? otherProtableStructure(context)
                                              : mobileotherProptableStructure(
                                                  context)),
                                ))),
                ]),
                drawer:
                    Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
                appBar: AppBar(
                    leadingWidth: hp.leadingWidth,
                    automaticallyImplyLeading: false,
                    leading: const LeadingWidget(visible: false),
                    bottom: PreferredSize(
                      preferredSize: _tabBar.preferredSize,
                      child: Container(
                        color: Colors.white,
                        child: _tabBar,
                      ),
                    ),
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: hp.theme.primaryColor,
                    foregroundColor: hp.theme.scaffoldBackgroundColor,
                    title: const Text('My Properties',
                        textScaleFactor: 1.0,
                        style: TextStyle(fontWeight: FontWeight.w600))),
                bottomNavigationBar: const BottomWidget()),
          )),
    );
  }

  Widget emptyBuilder(BuildContext context) {
    log('afdsdfsd');
    var listValue = ['No Properties Found'];
    var list = (listValue)
        .map((item) => TableRow(
                children: [
                  // TableCell(
                  //   verticalAlignment: TableCellVerticalAlignment.middle,
                  //   child: Padding(
                  //     padding:
                  //         const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                  //     child: Text(item.propertytypename,
                  //         style: hp.textTheme.bodyText1),
                  //   ),
                  // ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: Text(item,
                          textScaleFactor: 1.0, style: hp.textTheme.bodyMedium),
                    ),
                  ),
                ],
                decoration: const BoxDecoration(
                    color: /*con.documents!.indexOf(item) % 2 == 0
                    ?*/
                        Colors.white /*: Colors.black12*/)))
        .toList();
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Table(
              children: list,
              columnWidths: const {
                0: FlexColumnWidth(4),
              },
              // textDirection: TextDirection.ltr,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: const TableBorder(
                  top: BorderSide(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1),
                  left: BorderSide(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1),
                  right: BorderSide(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1),
                  bottom: BorderSide(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1),
                  verticalInside: BorderSide(
                      color: Colors.black26,
                      style: BorderStyle.solid,
                      width: 1),
                  horizontalInside: BorderSide.none)),
        ));
  }

  Widget tableStructure(BuildContext context) {
    final hp = Helper.of(context);

    var list = (con.properties as List<Property>)
        .map((item) => TableRow(
                children: [
                  // TableCell(
                  //   verticalAlignment: TableCellVerticalAlignment.middle,
                  //   child: Padding(
                  //     padding:
                  //         const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                  //     child: Text(item.property_owner_name,
                  //         style: hp.textTheme.bodyText1),
                  //   ),
                  // ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: Text(item.address1,
                          textScaleFactor: 1.0,
                          style: const TextStyle(fontSize: 17)),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 15),
                        child: Text(item.city,
                            textScaleFactor: 1.0,
                            style: const TextStyle(fontSize: 17))),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 15),
                          child: Text('View Property',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  color: hp.theme.focusColor)),
                        ),
                        onTap: () {
                          props.value = item;
                          item.onChange();
                          hp.goTo('/property_details', vcb: () {
                            didUpdateWidget(widget);
                          },
                              args: RouteArgument(
                                  id: 0, params: item, content: 'false'));
                        }),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: IconButton(
                        onPressed: () async {
                          // log(currentUser.value.userID);
                          // log(item.propID);
                          final prefs = await sharedPrefs;
                          await prefs.setString(
                              'itemPropID', item.propID.toString());
                          await prefs.setString(
                              'propUserID', item.userID.toString());
                          _asyncSimpleDialog(
                              _scaffoldKey.currentContext ?? context,
                              item.propID.toString(),
                              item.userID.toString());
                          // _asyncSimpleDialog(
                          //     _scaffoldKey.currentContext ?? context,
                          //     item.propID.toString());
                        },
                        icon: Image.asset(
                          '${assetImagePath}People Rechanged.png',
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
                decoration: const BoxDecoration(
                    color: /*con.documents!.indexOf(item) % 2 == 0
                    ?*/
                        Colors.white /*: Colors.black12*/)))
        .toList();
    list.insert(
      0,
      const TableRow(children: [
        // TableCell(
        //   verticalAlignment: TableCellVerticalAlignment.middle,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
        //     child: Text('Name', style: hp.textTheme.bodyText1),
        //   ),
        // ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Address',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('City',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Select',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Active Users',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
      ], decoration: BoxDecoration(color: Colors.black26)),
    );
    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(4),
          3: FlexColumnWidth(4)
        },
        // textDirection: TextDirection.ltr,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
            top: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            left: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            right: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            bottom: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            verticalInside: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            horizontalInside: BorderSide.none));
  }

  List<String> val = ['David', 'Joe Blow', 'Joe Doakes', 'Danica Elora'];

  Widget otherProtableStructure(BuildContext context) {
    final hp = Helper.of(context);
    // log('object');
    var list = (con.othersProps as List<Property>)
        .map((item) => TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: Text(item.ownerName,
                          textScaleFactor: 1.0,
                          style: const TextStyle(
                            fontSize: 17,
                          )),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: Text(item.address1,
                          textScaleFactor: 1.0,
                          style: const TextStyle(
                            fontSize: 17,
                          )),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 15),
                        child: Text(item.city,
                            textScaleFactor: 1.0,
                            style: const TextStyle(
                              fontSize: 17,
                            ))),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 15),
                          child: Visibility(
                            visible: !(item.expired),
                            child: Text('View Property',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                    color: hp.theme.focusColor)),
                          ),
                        ),
                        onTap: () {
                          props.value = item;
                          item.onChange();
                          hp.goTo('/property_details', vcb: () {
                            didUpdateWidget(widget);
                          },
                              args: RouteArgument(
                                  id: 1, params: item, content: 'false'));
                        }),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                      child: IconButton(
                        onPressed: () async {
                          // log(currentUser.value.userID);
                          // log(item.propID);
                          final prefs = await sharedPrefs;
                          await prefs.setString(
                              'itemPropID', item.propID.toString());
                          await prefs.setString(
                              'propUserID', item.userID.toString());
                          _asyncOthersSimpleDialog(
                              _scaffoldKey.currentContext ?? context,
                              item.propID.toString(),
                              item.userID.toString());
                          // _asyncSimpleDialog(
                          //     _scaffoldKey.currentContext ?? context,
                          //     item.propID.toString());
                        },
                        icon: Image.asset(
                          '${assetImagePath}People Rechanged.png',
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
                decoration: const BoxDecoration(
                    color: /*con.documents!.indexOf(item) % 2 == 0
                    ?*/
                        Colors.white /*: Colors.black12*/)))
        .toList();
    list.insert(
      0,
      const TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Name',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Address',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('City',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Select',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('Request Access',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
        ),
      ], decoration: BoxDecoration(color: Colors.black26)),
    );

    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(4),
          3: FlexColumnWidth(4),
          4: FlexColumnWidth(4)
        },
        // textDirection: TextDirection.LTR ?? TextDirection.UNKNOWN,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
            top: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            left: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            right: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            bottom: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            verticalInside: BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 1),
            horizontalInside: BorderSide.none));
  }

  Widget mobiletableStructure(BuildContext context) {
    final hp = Helper.of(context);
    return Padding(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: con.properties?.length ?? 0,
            itemBuilder: (context, index) {
              var item = con.properties?[index];
              return Container(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                color: con.properties!.indexOf(item!) % 2 == 0
                    ? Colors.white
                    : Colors.black12.withAlpha(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Text(item.address1,
                                textScaleFactor: 1.0,
                                //overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                // maxLines: 0,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 17,
                                )),
                          ),
                          const Flexible(
                              flex: 2,
                              child: Text(
                                'Active Users',
                                textScaleFactor: 1.0,
                                style: TextStyle(fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 0, right: 10),
                            child: Text(item.city,
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 17,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, top: 10, bottom: 0),
                            child: IconButton(
                              onPressed: () async {
                                // log(currentUser.value.userID);
                                // log(item.propID);
                                final prefs = await sharedPrefs;
                                await prefs.setString(
                                    'itemPropID', item.propID.toString());
                                await prefs.setString(
                                    'propUserID', item.userID.toString());
                                _asyncSimpleDialog(
                                    _scaffoldKey.currentContext ?? context,
                                    item.propID.toString(),
                                    item.userID.toString());
                              },
                              icon: Image.asset(
                                '${assetImagePath}People Rechanged.png',
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        ]),
                    GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 0),
                          child: Text('View Property',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  color: hp.theme.focusColor)),
                        ),
                        onTap: () {
                          props.value = item;
                          item.onChange();
                          hp.goTo('/property_details', vcb: () {
                            didUpdateWidget(widget);
                          },
                              args: RouteArgument(
                                  id: 0, params: item, content: 'false'));
                        }),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              var item = con.properties?[index];
              return Container(
                height: 10,
                color: con.properties!.indexOf(item!) % 2 == 0
                    ? Colors.white
                    : Colors.black12.withAlpha(20),
              );
            },
          ),
        ));
  }

  Widget mobileotherProptableStructure(BuildContext context) {
    final hp = Helper.of(context);
    return Padding(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
        child: Container(
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: con.othersProps?.length ?? 0,
            itemBuilder: (context, index) {
              var item = con.othersProps?[index];
              return Container(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                color: con.othersProps!.indexOf(item!) % 2 == 0
                    ? Colors.white
                    : Colors.black12.withAlpha(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, bottom: 0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Text(item.ownerName,
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 17,
                                )),
                          ),
                          Flexible(
                              flex: 2,
                              child: Text(
                                'Request Access',
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: hp.width > 325 ? 14 : 12),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Text(item.address1,
                          textScaleFactor: 1.0,
                          //overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          // maxLines: 0,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 17,
                          )),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 10, bottom: 0, right: 10),
                            child: Text(item.city,
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 17,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: hp.width > 325 ? 35 : 30,
                                top: 10,
                                bottom: 0),
                            child: IconButton(
                              onPressed: () async {
                                // log(currentUser.value.userID);
                                // log(item.propID);
                                final prefs = await sharedPrefs;
                                await prefs.setString(
                                    'itemPropID', item.propID.toString());
                                await prefs.setString(
                                    'propUserID', item.userID.toString());
                                _asyncOthersSimpleDialog(
                                    _scaffoldKey.currentContext ?? context,
                                    item.propID.toString(),
                                    item.userID.toString());
                              },
                              icon: Image.asset(
                                '${assetImagePath}People Rechanged.png',
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        ]),
                    GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 5),
                          child: Visibility(
                            visible: !(item.expired),
                            child: Text('View Property',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                    color: hp.theme.focusColor)),
                          ),
                        ),
                        onTap: () {
                          // log(item.toString());
                          props.value = item;
                          item.onChange();
                          // log(item);
                          hp.goTo('/property_details', vcb: () {
                            didUpdateWidget(widget);
                          },
                              args: RouteArgument(
                                  id: 1, params: item, content: 'false'));
                        }),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              var item = con.othersProps?[index];
              return Container(
                height: 10,
                color: con.othersProps!.indexOf(item!) % 2 == 0
                    ? Colors.white
                    : Colors.black12.withAlpha(20),
              );
            },
          ),
        ));
  }

  void _asyncSimpleDialog(
      BuildContext context, String propId, String propUserId) async {
    Loader.show(context);
    final hp = Helper.of(context);
    final width = MediaQuery.of(context).size.width;
    con.accessList = await api.getPropertyaccessList(propId, propUserId);
    Loader.hide();
    showDialog(
        barrierDismissible: false,
        context: _scaffoldKey.currentContext ?? context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              '${assetImagePath}2172370.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: (width > 376) ? 5 : 2,
                            ),
                            Text(
                              'Landlord',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: (width > 376) ? 12 : 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              '${assetImagePath}5.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: (width > 376) ? 5 : 2,
                            ),
                            Text(
                              'Installer',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: (width > 376) ? 12 : 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              '${assetImagePath}PeopleSingleImage.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: (width > 376) ? 5 : 2,
                            ),
                            Text(
                              'User/Tenant',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: (width > 376) ? 12 : 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Transform.rotate(
                          angle: pi / 4,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.add,
                                color: hp.theme.primaryColor,
                                size: 35,
                              )))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: (width > 376) ? 40 : 40,
                        bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            'Access Status  ',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: (width > 376) ? 17.0 : 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Expiry Date',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: (width > 376) ? 12.5 : 11,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Duration',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: (width > 376) ? 12.5 : 11,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black54),
                ],
              ),
              content: Container(
                constraints: const BoxConstraints(
                    maxHeight: 300,
                    minHeight: 200,
                    minWidth: 300,
                    maxWidth: 350),
                width: 350.0,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 5),
                        child: con.accessList!.data.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: con.accessList?.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  for (int i = 0;
                                      i < (con.accessList?.data.length ?? 0);
                                      i++) {
                                    selectedItemValue.add('1 Day');
                                  }
                                  var data = con.accessList?.data ?? [];
                                  var date = data[index].expiryDate;
                                  // log(date);
                                  String dateData = '';
                                  if (date.isNotEmpty) {
                                    var inputFormat =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var inputDate = inputFormat
                                        .parse(date); // <-- dd/MM 24H format
                                    var outputFormat = DateFormat('dd/MM/yyyy');
                                    var outputDate =
                                        outputFormat.format(inputDate);
                                    // log(outputDate);
                                    dateData = outputDate;
                                  }
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                data[index].userAccessRole == 3
                                                    ? '${assetImagePath}PeopleSingleImage.png'
                                                    : data[index]
                                                                .userAccessRole ==
                                                            4
                                                        ? '${assetImagePath}2172370.png'
                                                        : data[index]
                                                                    .userAccessRole ==
                                                                5
                                                            ? '${assetImagePath}5.png'
                                                            : '${assetImagePath}PeopleSingleImage.png',
                                                width: 35,
                                                height: 35,
                                                fit: BoxFit.contain,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  data[index].name,
                                                  textScaleFactor: 1.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                  flex: 4,
                                                  child: Text(
                                                      data[index].status == 2
                                                          ? dateData.isEmpty
                                                              ? '          '
                                                              : dateData
                                                          : data[index]
                                                                      .accessForever ==
                                                                  1
                                                              ? 'Forever'
                                                              : dateData.isEmpty
                                                                  ? '          '
                                                                  : dateData,
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          fontSize:
                                                              hp.width > 326
                                                                  ? 11
                                                                  : 11,
                                                          fontWeight: FontWeight
                                                              .w600))),
                                              // const SizedBox(width: 2,),
                                              Flexible(
                                                flex: 4,
                                                child: ((data[index].status ==
                                                                2 ||
                                                            data[index]
                                                                    .status ==
                                                                0) ||
                                                        data[index].expired ==
                                                            true)
                                                    ? DropdownButton(
                                                        iconSize: 12,
                                                        value:
                                                            selectedItemValue[
                                                                    index]
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
                                                        icon: const Icon(Icons
                                                            .keyboard_arrow_down),
                                                        items: accessTime.map(
                                                            (String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedItemValue[
                                                                    index] =
                                                                newValue ?? '';
                                                          });
                                                        },
                                                      )
                                                    : const Text(''),
                                              ),
                                              // const SizedBox(
                                              //   width: 4,
                                              // ),
                                              Flexible(
                                                flex: 2,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      var status =
                                                          data[index].status;
                                                      var expired =
                                                          data[index].expired;
                                                      if (status == 1 &&
                                                          expired == false) {
                                                        // Navigator.pop(context);
                                                        final propId =
                                                            data[index].propID;
                                                        final propUserid =
                                                            data[index].userID;
                                                        final reqId = data[
                                                                index]
                                                            .requestAccessID;
                                                        showCupertinoDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return MediaQuery(
                                                                data: MediaQueryData.fromWindow(wb
                                                                            ?.window ??
                                                                        WidgetsBinding
                                                                            .instance
                                                                            .window)
                                                                    .copyWith(
                                                                        boldText:
                                                                            false,
                                                                        textScaleFactor:
                                                                            1.0),
                                                                child:
                                                                    CupertinoAlertDialog(
                                                                  title: Text(
                                                                      title),
                                                                  content:
                                                                      const Text(
                                                                    'Are you sure you would like to revoke access?',
                                                                    textScaleFactor:
                                                                        1.0,
                                                                  ),
                                                                  actions: [
                                                                    CupertinoDialogAction(
                                                                        child:
                                                                            const Text(
                                                                          'No',
                                                                          textScaleFactor:
                                                                              1.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          final prefs =
                                                                              await sharedPrefs;
                                                                          var propID =
                                                                              prefs.getString('itemPropID') ?? '';
                                                                          var propUserID =
                                                                              prefs.getString('propUserID') ?? '';
                                                                          // log(propID);
                                                                          // log('trusting here2');

                                                                          con.accessList = await api.getPropertyaccessList(
                                                                              propID,
                                                                              propUserID);

                                                                          setState(
                                                                              () {});
                                                                        }),
                                                                    CupertinoDialogAction(
                                                                        child:
                                                                            const Text(
                                                                          'Yes',
                                                                          textScaleFactor:
                                                                              1.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          try {
                                                                            Loader.show(context);
                                                                            final p = await api.propertyRevoke(
                                                                                propId,
                                                                                reqId,
                                                                                propUserid);

                                                                            // log(p);
                                                                            if (p.success) {
                                                                              final prefs = await sharedPrefs;
                                                                              var propID = prefs.getString('itemPropID') ?? '';
                                                                              var propUserID = prefs.getString('propUserID') ?? '';
                                                                              // log(propID);
                                                                              // log('trusting here2');
                                                                              con.accessList = await api.getPropertyaccessList(propID, propUserID);
                                                                              Loader.hide();
                                                                              setState(() {});
                                                                            } else {
                                                                              Loader.hide();
                                                                            }
                                                                          } catch (e) {
                                                                            sendAppLog(e);
                                                                            if (Loader.isShown) {
                                                                              Loader.hide();
                                                                            }
                                                                          }
                                                                        }),
                                                                  ],
                                                                ));
                                                          },
                                                        );
                                                      } else if ((status == 2 ||
                                                              status == 0) ||
                                                          (expired == true)) {
                                                        final reqId = data[
                                                                index]
                                                            .requestAccessID;
                                                        final duration =
                                                            selectedItemValue[
                                                                index];
                                                        var durationDays = '';
                                                        if (duration ==
                                                            '1 Day') {
                                                          durationDays = '1';
                                                        } else if (duration ==
                                                            '1 Week') {
                                                          durationDays = '7';
                                                        } else if (duration ==
                                                            '1 Month') {
                                                          durationDays = '30';
                                                        } else {
                                                          durationDays =
                                                              'forever';
                                                        }
                                                        // log(duration);
                                                        showCupertinoDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return MediaQuery(
                                                                data: MediaQueryData.fromWindow(wb
                                                                            ?.window ??
                                                                        WidgetsBinding
                                                                            .instance
                                                                            .window)
                                                                    .copyWith(
                                                                        boldText:
                                                                            false,
                                                                        textScaleFactor:
                                                                            1.0),
                                                                child:
                                                                    CupertinoAlertDialog(
                                                                  title: Text(
                                                                      title),
                                                                  content: Text(
                                                                    'Are you sure you would like to grant access for a $duration period?',
                                                                    textScaleFactor:
                                                                        1.0,
                                                                  ),
                                                                  actions: [
                                                                    CupertinoDialogAction(
                                                                        child:
                                                                            const Text(
                                                                          'No',
                                                                          textScaleFactor:
                                                                              1.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          final prefs =
                                                                              await sharedPrefs;
                                                                          var propID =
                                                                              prefs.getString('itemPropID') ?? '';
                                                                          var propUserID =
                                                                              prefs.getString('propUserID') ?? '';
                                                                          // log(propID);
                                                                          con.accessList = await api.getPropertyaccessList(
                                                                              propID,
                                                                              propUserID);
                                                                          setState(
                                                                              () {});
                                                                        }),
                                                                    CupertinoDialogAction(
                                                                        child:
                                                                            const Text(
                                                                          'Yes',
                                                                          textScaleFactor:
                                                                              1.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          // data[index].status = 1;
                                                                          // setState(
                                                                          //     () {});
                                                                          Loader.show(
                                                                              context);
                                                                          var p = await api.updateRequestAccess(
                                                                              reqId,
                                                                              durationDays,
                                                                              1,
                                                                              0);

                                                                          if (p
                                                                              .success) {
                                                                            final prefs =
                                                                                await sharedPrefs;
                                                                            var propID =
                                                                                prefs.getString('itemPropID') ?? '';
                                                                            var propUserID =
                                                                                prefs.getString('propUserID') ?? '';
                                                                            log(propID);
                                                                            log('trusting here2');
                                                                            con.accessList =
                                                                                await api.getPropertyaccessList(propID, propUserID);
                                                                            Loader.hide();
                                                                            setState(() {});
                                                                          } else {
                                                                            Loader.hide();
                                                                          }
                                                                        }),
                                                                  ],
                                                                ));
                                                          },
                                                        );
                                                      } else {}
                                                    },
                                                    child: data[index]
                                                                .expired ==
                                                            true
                                                        ? Image.asset(
                                                            '${assetImagePath}6.png',
                                                            width:
                                                                hp.width > 325
                                                                    ? 35
                                                                    : 30,
                                                            height:
                                                                hp.width > 325
                                                                    ? 35
                                                                    : 30,
                                                            fit: BoxFit.contain,
                                                          )
                                                        : data[index]
                                                                    .accessForever ==
                                                                1
                                                            ? Image.asset(
                                                                '${assetImagePath}4.png',
                                                                width:
                                                                    hp.width >
                                                                            325
                                                                        ? 35
                                                                        : 30,
                                                                height:
                                                                    hp.width >
                                                                            325
                                                                        ? 35
                                                                        : 30,
                                                                fit: BoxFit
                                                                    .contain,
                                                              )
                                                            : data[index].status ==
                                                                        0 ||
                                                                    data[index]
                                                                            .status ==
                                                                        2
                                                                ? Image.asset(
                                                                    '${assetImagePath}6.png',
                                                                    width: hp.width >
                                                                            325
                                                                        ? 35
                                                                        : 30,
                                                                    height: hp.width >
                                                                            325
                                                                        ? 35
                                                                        : 30,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  )
                                                                : Image.asset(
                                                                    '${assetImagePath}4.png',
                                                                    width: hp.width >
                                                                            325
                                                                        ? 35
                                                                        : 30,
                                                                    height: hp.width >
                                                                            325
                                                                        ? 35
                                                                        : 30,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  )
                                                    /*
                                                  data[index].status == 0
                                                      ? Image.asset(
                                                          '${assetImagePath}6.png',
                                                          width: hp.width > 325
                                                              ? 35
                                                              : 30,
                                                          height: hp.width > 325
                                                              ? 35
                                                              : 30,
                                                          fit: BoxFit.contain,
                                                        )
                                                      : data[index].status ==
                                                                  1 &&
                                                              data[index]
                                                                      .expired ==
                                                                  false
                                                          ? Image.asset(
                                                              '${assetImagePath}4.png',
                                                              width:
                                                                  hp.width > 325
                                                                      ? 35
                                                                      : 30,
                                                              height:
                                                                  hp.width > 325
                                                                      ? 35
                                                                      : 30,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )
                                                          : Image.asset(
                                                              '${assetImagePath}6.png',
                                                              width:
                                                                  hp.width > 325
                                                                      ? 35
                                                                      : 30,
                                                              height:
                                                                  hp.width > 325
                                                                      ? 35
                                                                      : 30,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),*/
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 300,
                                    minHeight: 80,
                                    minWidth: 300,
                                    maxWidth: 350),
                                width: 350,
                                child: const Text(
                                  'No users have requested or been granted access to this property.',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Divider(color: Colors.black54),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Image.asset(
                                            '${assetImagePath}4.png',
                                            width: hp.width > 325 ? 20 : 15,
                                            height: hp.width > 325 ? 20 : 15,
                                            fit: BoxFit.contain,
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Access Granted. Toggle to revoke.',
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize:
                                                    hp.width > 325 ? 9 : 7.5,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Image.asset(
                                            '${assetImagePath}6.png',
                                            width: hp.width > 325 ? 20 : 15,
                                            height: hp.width > 325 ? 20 : 15,
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Access Revoked / Pending. Toggle to grant for request period.',
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize:
                                                    hp.width > 325 ? 9 : 7.5,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void _asyncOthersSimpleDialog(
      BuildContext context, String propId, String propUserId) async {
    Loader.show(context);
    final hp = Helper.of(context);
    final width = MediaQuery.of(context).size.width;
    con.accessList = await api.getPropertyaccessList(propId, propUserId);
    Loader.hide();
    showDialog(
        barrierDismissible: false,
        context: _scaffoldKey.currentContext ?? context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(20),
              contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              '${assetImagePath}2172370.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: (width > 376) ? 5 : 2,
                            ),
                            Text(
                              'Landlord',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: (width > 376) ? 12 : 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              '${assetImagePath}5.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: (width > 376) ? 5 : 2,
                            ),
                            Text(
                              'Installer',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: (width > 376) ? 12 : 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              '${assetImagePath}PeopleSingleImage.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: (width > 376) ? 5 : 2,
                            ),
                            Text(
                              'User/Tenant',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: (width > 376) ? 12 : 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Transform.rotate(
                          angle: pi / 4,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.add,
                                color: hp.theme.primaryColor,
                                size: 35,
                              )))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 35, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: hp.width > 325 ? 2 : 3,
                          child: Text(
                            'Account Owner Request Access',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: (width > 376) ? 15 : 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            'Expiry Date',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: (width > 376) ? 12.0 : 11,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black54),
                ],
              ),
              content: Container(
                constraints: const BoxConstraints(
                    maxHeight: 300,
                    minHeight: 200,
                    minWidth: 300,
                    maxWidth: 350),
                width: 350.0,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: con.accessList!.success
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = con.accessList?.propowner;
                                  var date = data?.expiryDate ?? '';
                                  int dateSub = 0;
                                  log(date);

                                  String dateData = '';
                                  if (date.isNotEmpty) {
                                    var inputFormat =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var inputDate = inputFormat.parse(date);
                                    log(inputDate.year);
                                    log(inputDate.month);
                                    log(inputDate.day);
                                    final birthday = DateTime(
                                        inputDate.year.toInt(),
                                        inputDate.month.toInt(),
                                        inputDate.day.toInt());
                                    log(birthday);
                                    final date2 = DateTime.now();
                                    dateSub = birthday.difference(date2).inDays;
                                    log(dateSub);
                                    var outputFormat = DateFormat('dd/MM/yyyy');
                                    var outputDate =
                                        outputFormat.format(inputDate);
                                    log(outputDate);
                                    log('outputDate');
                                    dateData = outputDate;
                                  }

                                  return SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                data?.userAccessRole == 3
                                                    ? '${assetImagePath}PeopleSingleImage.png'
                                                    : data?.userAccessRole == 4
                                                        ? '${assetImagePath}2172370.png'
                                                        : data?.userAccessRole ==
                                                                5
                                                            ? '${assetImagePath}5.png'
                                                            : '${assetImagePath}PeopleSingleImage.png',
                                                width: 35,
                                                height: 35,
                                                fit: BoxFit.contain,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  data?.name ?? '',
                                                  textScaleFactor: 1.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: hp.width > 325 ? 2 : 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                      data?.status == 2
                                                          ? dateData
                                                          : data?.accessForever ==
                                                                  1
                                                              ? 'Forever'
                                                              : dateData,
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          fontSize:
                                                              hp.width > 326
                                                                  ? 11
                                                                  : 11,
                                                          fontWeight: FontWeight
                                                              .w600))),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Flexible(
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        if ((data?.expired ==
                                                                    true &&
                                                                (data?.status ==
                                                                        2 ||
                                                                    data?.status ==
                                                                        1)) ||
                                                            data?.expired ==
                                                                    false &&
                                                                data?.status ==
                                                                    2) {
                                                          log('cjnbafjdbj');
                                                          var body = {
                                                            'prop_id': data
                                                                ?.propID
                                                                .toString(),
                                                            'user_id':
                                                                currentUser
                                                                    .value
                                                                    .userID
                                                                    .toString(),
                                                            'prop_user_id': data
                                                                ?.propUserID
                                                                .toString()
                                                          };
                                                          try {
                                                            //  Loader.show(context);
                                                            final v = await api
                                                                .requestAccessClone(
                                                                    body);
                                                            //  Loader.hide();
                                                            log(v);
                                                            if (v.success) {
                                                              hp.showSimplePopup(
                                                                  'OK',
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                final prefs =
                                                                    await sharedPrefs;
                                                                var propID =
                                                                    prefs.getString(
                                                                            'itemPropID') ??
                                                                        '';
                                                                var propUserID =
                                                                    prefs.getString(
                                                                            'propUserID') ??
                                                                        '';
                                                                con.accessList =
                                                                    await api.getPropertyaccessList(
                                                                        propID,
                                                                        propUserID);
                                                                setState(() {});
                                                              },
                                                                  action:
                                                                      'Property access Request sent to the Property owner!',
                                                                  type: AlertType
                                                                      .cupertino);
                                                            } else if (await hp
                                                                .showSimplePopup(
                                                                    'OK',
                                                                    () async {
                                                              hp.goBack(
                                                                  result: true);
                                                            },
                                                                    action: v
                                                                        .message,
                                                                    type: AlertType
                                                                        .cupertino)) {
                                                              final prefs =
                                                                  await sharedPrefs;
                                                              var propID = prefs
                                                                      .getString(
                                                                          'itemPropID') ??
                                                                  '';
                                                              var propUserID =
                                                                  prefs.getString(
                                                                          'propUserID') ??
                                                                      '';
                                                              con.accessList = await api
                                                                  .getPropertyaccessList(
                                                                      propID,
                                                                      propUserID);
                                                              setState(() {});
                                                            }
                                                          } catch (e) {
                                                            // Loader.hide();
                                                          }
                                                        } else {}
                                                      },
                                                      child: data?.expired ==
                                                              true
                                                          ? (data?.status ==
                                                                      1 ||
                                                                  data?.status ==
                                                                      2)
                                                              ? Image.asset(
                                                                  '${assetImagePath}6.png',
                                                                  width:
                                                                      hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                  height:
                                                                      hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )
                                                              : Image.asset(
                                                                  '${assetImagePath}4.png',
                                                                  width:
                                                                      hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                  height:
                                                                      hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  color: Colors
                                                                      .grey,
                                                                )
                                                          : data?.expired ==
                                                                      false &&
                                                                  data?.status ==
                                                                      2
                                                              ? Image.asset(
                                                                  '${assetImagePath}6.png',
                                                                  width:
                                                                      hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                  height:
                                                                      hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )
                                                              : data?.expired ==
                                                                          false &&
                                                                      data?.status ==
                                                                          0
                                                                  ? Image.asset(
                                                                      '${assetImagePath}4.png',
                                                                      width: hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                      height: hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      color: Colors
                                                                          .grey,
                                                                    )
                                                                  : Image.asset(
                                                                      '${assetImagePath}4.png',
                                                                      width: hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                      height: hp.width >
                                                                              325
                                                                          ? 35
                                                                          : 30,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 300,
                                    minHeight: 80,
                                    minWidth: 300,
                                    maxWidth: 350),
                                width: 350,
                                child: const Text(
                                  'No users have requested or been granted access to this property.',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Divider(color: Colors.black54),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Image.asset(
                                            '${assetImagePath}4.png',
                                            width: hp.width > 325 ? 20 : 15,
                                            height: hp.width > 325 ? 20 : 15,
                                            fit: BoxFit.contain,
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Access granted and live',
                                            textScaleFactor: 1.0,
                                            maxLines: 5,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize:
                                                    hp.width > 325 ? 9 : 7.5,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Image.asset(
                                            '${assetImagePath}6.png',
                                            width: hp.width > 325 ? 20 : 15,
                                            height: hp.width > 325 ? 20 : 15,
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Access Expired . Toggle to send a request.',
                                            textScaleFactor: 1.0,
                                            maxLines: 5,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize:
                                                    hp.width > 325 ? 9 : 7.5,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Image.asset(
                                            '${assetImagePath}4.png',
                                            width: hp.width > 325 ? 20 : 15,
                                            height: hp.width > 325 ? 20 : 15,
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                            fit: BoxFit.contain,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Access Requested',
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize:
                                                    hp.width > 325 ? 9 : 7.5,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
