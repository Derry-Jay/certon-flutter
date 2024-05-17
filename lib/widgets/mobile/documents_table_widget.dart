import '../../backend/api.dart';
import '../../helpers/helper.dart';
import '../../models/document.dart';
import '../../models/property.dart';
import 'package:flutter/material.dart';
import '../../models/route_argument.dart';
import '../../widgets/custom_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../widgets/mobile/hyperlink_text.dart';
import '../../mobile_screens/property_details_screen.dart';
import '../../controllers/property_and_document_controller.dart';

class DocumentsTableWidget extends StatefulWidget {
  final Property? property;
  const DocumentsTableWidget({Key? key, this.property}) : super(key: key);

  static PropertyDetailsScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<PropertyDetailsScreenState>();

  @override
  DocumentsTableWidgetState createState() => DocumentsTableWidgetState();
}

class DocumentsTableWidgetState extends StateMVC<DocumentsTableWidget> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  PropertyDetailsScreenState? get pds => DocumentsTableWidget.of(context);
  DocumentsTableWidgetState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  Widget otherBuilder(BuildContext context, int c, Widget? child) {
    return Visibility(
        visible: c > 0,
        child: HyperLinkText(
            text: 'Add a New Document',
            onTap: () {
              hp.goTo('/add_or_edit_document', vcb: () {
                didUpdateWidget(widget);
              });
            }));
  }

  Widget emptyBuilder1(BuildContext context, int c, Widget? child) {
    return GestureDetector(
        child: Center(
            heightFactor: hp.height / 250,
            child: Text(
                'No Documents Found. ${c > 0 ? 'Tap' : 'Purchase More Storage'} to add one.${c > 0 ? '' : ' To buy more storage, login to your account through web.'}')),
        onTap: () {
          c > 0
              ? hp.goTo('/add_or_edit_document', vcb: () {
                  didUpdateWidget(widget);
                })
              : log('Hi');
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: con.documents == null
            ? Center(
                heightFactor: hp.height / 250,
                child: CustomLoader(
                    sizeFactor: 10,
                    duration: const Duration(seconds: 10),
                    color: hp.theme.primaryColor,
                    loaderType: LoaderType.fadingCircle))
            : (con.documents!.isEmpty
                ? ValueListenableBuilder<int>(
                    valueListenable: remainingSpace, builder: emptyBuilder)
                : tableListStructure(con.documents ?? [])));
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
                          hp.goTo('/document_details',
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.waitForDocuments(property: widget.property);
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    con.waitForDocuments(property: widget.property);
  }

  // Table tableStructure(BuildContext context, List<Document> document) {
  //  final hp = Helper.of(context);

  //  return  Table(
  //                   // defaultColumnWidth: const FixedColumnWidth(200.0),
  // columnWidths: const {
  //         0: FlexColumnWidth(4),
  //         1: FlexColumnWidth(4),
  //       },
  //       textDirection: TextDirection.ltr,
  //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  // border: TableBorder.all(
  //                 color: Colors.black,
  //                 style: BorderStyle.solid,
  //                 width: 1),

  //                   children: [
  // TableRow(children: [
  //           TableCell(child:
  //                 Padding(child:
  //                 Text('Name', style: hp.textTheme.bodyText1),
  //                 padding: const EdgeInsets.only(left: 20,top: 15,bottom: 10),),
  //                         verticalAlignment: TableCellVerticalAlignment.middle,
  //                   ),
  //           TableCell(child:
  //                 Padding(child:
  //                 Text('Type', style: hp.textTheme.bodyText1),
  //                 padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),),
  //                         verticalAlignment: TableCellVerticalAlignment.middle,
  //                   ),
  // ], decoration: const BoxDecoration(color: Colors.black26)),

  //                       newTableRows(context, document)
  //                   ]

  //   );
  // }

  // TableRow newTableRows(BuildContext context, List<Document> document) {
  //    final hp = Helper.of(context);
  //  if (!(con.documents == null || con.documents!.isEmpty)) {
  //        log(con.documents?.length ?? 0);
  //    // for (Document item in con.documents!) {
  //     //  log();

  //              return TableRow(children: [
  //                   TableCell(child:
  //                          Padding(child:
  //                          HyperLinkText(

  //                                 text: con.documents[index].docName      // item.docName,
  //                                 onTap: () {
  //                                   docs.value = item;
  //                                   item.onChange();
  //                                   hp.goTo('/document_details');
  //                                 }),
  //                          padding: EdgeInsets.only(left: 0,top: 5,bottom: 5),),
  //                                  verticalAlignment: TableCellVerticalAlignment.middle,
  //                           ),
  //                   TableCell(child: Padding(child:
  //                          Text(item.type.type),
  //                            padding: EdgeInsets.only(left: 0,top: 5,bottom: 5)),
  //                       verticalAlignment: TableCellVerticalAlignment.middle,)
  // ], decoration: BoxDecoration(
  // color: /*con.documents!.indexOf(item) % 2 == 0
  //     ?*/ Colors.white
  //     /*: Colors.black12*/)

  //                   );
  //     //  }
  //       // return TableRow();
  //     }  else {
  //       return TableRow();
  //     }
  // }

}
