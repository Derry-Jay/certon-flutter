import 'package:flutter/services.dart';

import '../backend/api.dart';
import '../models/user.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/property_type.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../models/pin_code_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../controllers/property_and_document_controller.dart';

class EditPropertyScreen extends StatefulWidget {
  final RouteArgument rar;
  const EditPropertyScreen({Key? key, required this.rar}) : super(key: key);

  @override
  EditPropertyScreenState createState() => EditPropertyScreenState();
}

class EditPropertyScreenState extends StateMVC<EditPropertyScreen> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  dynamic valueOfDate;
  bool loaderFlag = false;
  int propertyTypeID = 0;
  EditPropertyScreenState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  Widget pageBuilder(BuildContext context, Property property, Widget? child) {
    if (con.pty.text.isEmpty) {
      final p = widget.rar.params as Property;
      con.pty.text = p.type.type;
    }
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery(
          data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .copyWith(boldText: false, textScaleFactor: 1.0),
          child: Scaffold(
              // key: hp.key,
              drawer:
                  Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
              bottomNavigationBar: child,
              body: Form(
                  key: con.key1,
                  child: SizedBox(
                      height: hp.height / 1.024,
                      child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              horizontal: hp.width / 25,
                              vertical: hp.height / 50),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(bottom: hp.height / 40),
                                    child: Text('Edit Property',
                                        style: hp.textTheme.bodyText2)),
                                const SizedBox(height: 5),
                                const Text('Postcode',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                    textScaleFactor: 1.0),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: hp.isTablet
                                            ? 5
                                            : (hp.width > 375 ? 3 : 2),
                                        child: TextField(
                                            readOnly: widget.rar.id == 1
                                                ? true
                                                : false,
                                            enabled: widget.rar.id == 1
                                                ? false
                                                : true,
                                            // onTap: con.addressFieldTap,
                                            keyboardType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            controller: con.pc,
                                            onChanged: (value) {
                                              con.adc.text = '';
                                              con.pc.value = (TextEditingValue(
                                                  text: value.toUpperCase(),
                                                  selection: con.pc.selection));
                                            },
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              // FilteringTextInputFormatter.deny(
                                              //     RegExp(r'[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]')),
                                            ],
                                            style: TextStyle(
                                                color: widget.rar.id == 1
                                                    ? Colors.black26
                                                    : Colors.black),
                                            /*onChanged: (val) {
                                          con.adc.text = '';
                                        },*/
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            hp.height / 100,
                                                        horizontal:
                                                            hp.width / 40),
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: 'Postcode'))),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: 200,
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: widget.rar.id == 1
                                                ? null
                                                : () async {
                                                    loaderFlag = true;
                                                    setState(() {});

                                                    // pincodeAPI(con.pc.text);

                                                    if (con
                                                        .pc.text.isNotEmpty) {
                                                      pincodeAPI(con.pc.text);
                                                    } else if (await hp
                                                        .showSimplePopup(
                                                            'OK', () {
                                                      hp.goBack(result: true);
                                                      location.value =
                                                          PinCodeResult
                                                              .emptyResult;
                                                      location.value.onChange();
                                                      setState(() {
                                                        loaderFlag = false;
                                                        // textFormField();
                                                      });
                                                    },
                                                            action:
                                                                'Please enter the postcode to select an address.',
                                                            type: AlertType
                                                                .cupertino,
                                                            title: title)) {
                                                      log('object');
                                                    }
                                                  },
                                            style: ElevatedButton.styleFrom(
                                                primary: hp.theme.primaryColor,
                                                onSurface:
                                                    hp.theme.primaryColor),
                                            child: const Text(
                                              'Lookup',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ))

                                    // MyLabelledButton(
                                    //     type: ButtonType.text,
                                    //     label: 'Lookup',
                                    //     onPressed: () {
                                    // loaderFlag = true;
                                    // setState(() {});
                                    // pincodeAPI(con.pc.text);
                                    //     })
                                  ],
                                ),
                                /*const SizedBox(
                              height: 15,
                            ),*/
                                const SizedBox(height: 5),
                                const Text('Select an Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                    textScaleFactor: 1.0),
                                const SizedBox(height: 5),
                                loaderFlag
                                    ? TextFormField(
                                        controller: con.adc,
                                        showCursor: false,
                                        scrollPhysics:
                                            const NeverScrollableScrollPhysics(),
                                        readOnly:
                                            widget.rar.id == 1 ? true : false,
                                        enabled:
                                            widget.rar.id == 1 ? false : true,
                                        onTap: () {
                                          con.address = con.adc.text;
                                          showDialog2();
                                        },
                                        style: TextStyle(
                                            color: widget.rar.id == 1
                                                ? Colors.black26
                                                : Colors.black),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: hp.height / 100,
                                              horizontal: hp.width / 40),
                                          border: const OutlineInputBorder(),
                                          hintText: 'Select an Address',
                                          // label: Text(con.pt?.type ?? '', style: con.pt?.type.isEmpty ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      )
                                    : TextFormField(
                                        controller: con.adc,
                                        showCursor: false,
                                        readOnly: true,
                                        enabled: !(widget.rar.id == 1),
                                        onTap: () {
                                          con.address = con.adc.text;
                                          showDialog2();
                                        },
                                        style: TextStyle(
                                            color: widget.rar.id == 1
                                                ? Colors.black26
                                                : Colors.black),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: hp.height / 100,
                                              horizontal: hp.width / 40),
                                          border: const OutlineInputBorder(),
                                          hintText: 'Select an Address',
                                          // label: Text(con.pt?.type ?? '', style: con.pt?.type.isEmpty ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 5),
                                const Text('Select Property Type',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                    textScaleFactor: 1.0),
                                const SizedBox(height: 5),
                                con.types == null
                                    ? TextFormField(
                                        scrollPhysics:
                                            const NeverScrollableScrollPhysics(),
                                        controller: con.pty,
                                        showCursor: false,
                                        readOnly: true,
                                        enabled: !(widget.rar.id == 1),
                                        onTap: showDialog1,
                                        style: TextStyle(
                                            color: widget.rar.id == 1
                                                ? Colors.black26
                                                : Colors.black),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: hp.height / 100,
                                              horizontal: hp.width / 40),
                                          border: const OutlineInputBorder(),
                                          hintText: 'Select Property Type',
                                          // label: Text(con.pt?.type ?? '', style: con.pt?.type.isEmpty ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      )
                                    : TextFormField(
                                        scrollPhysics:
                                            const NeverScrollableScrollPhysics(),
                                        controller: con.pty,
                                        showCursor: false,
                                        readOnly: true,
                                        enabled: widget.rar.id != 1,
                                        onTap: showDialog1,
                                        style: TextStyle(
                                            color: widget.rar.id == 1
                                                ? Colors.black26
                                                : Colors.black),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: hp.height / 100,
                                              horizontal: hp.width / 40),
                                          border: const OutlineInputBorder(),
                                          hintText: 'Select Property Type',
                                          // label: Text(con.pt?.type ?? '', style: con.pt?.type.isEmpty ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 5),
                                const Text('QR Installation Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                    textScaleFactor: 1.0),
                                const SizedBox(height: 5),
                                TextFormField(
                                    readOnly: true,
                                    enabled: widget.rar.id != 1,
                                    controller: con.dc,
                                    style: TextStyle(
                                        color: widget.rar.id == 1
                                            ? Colors.black26
                                            : Colors.black),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: hp.height / 100,
                                            horizontal: hp.width / 40),
                                        border: const OutlineInputBorder(),
                                        hintText: 'QR Installation Date'),
                                    onTap: () async {
                                      final tfd = DateTime.tryParse(property
                                          .date
                                          .split('/')
                                          .reversed
                                          .join('-'));
                                      log(tfd);
                                      final dt = await con.getDatePicker(
                                              context: context,
                                              alertType: AlertType.cupertino) ??
                                          DateTime.now();
                                      valueOfDate = dt;
                                      log(putDateToString(dt));
                                      con.dc.text = putDateToString(dt);
                                    }),
                                const SizedBox(
                                  height: 30,
                                ),
                                ValueListenableBuilder<User>(
                                    valueListenable: currentUser,
                                    builder: (context, user, child) =>
                                        ValueListenableBuilder<PinCodeResult>(
                                            valueListenable: location,
                                            builder: (context, result, child) =>
                                                Center(
                                                  child: SizedBox(
                                                    width: 200,
                                                    height: 45,
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          widget.rar.id == 1
                                                              ? null
                                                              : () {
                                                                  con.waitUntilPropertyUpdate(
                                                                      property,
                                                                      user,
                                                                      result,
                                                                      parseBool(widget
                                                                          .rar
                                                                          .tag),
                                                                      context,
                                                                      propertyTypeID,
                                                                      widget.rar
                                                                              .content ??
                                                                          'false');
                                                                },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: hp.theme
                                                                  .primaryColor,
                                                              onSurface: hp
                                                                  .theme
                                                                  .primaryColor),
                                                      child: const Text(
                                                        'Update',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            // Center(
                                            //     heightFactor: hp.height / 320,
                                            //     child: ElevatedButton(
                                            //         type: ButtonType.text,
                                            //         label: 'Update',
                                            //         onPressed: () {
                                            //           con.waitUntilPropertyUpdate(
                                            //               property,
                                            //               user,
                                            //               result,
                                            //               parseBool(
                                            //                   widget.rar.tag),
                                            //               context,
                                            //               propertyTypeID);
                                            //         }))

                                            ))
                              ])))),
              appBar: AppBar(
                  leadingWidth: hp.leadingWidth,
                  leading: const LeadingWidget(visible: false),
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: hp.theme.primaryColor,
                  foregroundColor: hp.theme.scaffoldBackgroundColor,
                  title: const Text('Edit Property',
                      style: TextStyle(fontWeight: FontWeight.w600)))),
        ));
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
    final p = widget.rar.params as Property;
    con.waitForPropertyTypes();
    con.setProperty(p);

    if (con.pc.text.isNotEmpty) {
      loaderFlag = true;
      pincodeAPI(con.pc.text);
      con.pty.text = props.value.type.type;
      propertyTypeID = props.value.type.typeID;
    }
  }

  void cuper1() {
    if (con.types?.isEmpty ?? true) {
      con.waitForPropertyTypes();
    }
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // final hpd = Helper.of(context);
          return StatefulBuilder(
            builder: (context, setState) {
              return CupertinoAlertDialog(
                title: const Text('Select Property type'),
                content: SizedBox(
                    height: 300.0, // Change as per your requirement
                    width: 350.0, // Change as per your requirement
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
                      shrinkWrap: true,
                      itemCount: con.types?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              log(index);
                              setState(() {
                                con.pt = con.types?[index];
                                log(con.pt?.type);
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              // height: 45,
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  // const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Container(padding: const EdgeInsets.only(top:15),child:
                                      // Text(con.types?[index].type ?? '',textAlign: TextAlign.left, style: const TextStyle(fontSize: 15, color: Colors.black,),
                                      // ),
                                      Flexible(
                                        flex: 10,
                                        child: Container(
                                          //  color: Colors.red,
                                          child: con.pt == con.types?[index]
                                              ? Text(
                                                  con.types?[index].type ?? '',
                                                  textAlign: TextAlign.left,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue,
                                                  ))
                                              : Text(
                                                  con.types?[index].type ?? '',
                                                  textAlign: TextAlign.left,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                        ),
                                      ),

                                      Flexible(
                                          flex: 1,
                                          child: Container(
                                              child: con.pt == con.types?[index]
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
                actions: [
                  CupertinoDialogAction(
                      child: const Text('Cancel'),
                      onPressed: () {
                        for (PropertyType p in con.types!) {
                          if (p.type == con.pty.text) {
                            setState(() {
                              con.pt = p;
                              propertyTypeID = p.typeID;
                              log(p.type);
                            });
                          }
                        }
                        Navigator.of(context).pop();
                      }),
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () {
                      con.pty.text = con.pt?.type ?? '';
                      propertyTypeID = con.pt?.typeID ?? 0;
                      // textFormField();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        });
  }

  void showDialog1() {
    if (con.types?.isEmpty ?? true) {
      con.waitForPropertyTypes();
    }
    showDialog(
      context: context,
      builder: (BuildContext ctx) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text(
            'Select Property type',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffe09c58), fontWeight: FontWeight.w500),
          ),
          content: SizedBox(
              width: MediaQuery.of(context).size.width *
                  20, // Change as per your requirement
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                shrinkWrap: true,
                itemCount: con.types?.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        log(index);
                        setState(() {
                          con.pt = con.types?[index];
                          log(con.pt?.type);
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        // height: 45,
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
                                    child: con.pt == con.types?[index]
                                        ? Text(con.types?[index].type ?? '',
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            /*overflow:
                                                TextOverflow.ellipsis,*/
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                            ))
                                        : Text(
                                            con.types?[index].type ?? '',
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            /*overflow:
                                              TextOverflow.ellipsis,*/
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                ),

                                Flexible(
                                    flex: 1,
                                    child: Container(
                                        child: con.pt == con.types?[index]
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
                  for (PropertyType p in con.types!) {
                    if (p.type == con.pty.text) {
                      setState(() {
                        con.pt = p;
                        propertyTypeID = p.typeID;
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
                con.pty.text = con.pt?.type ?? '';
                propertyTypeID = con.pt?.typeID ?? 0;
                // textFormField();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }),
    );
  }

// @override
// dispose() {
//   this.dispose(); // you need this
//   super.dispose();
// }
  // Widget textFormField() {
  //   log(con.pty.text);
  //   return ;
  // }

  void pincodeAPI(String val) async {
    try {
      if (val.isNotEmpty && val.trim().isNotEmpty) {
        final value = await api.getAddresses({'postcode': val});
        log(value);
        log('came here');
        location.value = value;
        if (location.value.addresses.isNotEmpty) {
          con.flags = List<bool>.filled(location.value.addresses.length, false);
          log(con.flags);
        } else if (await hp.showSimplePopup('OK', () {
          hp.goBack(result: true);
        },
            type: AlertType.cupertino,
            action:
                'You have entered a wrong postcode. Please enter a correct one.',
            title: 'Oops!!')) {
          log('RouteArgs');
        }
        log(con.adc.text);
        log(con.beforeAddress);

        final index = location.value.addresses
            .indexWhere((element) => element.contains(con.beforeAddress ?? ''));
        if (index >= 0) {
          log('Using indexWhere: ${location.value.addresses[index]}');
          con.adc.text = location.value.addresses[index];
        } else {
          log('jkjgj');
        }
        setState(() {
          loaderFlag = false;
        });
        location.value.onChange();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void showDialog2() {
    if (location.value.addresses.isEmpty && hp.isDialogOpen) {
      pincodeAPI(con.pc.text);
    }

    showDialog(
      context: context,
      builder: (BuildContext ctx) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text(
            'Select an Address',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffe09c58), fontWeight: FontWeight.w500),
          ),
          content: SizedBox(
              // Change as per your requirement
              width: MediaQuery.of(context).size.width *
                  20, // Change as per your requirement// Change as per your requirement
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                shrinkWrap: true,
                itemCount: location.value.addresses.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        log(index);
                        setState(() {
                          con.address = location.value.addresses[index];
                          log(con.address);
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        // height: 45,
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
                                  flex: 7,
                                  child: Container(
                                    //  color: Colors.red,
                                    child: con.address ==
                                            location.value.addresses[index]
                                        ? Text(location.value.addresses[index],
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            /*overflow:
                                                TextOverflow.ellipsis,*/
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue))
                                        : Text(
                                            location.value.addresses[index],
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            /*overflow:
                                              TextOverflow.ellipsis,*/
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                ),

                                con.address == location.value.addresses[index]
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.blue,
                                        size: 20.0,
                                      )
                                    : const Text('')
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
                  for (String p in location.value.addresses) {
                    if (p == con.adc.text) {
                      setState(() {
                        con.address = p;
                        log(p);
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
                con.adc.text = con.address ?? '';
                // textFormField2();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }),
    );

    /*showCupertinoDialog(
        context: context,
        builder: (context) {
          // final hpd = Helper.of(context);
          return StatefulBuilder(
            builder: (context, setState) {
              return CupertinoAlertDialog(
                title: const Text('Select an Address'),
                content: SizedBox(
                    height: 300.0, // Change as per your requirement
                    width: 350.0, // Change as per your requirement
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
                      shrinkWrap: true,
                      itemCount: location.value.addresses.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              log(index);
                              setState(() {
                                con.address = location.value.addresses[index];
                                log(con.address);
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              // height: 45,
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  // const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Container(padding: const EdgeInsets.only(top:15),child:
                                      // Text(con.types?[index].type ?? '',textAlign: TextAlign.left, style: const TextStyle(fontSize: 15, color: Colors.black,),
                                      // ),
                                      Flexible(
                                        flex: 7,
                                        child: Container(
                                          //  color: Colors.red,
                                          child: con.address ==
                                                  location
                                                      .value.addresses[index]
                                              ? Text(
                                                  location
                                                      .value.addresses[index],
                                                  textAlign: TextAlign.left,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue))
                                              : Text(
                                                  location
                                                      .value.addresses[index],
                                                  textAlign: TextAlign.left,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                        ),
                                      ),

                                      con.address ==
                                              location.value.addresses[index]
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.blue,
                                              size: 20.0,
                                            )
                                          : const Text('')
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
                actions: [
                  CupertinoDialogAction(
                      child: const Text('Cancel'),
                      onPressed: () {
                        for (String p in location.value.addresses) {
                          if (p == con.adc.text) {
                            setState(() {
                              con.address = p;
                              log(p);
                            });
                          }
                        }
                        Navigator.of(context).pop();
                      }),
                  CupertinoDialogAction(
                    child: const Text('Ok'),
                    onPressed: () {
                      con.adc.text = con.address ?? '';
                      // textFormField2();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        });*/
  }

  // Widget textFormField2() {
  //   return ;
  // }
}
