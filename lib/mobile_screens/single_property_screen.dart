import '../backend/api.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/route_argument.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/loader.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/mobile/documents_table_widget.dart';
import '../controllers/property_and_document_controller.dart';

class SinglePropertyScreen extends StatefulWidget {
  final RouteArgument rar;
  const SinglePropertyScreen({Key? key, required this.rar}) : super(key: key);
  @override
  SinglePropertyScreenState createState() => SinglePropertyScreenState();
}

class SinglePropertyScreenState extends StateMVC<SinglePropertyScreen> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  SinglePropertyScreenState() : super(PropertyAndDocumentController()) {
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
            ));

  Widget addDocumentLabel(BuildContext context, int count, Widget? child) =>
      Visibility(
          visible: count != 0,
          child: GestureDetector(
            child: Text('Add a new document',
                style: TextStyle(
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                    color: hp.theme.focusColor)),
            onTap: () {
              log(con.p?.propID);
              log(con.p?.userID);
              props.value = con.p!;
              props.notifyListeners();
              hp.goTo('/add_or_edit_document', vcb: () {
                con.waitForDocuments(property: con.p!);
              });
            },
          ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final p = widget.rar.params as Property;
    getPropertyData(p);
  }

  void getPropertyData(Property property) async {
    try {
      final val = await api.getSinglePropertyData(property);
      log(val);
      log('val');
      setState(() {
        con.p = val;
        props.value = con.p!;
        props.notifyListeners();
      });
    } catch (e) {
      sendAppLog(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.rar.params);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          //  key: hp.key,
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          bottomNavigationBar: const BottomWidget(),
          body: con.p == null
              ? CustomLoader(
                  duration: const Duration(seconds: 10),
                  color: hp.theme.primaryColor,
                  loaderType: LoaderType.fadingCircle)
              : SingleChildScrollView(
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
                            child: Text('Property owned by ${con.p?.ownerName}',
                                textScaleFactor: 1.0,
                                style: const TextStyle(fontSize: 17))),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: EdgeInsets.zero,
                            child: Text(con.p?.fullAddress ?? '',
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
                                child: Text(con.p?.ownerName ?? '',
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
                                child: Text(con.p?.zipCode ?? '',
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
                                child: Text(con.p?.date ?? '',
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
                                child: Text(con.p?.type.type ?? '',
                                    textScaleFactor: 1.0,
                                    style: const TextStyle(fontSize: 17)),
                              )
                            ],
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text('QR Code Added On: ',
                        //             style: hp.textTheme.bodyText1),
                        //         const SizedBox(
                        //           height: 15,
                        //         ),
                        //         Text('Property Type:    ',
                        //             style: hp.textTheme.bodyText1),
                        //       ],
                        //     ),
                        //     const SizedBox(
                        //       width: 100,
                        //     ),

                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(property.date,
                        //             style: hp.textTheme.bodyText1),
                        //         const SizedBox(
                        //           height: 15,
                        //         ),
                        //         Text(property.type.type,
                        //             style: hp.textTheme.bodyText1),
                        //       ],
                        //     ),

                        //     //  Text('QR Code Added On: ',
                        //     //   style: hp.textTheme.bodyText1),
                        //     //    SizedBox(width: 100,),
                        //     //    Text(property.date,
                        //     //   style: hp.textTheme.bodyText1),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Row(children: [
                        //    Text('Property Type:    ',
                        //     style: hp.textTheme.bodyText1),
                        //      SizedBox(width: 100,),
                        //      Text(property.type.type,
                        //     style: hp.textTheme.bodyText1),
                        // ], mainAxisAlignment: MainAxisAlignment.start,),

                        // Visibility(
                        //     visible: !parseBool(widget.rar.id.toString()),
                        //     child:
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
                            // ),
                            onTap: () {
                              // currentUser.value.userID == property.userID
                              //     ?
                              hp.goTo('/edit_property',
                                  args: RouteArgument(
                                      id: 1,
                                      params: con.p,
                                      tag: 'true',
                                      content: widget.rar.content));
                              // : log('Hi');
                            }),

                        // ),

                        const Text('Property Saved Documents',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        DocumentsTableWidget(property: con.p),
                        Visibility(
                            visible:
                                currentUser.value.userID != con.p?.userID &&
                                    currentUser.value.isContractor &&
                                    widget.rar.content == null &&
                                    !parseBool(widget.rar.id.toString()),
                            child: GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text('Request Access Permission',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          fontSize: 17,
                                          decoration: TextDecoration.underline,
                                          color: hp.theme.focusColor)),
                                ),
                                onTap: () {
                                  if (currentUser.value.userID !=
                                      con.p?.userID) {
                                    requestAccessAPI(
                                        con.p?.propID.toString() ?? '',
                                        con.p?.userID.toString() ?? '',
                                        currentUser.value.userID.toString());
                                  } else {
                                    log('Hi');
                                  }
                                })),
                        ValueListenableBuilder<int>(
                            valueListenable: remainingSpace,
                            builder: textBuilder),
                        ValueListenableBuilder<int>(
                            valueListenable: remainingSpace,
                            builder: addDocumentLabel)
                      ]))

          /*SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: hp.width / 25, vertical: hp.height / 50),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('View Property:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: hp.height / 50),
                            child: Text(con.p!.fullAddress,
                                style: hp.textTheme.bodyText1)),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text('Property owned by ${con.p!.ownerName}',
                                style: hp.textTheme.bodyText1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('QR Code Added On: ',
                                    style: hp.textTheme.bodyText1),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text('Property Type:    ',
                                    style: hp.textTheme.bodyText1),
                              ],
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(con.p!.date, style: hp.textTheme.bodyText1),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(con.p!.type.type,
                                    style: hp.textTheme.bodyText1),
                              ],
                            ),
    
                            //  Text('QR Code Added On: ',
                            //   style: hp.textTheme.bodyText1),
                            //    SizedBox(width: 100,),
                            //    Text(property.date,
                            //   style: hp.textTheme.bodyText1),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Row(children: [
                        //    Text('Property Type:    ',
                        //     style: hp.textTheme.bodyText1),
                        //      SizedBox(width: 100,),
                        //      Text(property.type.type,
                        //     style: hp.textTheme.bodyText1),
                        // ], mainAxisAlignment: MainAxisAlignment.start,),
    
                        GestureDetector(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 20, bottom: 20),
                                child: Visibility(
                                  visible:
                                      currentUser.value.userID == con.p!.userID,
                                  child: Text('Edit this Property',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: hp.theme.focusColor)),
                                )),
                            onTap: () {
                              props.value = con.p ?? Property.emptyProperty;
                              props.value.onChange();
                              currentUser.value.userID == con.p!.userID
                                  ? hp.goTo('/edit_property',
                                      args: RouteArgument(
                                          id: 0,
                                          params: con.p,
                                          tag: 'false'), vcb: () {
                                      getPropertyData(con.p!);
                                    })
                                  : log('Hi');
                            }),
    
                        const Text('Property Saved Documents',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        DocumentsTableWidget(property: con.p!),
                        // GestureDetector(
                        //     child: Padding(
                        //         padding:
                        //             const EdgeInsets.only(left: 0, top: 5, bottom: 5),
                        //         child: Visibility(
                        //           visible:
                        //               currentUser.value.userID != property.userID,
                        //           child: Text('Request Access Permission',
                        //               style: TextStyle(
                        //                   decoration: TextDecoration.underline,
                        //                   color: hp.theme.focusColor)),
                        //         )),
                        //     onTap: () {
                        //       if (currentUser.value.userID != property.userID) {
                        //         // requestAccessAPI(
                        //         //     property.propID.toString(),
                        //         //     property.userID.toString(),
                        //         //     currentUser.value.userID.toString());
                        //       } else {
                        //       }
                        //     }),
                        ValueListenableBuilder<int>(
                            valueListenable: remainingSpace,
                            builder: textBuilder),
                        ValueListenableBuilder<int>(
                            valueListenable: remainingSpace,
                            builder: addDocumentLabel),
                      ]))*/
          ,
          appBar: AppBar(
              leadingWidth: hp.leadingWidth,
              leading: const LeadingWidget(visible: false),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('View Property',
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
      if (v.success) {}
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }
}
