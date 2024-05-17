import '../backend/api.dart';
import '../helpers/helper.dart';
import '../models/document.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentDetailsScreen extends StatelessWidget {
  final RouteArgument rar;
  const DocumentDetailsScreen({Key? key, required this.rar}) : super(key: key);

  Widget pageBuilder(BuildContext context, Document document, Widget? child) {
    final hp = Helper.of(context);
    log(document.toString());
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          bottomNavigationBar: child,
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: hp.width / 25, vertical: hp.height / 50),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'View Document: ',
                   textScaleFactor: 1.0,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${rar.tag} at ${rar.content ?? document.address}',
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 17),
                ),
    
                const SizedBox(
                  height: 15,
                ),
                tableStructure(context, document),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                      width: hp.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text('Document Name: ',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                          ),
                          // const Expanded(
                          //     flex: 2,
                          //     child: SizedBox(
                          //       width: 20,
                          //     )),
                          Expanded(
                            flex: 4,
                            child: Text(document.docName,
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
                            child: Text('Document Type: ',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                          ),
                          // const Expanded(
                          //     flex: 2,
                          //     child: SizedBox(
                          //       width: 20,
                          //     )),
                          Expanded(
                            flex: 4,
                            child: Text(document.type.type,
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
                            child: Text('Expiry Date: ',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17)),
                          ),
                          // const Expanded(
                          //     flex: 2,
                          //     child: SizedBox(
                          //       width: 20,
                          //     )),
                          Expanded(
                            flex: 4,
                            child: Text(document.expiryDate,
                                textScaleFactor: 1.0,
                                style: const TextStyle(fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
    
                Visibility(
                    visible: !parseBool(rar.id.toString()) ||
                        document.userID == currentUser.value.userID,
                    child: GestureDetector(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 0, top: 20, bottom: 20),
                          child: Text('Edit Document',
                          textScaleFactor: 1.0,
                              style: TextStyle(
                                   fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  color: hp.theme.focusColor)),
                        ),
                        onTap: () {
                          hp.goTo('/edit_document_screen', args: docs.value);
                        })),
    
                // HyperLinkText(
                //     text: 'Edit Document',
                //     onTap: () {
                //       hp.goTo('/add_or_edit_document', args: docs.value);
                //     })
              ])),
          //           key: hp.key,
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              //  leadingWidth: 200,
              //    leading: Row(children: [
              //     const SizedBox(width: 15,),
              //      GestureDetector(child:
              //       Row(children: const [
              //         Icon(Icons.arrow_back_ios),
              //       Text('Back'),
              //      ],)
              //      ,onTap: hp.goBack),
    
              //      const SizedBox(width: 15,),
              //         GestureDetector(child:
              //         const Icon(Icons.dehaze),
              //         onTap: () => hp.key.currentState!.openDrawer(),
              //         )
              //    ],),
              leadingWidth: hp.leadingWidth,
              leading: const LeadingWidget(visible: false),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('View Document',
              textScaleFactor: 1.0,
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Document>(
        valueListenable: docs,
        builder: pageBuilder,
        child: const BottomWidget());
  }

  Widget tableStructure(BuildContext context, Document document) {
    final hp = Helper.of(context);

    var list = (document.files)
        .map((item) => TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 5, bottom: 5),
                      child:
                          Text((document.files.indexOf(item) + 1).toString(), textScaleFactor: 1.0, style: const TextStyle(fontSize: 17),),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            Icon(Icons.description,
                                color: hp.theme.secondaryHeaderColor),
                            Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                     log(Uri.tryParse(document.sharedurl /*+ document.files[
                                              document.files.indexOf(item)]*/) ??
                                          Uri());
                                      if (await launchUrl(Uri.tryParse(document
                                            .sharedurl /*+
                                        document
                                                  .files[
                                              document.files.indexOf(item)]*/) ??
                                          Uri())) {
                                        log('Welcome');
                                      }
                                  },
                                  child: Text(document
                                        .files[document.files.indexOf(item)]
                                        .split('/')
                                        .last,textScaleFactor: 1.0, style: const TextStyle(fontSize: 17, decoration: TextDecoration.underline, color: Colors.blue),),)
                                
                                
                                // HyperLinkText(
                                //     text: document
                                //         .files[document.files.indexOf(item)]
                                //         .split('/')
                                //         .last,
                                //     onTap: () async {
                                //       log(Uri.tryParse(document.files[
                                //               document.files.indexOf(item)]) ??
                                //           Uri());
                                //       if (await launchUrl(Uri.tryParse(document
                                //                   .files[
                                //               document.files.indexOf(item)]) ??
                                //           Uri())) {
                                //         log('Welcome');
                                //       }
                                //     })
                                    )
                          ],
                        )),
                  )
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
            child: Text('S.No', textScaleFactor: 1.0, style: TextStyle(fontSize: 17)),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
            child: Text('Document', textScaleFactor: 1.0, style: TextStyle(fontSize: 17)),
          ),
        ),
      ], decoration: BoxDecoration(color: Colors.black26)),
    );

    return document.files.isEmpty
        ? ValueListenableBuilder<int>(
            valueListenable: remainingSpace, builder: emtyValueBuilder)
        : Table(
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
}
