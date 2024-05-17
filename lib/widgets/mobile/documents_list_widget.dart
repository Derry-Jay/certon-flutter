import 'hyperlink_text.dart';
import '../../backend/api.dart';
import 'document_item_widget.dart';
import '../../helpers/helper.dart';
import '../../models/document.dart';
import '../../models/property.dart';
import 'all_document_item_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../mobile_screens/property_details_screen.dart';
import '../../controllers/property_and_document_controller.dart';

class DocumentsListWidget extends StatefulWidget {
  final Property? property;
  const DocumentsListWidget({Key? key, this.property}) : super(key: key);

  static PropertyDetailsScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<PropertyDetailsScreenState>();

  @override
  DocumentsListWidgetState createState() => DocumentsListWidgetState();
}

class DocumentsListWidgetState extends StateMVC<DocumentsListWidget> {
  late PropertyAndDocumentController con;

  Helper get hp => Helper.of(context);

  PropertyDetailsScreenState? get pds => DocumentsListWidget.of(context);
  DocumentsListWidgetState() : super(PropertyAndDocumentController()) {
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

  Widget getItem(BuildContext context, int index) {
    return index == con.documents!.length
        ? ValueListenableBuilder<int>(
            valueListenable: remainingSpace, builder: otherBuilder)
        : (widget.property == null
            ? AllDocumentItemWidget(document: con.documents![index])
            : DocumentItemWidget(document: con.documents![index]));
  }

  Widget emptyBuilder(BuildContext context, int c, Widget? child) {
    return GestureDetector(
        child: Container(
            width: MediaQuery.of(context).size.width,
            // height: (con.documents?.length ?? 0) * 224,
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            decoration: BoxDecoration(
                // color:  Colors.grey[350],
                border: Border.all(color: Colors.black)),
            child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No Documents Found.',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 17),
                ))),
        onTap: () {});
  }

  @override
  Widget build(BuildContext context) {
    return con.documents == null
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
            : hp.isTablet
                ? tableStructure(context)
                : hp.dimensions.orientation == Orientation.landscape
                    ? tableStructure(context)
                    : mobiletableStructure(context));
  }

  Widget emtyValueBuilder(BuildContext context, int c, Widget? child) {
    var list = [
      const TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Name',
                textScaleFactor: 1.0,
                // style: TextStyle(fontSize: 17)
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Type',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('View Online',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Expiration Date',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Property',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Download',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
          ),
        ),
      ], decoration: BoxDecoration(color: Colors.black26))
    ];

    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(6),
          3: FlexColumnWidth(4),
          4: FlexColumnWidth(5),
          5: FlexColumnWidth(6)
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

  Widget sheetBuilder(BuildContext context) => ListView.builder(
      itemBuilder: tileBuilder, itemCount: con.documents?.first.files.length);

  Widget tileBuilder(BuildContext context, int index) {
    final hp = Helper.of(context);
    return ListTile(
        title: HyperLinkText(
            text: con.documents?.first.files[index].split('/').last ?? '',
            onTap: () {
              hp.goBack(result: con.documents?.first.files[index]);
            }),
        leading: Icon(Icons.description, color: hp.theme.secondaryHeaderColor));
  }

  Widget tableStructure(BuildContext context) {
    final hp = Helper.of(context);
    log(con.documents);
    var list = (con.documents as List<Document>)
        .map((item) => TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                      child: Text(item.docName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal)),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                      child: Text(item.type.type,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal)),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                        child: SizedBox(
                          height: item.files.length * 45,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: item.files.length,
                            itemBuilder: (context, index) => GestureDetector(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: hp.isTablet ? 20 : 5,
                                    ),
                                    Text('View Document',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: hp.theme.focusColor)),
                                  ],
                                ),
                                onTap: () async {
                                  if (await launchUrl(Uri.tryParse(
                                          item.sharedurl /*+
                                              item.files[index]*/
                                          ) ??
                                      Uri())) {
                                    log('Welcome');
                                  }
                                }),
                          ),
                        )),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                        child: Text(item.expiryDate,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal))),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                        child: Text(item.address,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal))),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 0, bottom: 0),
                        child: SizedBox(
                          height: item.files.length * 60,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: item.files.length,
                            itemBuilder: (context, index) => GestureDetector(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Download a copy',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: hp.theme.focusColor)),
                                  ],
                                ),
                                onTap: () async {
                                  if (item.files.length == 1) {
                                    final p = await launchUrl(Uri.tryParse(
                                            item.sharedurl /*+
                                                 item.files.single*/
                                            ) ??
                                        Uri());
                                    log(p ? 'Hi' : 'Bye');
                                  } else {
                                    final uri =
                                        await showModalBottomSheet<String>(
                                                context: context,
                                                builder: sheetBuilder) ??
                                            '';
                                    if (uri.isNotEmpty) {
                                      final r = await launchUrl(
                                          Uri.tryParse(uri) ?? Uri());
                                      if (r) log(uri);
                                    }
                                  }
                                }),
                          ),
                        )),
                  ),
                ],
                decoration: BoxDecoration(
                    color: con.documents!.indexOf(item) % 2 == 0
                        ? Colors.white
                        : Colors.black12.withAlpha(20))))
        .toList();

    list.insert(
      0,
      const TableRow(children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Type',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('View Online',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Expiration Date',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Property',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 0, top: 15, bottom: 10),
            child: Text('Download',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          ),
        ),
      ], decoration: BoxDecoration(color: Colors.black26)),
    );
    return Table(
        children: list,
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(6),
          3: FlexColumnWidth(4),
          4: FlexColumnWidth(5),
          5: FlexColumnWidth(6)
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
  void initState() {
    super.initState();
    con.waitForDocuments(property: widget.property);
  }

  // @override
  // void didUpdateWidget(covariant StatefulWidget oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   con.waitForDocuments(property: widget.property);
  // }

  Widget mobiletableStructure(BuildContext context) {
    final hp = Helper.of(context);
    log(con.documents);
    log(double.infinity);
    log('double.infinity');
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Container(
            // height: (con.documents?.length ?? 0) * 224,
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            decoration: BoxDecoration(
                // color:  Colors.grey[350],
                border: Border.all(color: Colors.black)),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: con.documents?.length ?? 0,
              itemBuilder: (context, index) {
                var item = con.documents?[index];
                return Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  color: con.documents!.indexOf(item!) % 2 == 0
                      ? Colors.white
                      : Colors.black12.withAlpha(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('Name : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          // const SizedBox(width: 100,),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(item.docName,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('Type : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          // const SizedBox(width: 100,),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(item.type.type,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('View Online : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          // const SizedBox(width: 100,),

                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: ListView.builder(
                                  itemCount: item.files.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: hp.isTablet ? 20 : 5,
                                            ),
                                            Text('View Document',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color:
                                                        hp.theme.focusColor)),
                                          ],
                                        ),
                                        onTap: () async {
                                          if (await launchUrl(Uri.tryParse(
                                                  item.sharedurl /*+
                                                      item.files[index]*/
                                                  ) ??
                                              Uri())) {
                                            log('Welcome');
                                          }
                                        });
                                  }),
                            ),
                          ),
                          //  Flexible(
                          //   child: Container(padding: const EdgeInsets.only(left: 5), child:  Text(item.type.type ,
                          //          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),)
                          //  ,),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            //  flex: 8,
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('Expiration Date : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          // const SizedBox(width: 100,),
                          Flexible(
                            // flex: 8,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(item.expiryDate,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            // flex: 4,
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('Property : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          // const SizedBox(width: 100,),
                          Flexible(
                            // flex: 8,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(item.address,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            // flex: 4,
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text('Download : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: ListView.builder(
                                  itemCount: item.files.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: hp.isTablet ? 20 : 5,
                                            ),
                                            Text('Download a copy',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color:
                                                        hp.theme.focusColor)),
                                          ],
                                        ),
                                        onTap: () async {
                                          if (item.files.length == 1) {
                                            final p = await launchUrl(Uri.tryParse(
                                                    item.sharedurl /*+
                                                        item.files.single*/
                                                    ) ??
                                                Uri());
                                            log(p ? 'Hi' : 'Bye');
                                          } else {
                                            final uri =
                                                await showModalBottomSheet<
                                                            String>(
                                                        context: context,
                                                        builder:
                                                            sheetBuilder) ??
                                                    '';
                                            if (uri.isNotEmpty) {
                                              final r = await launchUrl(
                                                  Uri.tryParse(uri) ?? Uri());
                                              if (r) log(uri);
                                            }
                                          }
                                        });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                var item = con.documents?[index];
                return Container(
                  height: 10,
                  color: con.documents!.indexOf(item!) % 2 == 0
                      ? Colors.white
                      : Colors.black12.withAlpha(20),
                );
              },
            ),
          ),
        ));
  }
}
