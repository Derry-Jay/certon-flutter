import 'package:flutter/services.dart';

import '../custom_loader.dart';
import '../../backend/api.dart';
import '../../models/user.dart';
import '../../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../../models/route_argument.dart';
import '../../models/pin_code_result.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controllers/property_and_document_controller.dart';

class AddPropertyFormWidget extends StatefulWidget {
  final RouteArgument rar;
  const AddPropertyFormWidget({Key? key, required this.rar}) : super(key: key);

  @override
  AddPropertyFormWidgetState createState() => AddPropertyFormWidgetState();
}

class AddPropertyFormWidgetState extends StateMVC<AddPropertyFormWidget> {
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);
  AddPropertyFormWidgetState() : super(PropertyAndDocumentController()) {
    con = controller as PropertyAndDocumentController;
  }

  Widget addressListBuilder(
      BuildContext context, PinCodeResult result, Widget? child) {
    final hpl = Helper.of(context);
    return result.addresses.isEmpty
        ? SizedBox(height: hpl.height / 16, width: hpl.width)
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: hp.height / 80),
            physics: const ClampingScrollPhysics(),
            itemBuilder: getItemBuilder,
            itemCount: result.addresses.length);
  }

  Widget getItemBuilder(BuildContext context, int index) {
    final hpi = Helper.of(context);
    void onChanged(bool? val) {
      if (con.flags.isNotEmpty && mounted) {
        setState(() {
          if (con.flags.contains(true)) {
            con.flags[con.flags.indexOf(true)] = false;
            con.flags[index] = true;
          } else {
            con.flags[index] = val ?? false;
          }
        });
      }
    }

    return GestureDetector(
        child: Container(
          // color: Colors.amber,
          padding: EdgeInsets.symmetric(horizontal: hpi.width / 32),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                flex: 8,
                child: Text(
                  location.value.addresses.isEmpty
                      ? ''
                      : location.value.addresses[index],
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                )),
            Flexible(
                flex: 1,
                child: Checkbox(
                    value: con.flags.isNotEmpty ? con.flags[index] : false,
                    onChanged: onChanged))
          ]),
        ),
        onTap: () {
          setState(() {
            if (con.flags.contains(true)) {
              con.flags[con.flags.indexOf(true)] = false;
              con.flags[index] = true;
              log(con.flags);
            } else {
              con.flags[index] = true;
            }
          });
        });
  }

  Widget elementBuilder(BuildContext context, User user, Widget? child) {
    final hpe = Helper.of(context);
    log('===================');
    log(hpe.height);
    log('++++++++++++++++++++,');
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Form(
          key: con.key,
          child: SingleChildScrollView(
              // padding: EdgeInsets.symmetric(horizontal: hpe.width / 32),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  // height: hpe.height /
                  //     (hpe.pageOrientation == Orientation.landscape
                  //         ? 6.5536
                  //         : 13.1072),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: hp.theme.hintColor,
                      borderRadius: const BorderRadius.all(Radius.zero)),
                  child: Row(
                    children: [
                      Flexible(
                        child: Icon(Icons.qr_code_scanner_outlined,
                            color: hp.theme.scaffoldBackgroundColor,
                            size: hp.radius / 20),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('CODE SCANNED',
                                style:
                                    TextStyle(color: Colors.lightGreenAccent)),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            Text(
                                'Property ID:  ${widget.rar.params['scancode']}',
                                softWrap: false,
                                // maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(color: Colors.white))
                          ],
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text('1/2 ADD PROPERTY',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'Postcode',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                        height: 50,
                        // width: double.infinity,
                        child: TextFormField(
                            // onTap: con.lookUpButtonOnTap,
                            controller: con.pc,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            onChanged: (value) {
                              con.pc.value = (TextEditingValue(
                                  text: value.toUpperCase(),
                                  selection: con.pc.selection));
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              // FilteringTextInputFormatter.deny(
                              //     RegExp(r'[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]')),
                            ],
                            // onChanged: con.waitUntilAddressObtained,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
                                hintText: 'Postcode')),
                      ),
                    ),
                    //  const SizedBox(width: 10,),
                    Flexible(
                      flex: hp.dimensions.orientation == Orientation.landscape
                          ? hp.isTablet
                              ? 1
                              : 2
                          : hp.isTablet
                              ? 2
                              : (hp.isMobile ? (hp.height > 599 ? 4 : 6) : 3),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (con.pc.text.isNotEmpty) {
                            FocusScopeNode currentScope =
                                FocusScope.of(context);
                            currentScope.unfocus();
                            con.waitUntilAddressObtained(con.pc.text, context);
                          } else {
                            final p = await hp.showSimplePopup('OK', () {
                              hp.goBack(result: true);
                              location.value = PinCodeResult.emptyResult;
                              location.value.onChange();
                              setState(() {});
                            },
                                action:
                                    'Please enter the postcode to select an address.',
                                type: AlertType.cupertino,
                                title: title);
                          }
                        },
                        // con.lookUpPress,
                        style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(100, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                hp.theme.primaryColor)),
                        child: const Text(
                          'Lookup',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: con.alertFlags ? con.pc.text.isEmpty : false,
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: const Text('Enter Postal Code',
                          style: TextStyle(color: Colors.red)))),
              const SizedBox(height: 5),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: const Text('Choose Location',
                      style: TextStyle(fontSize: 14))),
              const SizedBox(height: 5),
              Center(
                child: Container(
                    //  padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 125,
                    width: hp.width - 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.zero),
                    child: ValueListenableBuilder<PinCodeResult>(
                        valueListenable: location,
                        builder: addressListBuilder)),
              ),
              Visibility(
                  visible: con.alertFlags ? !con.flags.contains(true) : false,
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: const Text('Choose any location',
                          style: TextStyle(color: Colors.red)))),
              /*const SizedBox(height: 10),*/
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'Select Property Type',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                ),
              ),
              const SizedBox(height: 5),
              con.types == null
                  ? CustomLoader(
                      duration: const Duration(seconds: 10),
                      color: hp.theme.primaryColor,
                      loaderType: LoaderType.fadingCircle)
                  : Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          controller: con.pty,
                          showCursor: false,
                          readOnly: true,
                          onTap: con.showDialog,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: hp.height / 100,
                                horizontal: hp.width / 40),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero)),
                            hintText: 'Select Property Type',
                            // label: Text(con.pt?.type ?? '', style: con.pt?.type.isEmpty ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black87,
                            ),
                          ))),
              Visibility(
                  visible: con.alertFlags ? (con.pt?.typeID == null) : false,
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: const Text('Select Property type',
                          style: TextStyle(color: Colors.red)))),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text('QR Code Installation date',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                    textScaleFactor: 1.0),
              ),
              const SizedBox(height: 5),
              /*const SizedBox(height: 10),*/
              GestureDetector(
                child: Center(
                  child: Container(
                    // margin: EdgeInsets.symmetric(
                    //     horizontal: hpe.height /
                    //         (hpe.pageOrientation == Orientation.landscape
                    //             ? 16
                    //             : 80)),
                    //   margin: EdgeInsets.only(left: hpe.width / 32, right: hpe.width / 32, ),
                    //  padding:
                    //       EdgeInsets.symmetric(horizontal: hpe.width / 32),
                    //   height: 50,
                    //  padding:
                    //     EdgeInsets.symmetric(horizontal: hpe.width / 32),
                    // width: hp.width,
                    width: hp.width - 40,
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.zero),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*const Text('QR Code Installation date', textScaleFactor: 1.0),*/
                        con.valueOfDate != null
                            ? Text(putDateToString(con.valueOfDate))
                            : const Text('DD/MM/YYYY',
                                textScaleFactor: 1.0,
                                style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  final dt = await con.getDatePicker(
                      alertType: AlertType.cupertino, context: context);
                  setState(() {
                    con.valueOfDate = dt;
                  });
                  con.dc.text = putDateToString(con.valueOfDate);
                },
              ),
              Visibility(
                  visible: con.alertFlags ? (con.valueOfDate == null) : false,
                  child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: const Text('Select Qrcode Installation date',
                          style: TextStyle(color: Colors.red)))),
              const SizedBox(height: 20),
              user.isOwner
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (con.pc.text.isEmpty ||
                                  con.flags.isEmpty ||
                                  !con.flags.contains(true) ||
                                  con.pt?.typeID == null ||
                                  con.valueOfDate == null) {
                                setState(() {
                                  con.alertFlags = true;
                                });
                              } else {
                                con.waitUntilPropertyAdd(
                                    user,
                                    widget.rar.params['scancode'] ?? '',
                                    widget.rar.tag ?? '',
                                    context);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        hp.theme.primaryColor)),
                            child: const Text(
                              'Finish',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  con.t = PossessorType.me;
                                  if (con.pc.text.isEmpty ||
                                      con.flags.isEmpty ||
                                      !con.flags.contains(true) ||
                                      con.pt?.typeID == null ||
                                      con.valueOfDate == null) {
                                    setState(() {
                                      con.alertFlags = true;
                                    });
                                  } else {
                                    con.waitUntilPropertyAdd(
                                        user,
                                        widget.rar.params['scancode'] ?? '',
                                        widget.rar.tag ?? '',
                                        context);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            hp.theme.primaryColor)),
                                child: const Text(
                                  'Save for Myself',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          const Center(
                            child: Text(
                              'Or',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  con.t = PossessorType.other;
                                  if (con.pc.text.isEmpty ||
                                      con.flags.isEmpty ||
                                      con.pt?.typeID == null ||
                                      con.valueOfDate == null) {
                                    setState(() {
                                      con.alertFlags = true;
                                    });
                                  } else {
                                    // log(widget.rar.tag);
                                    // log(widget.rar.content);
                                    // log(widget.rar.id);
                                    // log(widget.rar.params);
                                    con.waitUntilPropertyAdd(
                                        user,
                                        widget.rar.params['scancode'] ?? '',
                                        widget.rar.params['user_id'].toString(),
                                        context);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            hp.theme.primaryColor)),
                                child: const Text(
                                  'Add for a Customer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                    ),
              const SizedBox(height: 20),
            ],
          ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<User>(
        valueListenable: currentUser, builder: elementBuilder);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.waitForPropertyTypes();
  }
}
