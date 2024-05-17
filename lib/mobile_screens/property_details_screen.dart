import '../models/document.dart';
import '../widgets/custom_loader.dart';

import '../backend/api.dart';
import '../widgets/loader.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../controllers/property_and_document_controller.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final RouteArgument rar;
  const PropertyDetailsScreen({Key? key, required this.rar}) : super(key: key);

  @override
  PropertyDetailsScreenState createState() => PropertyDetailsScreenState();
}

class PropertyDetailsScreenState extends StateMVC<PropertyDetailsScreen> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  PropertyDetailsScreenState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  Widget textBuilder(BuildContext context, int count, Widget? child) => Padding(
      padding: EdgeInsets.only(top: hp.height / 100, bottom: hp.height / 80),
      child: count > 0
          ? Text(
              'You have $count document spaces available',
              textScaleFactor: 1.0,
              style: const TextStyle(fontSize: 17),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You have $count document spaces available',
                  textScaleFactor: 1.0,
                  style: const TextStyle(fontSize: 17),
                ),
                const Text(
                  'Please visit your account on our website to buy more spaces.',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 17),
                )
              ],
            )
      // Text(count > 0
      //     ? ('You Have $count spaces available')
      //     : 'Please visit your account on our website to buy more spaces.')
      );

  Widget pageBuilder(BuildContext context, Property property, Widget? child) {
    log(property.fullAddress);
    Widget addDocumentLabel(BuildContext context, int count, Widget? child) =>
        Visibility(
            visible: count != 0,
            child: GestureDetector(
              child: Text('Add a new document',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                      color: hp.theme.focusColor)),
              onTap: () {
                hp.goTo('/add_or_edit_document', vcb: () {
                  con.waitForDocuments(property: property);
                });
              },
            ));
    String address = property.fullAddress;
    address = address.trim();
    if (address.endsWith(',')) {
      address = address.substring(0, address.length - 1);
    }
    log(address);
    log(property.ownerName);
    log('vantan da');
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          //  key: hp.key,
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          bottomNavigationBar: child,
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: hp.width / 25, vertical: hp.height / 50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('View Property:',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text('Property owned by ${property.ownerName}',
                            textScaleFactor: 1.0,
                            style: const TextStyle(fontSize: 17))),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Text(address,
                            textScaleFactor: 1.0,
                            style: const TextStyle(fontSize: 17))),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: hp.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text('Property Owner:',
                                textScaleFactor: 1.0,
                                style: TextStyle(fontSize: 17)),
                          ),
                          // const Expanded(
                          //     flex: 2,
                          //     child: SizedBox(
                          //       width: 20,
                          //     )),
                          Expanded(
                            flex: 4,
                            child: Text(property.ownerName,
                                textScaleFactor: 1.0,
                                style: const TextStyle(fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: hp.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text('Post code:',
                                textScaleFactor: 1.0,
                                style: TextStyle(fontSize: 17)),
                          ),
                          // const Expanded(
                          //     flex: 2,
                          //     child: SizedBox(
                          //       width: 20,
                          //     )),
                          Expanded(
                            flex: 4,
                            child: Text(property.zipCode,
                                textScaleFactor: 1.0,
                                style: const TextStyle(fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text('QR Code Added On:',
                                textScaleFactor: 1.0,
                                style: TextStyle(fontSize: 17)),
                          ),
                          // const Expanded(flex:2,child: SizedBox(width: 20,)),
                          Expanded(
                            flex: 4,
                            child: Text(property.date,
                                textScaleFactor: 1.0,
                                style: const TextStyle(fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text('Property Type:',
                                textScaleFactor: 1.0,
                                style: TextStyle(fontSize: 17)),
                          ),
                          // const Expanded(
                          //     flex: 2,
                          //     child: SizedBox(
                          //       width: 20,
                          //     )),
                          Expanded(
                            flex: 4,
                            child: Text(property.type.type,
                                textScaleFactor: 1.0,
                                style: const TextStyle(fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 20, bottom: 20),
                          child:
                              // Visibility(
                              //   visible:
                              //       currentUser.value.userID == property.userID,
                              //   child:
                              Text('Edit this Property',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline,
                                      color: hp.theme.focusColor)),
                        ),
                        onTap: () {
                          hp.goTo('/edit_property',
                              args: RouteArgument(
                                  id: widget.rar.id,
                                  params: property,
                                  tag: 'true',
                                  content: widget.rar.content));
                        }),
                    const Text('Property Saved Documents',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    con.documents == null
                        ? Center(
                            heightFactor: hp.height / 250,
                            child: CustomLoader(
                                sizeFactor: 10,
                                duration: const Duration(seconds: 10),
                                color: hp.theme.primaryColor,
                                loaderType: LoaderType.fadingCircle))
                        : (con.documents!.isEmpty
                            ? ValueListenableBuilder<int>(
                                valueListenable: remainingSpace,
                                builder: emptyBuilder)
                            : tableListStructure(con.documents ?? [])),
                    Visibility(
                        visible: currentUser.value.userID != property.userID &&
                            currentUser.value.isContractor &&
                            widget.rar.content == null &&
                            !parseBool(widget.rar.id.toString()),
                        child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text('Request Access Permission',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline,
                                      color: hp.theme.focusColor)),
                            ),
                            onTap: () {
                              if (currentUser.value.userID != property.userID) {
                                requestAccessAPI(
                                    property.propID.toString(),
                                    property.userID.toString(),
                                    currentUser.value.userID.toString());
                              } else {
                                log('Hi');
                              }
                            })),
                    ValueListenableBuilder<int>(
                        valueListenable: remainingSpace, builder: textBuilder),
                    ValueListenableBuilder<int>(
                        valueListenable: remainingSpace,
                        builder: addDocumentLabel)
                  ])),
          appBar: AppBar(
              leadingWidth: hp.leadingWidth,
              leading: const LeadingWidget(visible: false),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('View Property',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }

  void requestAccessAPI(String propID, String userId, String propUserid) async {
    try {
      Loader.show(context);
      final v = await api.requestAccessSecond(propID, userId, propUserid);
      Loader.hide();
      hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      }, action: v.message, type: AlertType.cupertino, title: 'Request Access');
      // final fl = await revealToast(v.message);
      if (v.success) {}
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }

  Widget emtyValueBuilder(BuildContext context, int c, Widget? child) {
    final hp = Helper.of(context);
    var list = [
      TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text('S.No', style: hp.textTheme.bodyText1),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
            child: Text('Document', style: hp.textTheme.bodyText1),
          ),
        ),
      ], decoration: const BoxDecoration(color: Colors.black26))
    ];

    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(7),
        },
        textDirection: TextDirection.ltr,
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Property>(
        builder: pageBuilder,
        valueListenable: props,
        child: const BottomWidget());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (parseBool(widget.rar.content)) {
      log('object');
      final p = widget.rar.params as Property;
      log(p);
      log('params check');
      con.getPropertyData(p);
    }
    con.waitForDocuments(property: widget.rar.params);
  }

  Table tableListStructure(List<Document> lists) {
    var list = lists
        .map((item) => TableRow(
                children: [
                  TableCell(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: GestureDetector(
                        child: Text(item.docName,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: hp.theme.focusColor)),
                        onTap: () {
                          docs.value = item;
                          item.onChange();
                          log((props.value.fullAddress +
                              props.value.address +
                              props.value.address2 +
                              props.value.address1 +
                              props.value.showAddress));
                          hp.goTo('/document_details', vcb: () {
                            didUpdateWidget(widget);
                          },
                              args: RouteArgument(
                                  tag: item.docName,
                                  id: props.value.userID ==
                                          currentUser.value.userID
                                      ? 0
                                      : 1,
                                  content: props.value.fullAddress));
                        }),
                  )),
                  TableCell(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: hp.width / 40,
                              top: hp.height / 100,
                              bottom: hp.height / 100),
                          child: Text(item.type.type,
                              textScaleFactor: 1.0,
                              style: const TextStyle(
                                fontSize: 16,
                              ))))
                ],
                decoration: const BoxDecoration(
                    color: /*con.documents!.indexOf(item) % 2 == 0
                    ?*/
                        Colors.white /*: Colors.black12*/)))
        .toList();
    list.insert(
      0,
      TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cert. Name',
                    textScaleFactor: 1.0, style: TextStyle(fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 22,
                      child: IconButton(
                        // iconSize: 22,
                        icon: const Icon(Icons.arrow_circle_up_outlined),
                        splashColor: Colors.transparent,
                        onPressed: () {
                          sortFuntionA2Z(con.documents as List<Document>);
                        },
                      ),
                    ),
                    // const SizedBox(width: ,),
                    SizedBox(
                        width: 22,
                        child: IconButton(
                          // iconSize: 22,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          splashColor: Colors.transparent,
                          onPressed: () {
                            //  list.sort((List<Document> doc) => doc.reversed.toList(),);
                            // list.sort(((List<Document> a,List<Document> b) => a[''].)
                            sortFuntionZ2A(con.documents as List<Document>);
                          },
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
                //   child: ,
                // ),
                const Text('Cert. Type',
                    textScaleFactor: 1.0, style: TextStyle(fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 22,
                      child: IconButton(
                        // iconSize: 22,
                        icon: const Icon(Icons.arrow_circle_up_outlined),
                        splashColor: Colors.transparent,
                        onPressed: () {
                          sortTypeA2Z(con.documents as List<Document>);
                        },
                      ),
                    ),
                    SizedBox(
                        width: 22,
                        child: IconButton(
                          // iconSize: 22,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          splashColor: Colors.transparent,
                          onPressed: () {
                            //  list.sort((List<Document> doc) => doc.reversed.toList(),);
                            // list.sort(((List<Document> a,List<Document> b) => a[''].)
                            sortTyhpeZ2A(con.documents as List<Document>);
                          },
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ], decoration: const BoxDecoration(color: Colors.black26)),
    );
    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(4),
        },
        textDirection: TextDirection.ltr,
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

  void sortFuntionA2Z(List<Document> lists) {
    lists.sort(
      (a, b) => a.docName.compareTo(b.docName),
    );
    log(lists[0].docName);
    tableListStructure(lists);
    setState(() {
      tableListStructure(lists);
    });
  }

  void sortFuntionZ2A(List<Document> lists) {
    lists.sort(
      (a, b) => b.docName.compareTo(a.docName),
    );
    log(lists[0].docName);
    setState(() {
      tableListStructure(lists);
    });
  }

  void sortTypeA2Z(List<Document> lists) {
    lists.sort(
      (a, b) => a.type.type.compareTo(b.type.type),
    );
    log(lists[0].docName);
    tableListStructure(lists);
    setState(() {
      tableListStructure(lists);
    });
  }

  void sortTyhpeZ2A(List<Document> lists) {
    lists.sort(
      (a, b) => b.type.type.compareTo(a.type.type),
    );
    log(lists[0].docName);
    setState(() {
      tableListStructure(lists);
    });
  }

  Widget emptyBuilder(BuildContext context, int c, Widget? child) {
    var list = [
      TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cert. Name',
                    textScaleFactor: 1.0, style: TextStyle(fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 22,
                      child: IconButton(
                        // iconSize: 22,
                        icon: const Icon(Icons.arrow_circle_up_outlined),
                        splashColor: Colors.transparent,
                        onPressed: con.documents?.isEmpty ?? true
                            ? null
                            : () {
                                sortFuntionA2Z(con.documents as List<Document>);
                              },
                      ),
                    ),
                    // const SizedBox(width: ,),
                    SizedBox(
                        width: 22,
                        child: IconButton(
                          // iconSize: 22,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          splashColor: Colors.transparent,
                          onPressed: con.documents?.isEmpty ?? true
                              ? null
                              : () {
                                  //  list.sort((List<Document> doc) => doc.reversed.toList(),);
                                  // list.sort(((List<Document> a,List<Document> b) => a[''].)
                                  sortFuntionZ2A(
                                      con.documents as List<Document>);
                                },
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
                //   child: ,
                // ),
                const Text('Cert. Type',
                    textScaleFactor: 1.0, style: TextStyle(fontSize: 17)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 22,
                      child: IconButton(
                        // iconSize: 22,
                        icon: const Icon(Icons.arrow_circle_up_outlined),
                        splashColor: Colors.transparent,
                        onPressed: con.documents?.isEmpty ?? true
                            ? null
                            : () {
                                sortTypeA2Z(con.documents as List<Document>);
                              },
                      ),
                    ),
                    SizedBox(
                        width: 22,
                        child: IconButton(
                          // iconSize: 22,
                          icon: const Icon(Icons.arrow_circle_down_outlined),
                          splashColor: Colors.transparent,
                          onPressed: con.documents?.isEmpty ?? true
                              ? null
                              : () {
                                  //  list.sort((List<Document> doc) => doc.reversed.toList(),);
                                  // list.sort(((List<Document> a,List<Document> b) => a[''].)
                                  sortTyhpeZ2A(con.documents as List<Document>);
                                },
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ], decoration: const BoxDecoration(color: Colors.black26)),
    ];

    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(4),
        },
        textDirection: TextDirection.ltr,
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

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    con.waitForDocuments(property: widget.rar.params);
  }
}
