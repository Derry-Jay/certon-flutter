import 'dart:async';

// import 'package:http/http.dart';

import '../widgets/loader.dart';

import '../backend/api.dart';
import '../helpers/helper.dart';
import '../models/document.dart';
import '../models/property.dart';
import '../models/document_type.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/mobile/my_labelled_button.dart';
import '../controllers/property_and_document_controller.dart';

class EditDocumentScreen extends StatefulWidget {
  final Document? document;
  const EditDocumentScreen({Key? key, this.document}) : super(key: key);

  @override
  EditDocumentScreenState createState() => EditDocumentScreenState();
}

class EditDocumentScreenState extends StateMVC<EditDocumentScreen> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  ImagePicker picker = ImagePicker();
  List<XFile> imagesList = [];

  DateTime valueOfDate = DateTime.now();

  EditDocumentScreenState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  DropdownMenuItem<DocumentType> getDropdownItem(DocumentType e) =>
      DropdownMenuItem<DocumentType>(
          value: e,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 6,
                    child: Text(e.type),
                  ),
                  Flexible(
                      flex: 1,
                      child: Visibility(
                          visible: con.dt == e,
                          child: const Icon(Icons.check, color: Colors.blue)))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              )
            ],
          ));

  Widget pageBuilder(BuildContext context, Property property, Widget? child) {
    return otherScaffolds(context, property, child);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Property>(
        valueListenable: props,
        builder: pageBuilder,
        child: const BottomWidget());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.setDoc(document: widget.document);
    hp.getConnectStatus();
    con.waitForDocumentTypes();
    // con.abc.text = con.pt?.type ?? '';
  }

  Widget otherScaffolds(
      BuildContext context, Property property, Widget? child) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery(
          data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .copyWith(boldText: false, textScaleFactor: 1.0),
          child: Scaffold(
            appBar: AppBar(
                leadingWidth: hp.leadingWidth,
                leading: const LeadingWidget(visible: false),
                elevation: 0,
                centerTitle: true,
                backgroundColor: hp.theme.primaryColor,
                foregroundColor: hp.theme.scaffoldBackgroundColor,
                title: const Text('Edit Document',
                    style: TextStyle(fontWeight: FontWeight.w600))),
            drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
            bottomNavigationBar: const BottomWidget(),
            body: viewLoad(context, property, child),
          ),
        ));
  }

  Widget viewLoad(BuildContext context, Property property, Widget? child) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Document:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(
            height: 15,
          ),

          const Text(
            'Document Name',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
              controller: con.nc,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: hp.height / 100, horizontal: hp.width / 40),
                  border: const OutlineInputBorder(),
                  hintText: 'Document Name')),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Document Type',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          con.kinds == null
              ? CustomLoader(
                  duration: const Duration(seconds: 10),
                  color: hp.theme.primaryColor,
                  loaderType: LoaderType.fadingCircle)
              : textFormField(),

          // DropdownButtonFormField<DocumentType>(
          //   // itemHeight: 300,
          //   menuMaxHeight: 450,
          //     isExpanded: true,
          //     selectedItemBuilder: (BuildContext context) {
          //           return con.kinds!
          //               .map((DocumentType e) {
          //             return Text(e.type, overflow: TextOverflow.ellipsis,);
          //           }).toList();
          //         },
          //     decoration: InputDecoration(
          //         contentPadding: EdgeInsets.symmetric(
          //             horizontal: hp.width / 32, vertical: hp.height / 64),
          //         hintText: 'Select a Document Type',
          //         border: const OutlineInputBorder()),
          //     iconSize: hp.radius / 50,
          //     value: con.dt,
          //     items: con.kinds!.map(getDropdownItem).toList(),
          //     onChanged: con.onSelected),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Expiration Date',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
              readOnly: true,
              controller: con.dc,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: hp.height / 100, horizontal: hp.width / 40),
                  border: const OutlineInputBorder(),
                  hintText: 'Expiration Date'),
              onTap: () async {
                final dt = await getDatePicker(
                    dateType: DateType.death,
                    dateTime: valueOfDate,
                    alertType: AlertType.cupertino,
                    context: context);
                valueOfDate = dt;
                con.dc.text = putDateToString(dt);
              }),

          const SizedBox(
            height: 20,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      addYearsToDateString(con.dc, 1,
                          initialYear: int.tryParse(
                              widget.document?.boughtDate.split('-').first ??
                                  ''));
                      var listreplace = con.dc.text.replaceAll('/', '-');
                      var splitlist = listreplace.split('-');
                      log(splitlist);
                      List<String> reversedList = splitlist.reversed.toList();
                      log(reversedList);
                      if (reversedList[1].characters.length == 1) {
                        reversedList[1] = '0${reversedList[1]}';
                      }
                      if (reversedList[2].characters.length == 1) {
                        reversedList[2] = '0${reversedList[2]}';
                      }
                      var joinList = reversedList.join('-');
                      log(joinList);
                      DateTime now = DateTime.now();
                      var second = '${now.second}';
                      var hour = '${now.hour}';
                      var minute = '${now.minute}';
                      if (now.second.toString().length == 1) {
                        second = '0$second';
                      }
                      if (now.hour.toString().length == 1) {
                        hour = '0$hour';
                      }
                      if (now.minute.toString().length == 1) {
                        minute = '0$minute';
                      }
                      var withTime = '$hour:$minute:$second';
                      var joiningValue = '$joinList $withTime';
                      log(joiningValue);
                      //log(con.dc.text.replaceAll('/', '-'));
                      log(DateTime.parse(joiningValue));
                      valueOfDate = DateTime.parse(joiningValue);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(hp.theme.primaryColor)),
                    child: const Text(
                      '+1 year',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      addYearsToDateString(con.dc, 5,
                          initialYear: int.tryParse(
                              widget.document?.boughtDate.split('-').first ??
                                  ''));
                      var listreplace = con.dc.text.replaceAll('/', '-');
                      var splitlist = listreplace.split('-');
                      log(splitlist);
                      List<String> reversedList = splitlist.reversed.toList();
                      log(reversedList);
                      if (reversedList[1].characters.length == 1) {
                        reversedList[1] = '0${reversedList[1]}';
                      }
                      if (reversedList[2].characters.length == 1) {
                        reversedList[2] = '0${reversedList[2]}';
                      }
                      var joinList = reversedList.join('-');
                      log(joinList);
                      DateTime now = DateTime.now();
                      var second = '${now.second}';
                      var hour = '${now.hour}';
                      var minute = '${now.minute}';
                      if (now.second.toString().length == 1) {
                        second = '0$second';
                      }
                      if (now.hour.toString().length == 1) {
                        hour = '0$hour';
                      }
                      if (now.minute.toString().length == 1) {
                        minute = '0$minute';
                      }
                      var withTime = '$hour:$minute:$second';
                      var joiningValue = '$joinList $withTime';
                      log(joiningValue);
                      //log(con.dc.text.replaceAll('/', '-'));
                      log(DateTime.parse(joiningValue));
                      valueOfDate = DateTime.parse(joiningValue);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(hp.theme.primaryColor)),
                    child: const Text(
                      '+5 years',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 15,
                ),
              ]),
          const SizedBox(
            height: 20,
          ),
          ValueListenableBuilder<int>(
              valueListenable: totalDocsCount,
              builder: (BuildContext context, int value, Widget? child) =>
                  // Center(
                  // child:
                  MyLabelledButton(
                      type: ButtonType.text,
                      label: 'Save Changes',
                      onPressed: () {
                        waitUntilDocumentUpdate(con.getAddOrEditDocumentMap(
                            document: widget.document,
                            property: property,
                            value: value));
                      })
              // heightFactor: hp.height / 320
              // )
              )
        ],
      ),
    ));
  }

  void waitUntilDocumentUpdate(Map<String, dynamic> body) async {
    try {
      Loader.show(context);
      final value = await api.editDocument(body);
      Loader.hide();
      if (value.success) {
        hp.goBackForeverTo('/property_details');
      }
    } catch (e) {
      rethrow;
    }
  }

  Widget textFormField() {
    return TextFormField(
      controller: con.abc,
      showCursor: false,
      readOnly: true,
      onTap: () {
        showDialog1();
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: hp.height / 100, horizontal: hp.width / 40),
        border: const OutlineInputBorder(),
        hintText: 'Select Document Type',
        // label: Text(con.pt?.type ?? '', style: con.pt?.type.isEmpty ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
        suffixIcon: const Icon(
          Icons.arrow_drop_down_outlined,
          color: Colors.black87,
        ),
      ),
    );
  }

  void showDialog1() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text(
            'Select Document type',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffe09c58), fontWeight: FontWeight.w500),
          ),
          content: SizedBox(
              /*height: 300.0,*/ // Change as per your requirement
              width: MediaQuery.of(context).size.width *
                  20, // Change as per your requirement
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                shrinkWrap: true,
                itemCount: con.kinds?.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        log(index);
                        setState(() {
                          con.dt = con.kinds?[index];
                          log(con.dt?.type);
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        // height: 60,
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            // const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(padding: const EdgeInsets.only(top:15),child:
                                // Text(con.types?[index].type ?? '',textAlign: TextAlign.left, style: const TextStyle(fontSize: 15, color: Colors.black,),
                                // ),
                                Flexible(
                                  flex: 10,
                                  child: Container(
                                    //  color: Colors.red,
                                    child: con.dt == con.kinds?[index]
                                        ? Text(con.kinds?[index].type ?? '',
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            /*overflow:
                                                TextOverflow.ellipsis,*/
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.blue,
                                            ))
                                        : Text(
                                            con.kinds?[index].type ?? '',
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            /*overflow:
                                              TextOverflow.ellipsis,*/
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                        //  color: Colors.red,
                                        child: con.dt == con.kinds?[index]
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.blue,
                                                size: 20.0,
                                              )
                                            : const Text('')))
                              ],
                            ),
                            // const SizedBox(height: 5,),
                            const Divider(
                              height: 0.5,
                              thickness: 0.5,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ));
                },
              )),
          actions: <Widget>[
            TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  for (DocumentType p in con.kinds!) {
                    if (p == con.dt) {
                      setState(() {
                        con.dt = p;
                        log(p.type);
                      });
                    }
                  }
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: const Text(
                'OK',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                con.abc.text = con.dt?.type ?? '';
                textFormField();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }),
    );
  }

  Future<DateTime> getDatePicker(
      {AlertType? alertType,
      DateTime? dateTime,
      DateType? dateType,
      required BuildContext context}) async {
    final DateTime picked;
    switch (dateType) {
      case DateType.birth:
        break;
      case DateType.death:
        break;
      default:
        break;
    }
    switch (alertType) {
      case AlertType.cupertino:
        picked = await showIOSStyleDatePicker(initial: dateTime);
        break;
      case AlertType.normal:
      default:
        picked = await showIOSStyleDatePicker(initial: dateTime);
        break;
    }
    log(picked.day);
    return picked;
  }

  Future<DateTime> showIOSStyleDatePicker({DateTime? initial}) async {
    Widget iOSDatePickerBuilder(BuildContext context) {
      dynamic dat;
      dynamic donedat;
      void onDateTimeChanged(DateTime dt) {
        dat = dt;
      }

      return Card(
          color: Colors.white,
          margin: EdgeInsets.only(
              top: hp.dimensions.orientation == Orientation.portrait
                  ? hp.height / 1.5
                  : hp.height / 3),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.blue),
                                            borderRadius: BorderRadius.circular(
                                                hp.radius / 160))),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: hp.height / 40,
                                        horizontal: hp.width / 10))),
                            onPressed: () {
                              log(dat);
                              log('camcel');
                              hp.goBack(result: donedat);
                            },
                            child: const Text('Cancel')),
                        OutlinedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.blue),
                                            borderRadius: BorderRadius.circular(
                                                hp.radius / 160))),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: hp.height / 40,
                                        horizontal: hp.width / 10))),
                            onPressed: () {
                              log(dat);
                              log('check');
                              donedat = dat;
                              hp.goBack(result: donedat);
                            },
                            child: const Text('Done'))
                      ],
                    ))),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child: CupertinoDatePicker(
                    minimumDate:
                        DateTime.tryParse(widget.document?.boughtDate ?? '')
                            ?.subtract(const Duration(minutes: 5)),
                    maximumDate:
                        DateTime.tryParse(widget.document?.boughtDate ?? '')
                            ?.add(const Duration(days: 3652)),
                    initialDateTime: initial,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (onDateTimeChanged)))
          ]));
    }

    final today = DateTime.now();
    if (initial == null) {
      final picked = await showCupertinoModalPopup<DateTime>(
              context: context, builder: iOSDatePickerBuilder) ??
          today;
      return picked;
    } else {
      final picked = await showCupertinoModalPopup<DateTime>(
              context: context, builder: iOSDatePickerBuilder) ??
          initial;
      return picked;
    }
  }
}
