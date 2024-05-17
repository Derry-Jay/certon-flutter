import '../models/accesslist.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../backend/api.dart';
import '../models/user.dart';
import '../models/reply.dart';
import '../widgets/loader.dart';
import '../helpers/helper.dart';
import '../models/document.dart';
import '../models/property.dart';
import '../models/misc_data.dart';
import '../models/property_type.dart';
import '../models/document_type.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import 'package:flutter/cupertino.dart';
import '../models/pin_code_result.dart';
import '../models/status_property_base.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:image/image.dart' as im;

class PropertyAndDocumentController extends ControllerMVC {
  List<PropertyType>? types;
  List<DocumentType>? kinds;
  List<Document>? documents;
  AccessList? accessList;
  List<bool> flags = <bool>[];
  List<Property>? properties, othersProps;
  List<XFile>? images;
  List<String> imagePaths = <String>[];
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GlobalKey<FormState> key = GlobalKey<FormState>(),
      key1 = GlobalKey<FormState>(),
      key2 = GlobalKey<FormState>();
  String imageURL = '';
  String? address, beforeAddress;
  TextEditingController dc = TextEditingController(),
      nc = TextEditingController(),
      pc = TextEditingController(),
      adc = TextEditingController(),
      pty = TextEditingController(),
      abc = TextEditingController();
  DocumentType? dt;
  PropertyType? pt;
  PossessorType? t;
  Property? p;
  PickImageType? pit, pf;
  XFile? image;
  bool alertFlags = false, check = false;

  List<XFile> imagesList = [];

  dynamic valueOfDate;

  ImagePicker picker = ImagePicker();
  Helper get hp =>
      Helper.of(state == null ? states.first.context : state!.context);
  void onLandLordFlagChanged(bool? val) async {
    final prefs = await sharedPrefs;
    final f = await prefs.setBool('landlordcheck', val ?? !check);
    if (f && hp.mounted) {
      setState(() {
        check = val ?? !check;
      });
    }
  }

  Future<DateTime?> getDatePicker(
      {AlertType? alertType, required BuildContext context}) async {
    // final today = DateTime.now();
    final DateTime picked;

    switch (alertType) {
      case AlertType.cupertino:
        picked = (await showIOSStyleDatePicker(initial: valueOfDate))!;
        break;
      case AlertType.normal:
      default:
        picked = (await showIOSStyleDatePicker(initial: valueOfDate))!;
        break;
    }
    log(picked);
    return picked;
  }

  Future<DateTime?> showIOSStyleDatePicker({DateTime? initial}) async {
    Widget iOSDatePickerBuilder(BuildContext context) {
      final hpp = Helper.of(context);
      dynamic dat;
      //  dynamic donedat;
      void onDateTimeChanged(DateTime dt) {
        dat = dt;
      }

      return Card(
          color: Colors.white,
          margin: EdgeInsets.only(
              top: hp.dimensions.orientation == Orientation.portrait
                  ? hpp.height / 1.5
                  : hpp.height / 3),
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
                                                hpp.radius / 160))),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: hpp.height / 40,
                                        horizontal: hpp.width / 10))),
                            onPressed: () {
                              log(dat);
                              hpp.goBack(result: valueOfDate);
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
                                                hpp.radius / 160))),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: hpp.height / 40,
                                        horizontal: hpp.width / 10))),
                            onPressed: () {
                              log(dat);
                              log('check');
                              valueOfDate = dat;
                              if (dat == null) {
                                log(initial);
                                if (initial == null) {
                                  valueOfDate = DateTime.now();
                                } else {
                                  valueOfDate = initial;
                                }
                                log(valueOfDate);
                              }
                              hpp.goBack(result: valueOfDate);
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
                        DateTime.now().subtract(const Duration(minutes: 5)),
                    maximumDate: DateTime.now().add(const Duration(days: 3652)),
                    initialDateTime: initial,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (onDateTimeChanged)))
          ]));
    }

    if (initial == null) {
      final picked = await showCupertinoModalPopup<DateTime>(
          context: hp.buildContext, builder: iOSDatePickerBuilder);
      return picked;
    } else {
      final picked = await showCupertinoModalPopup<DateTime>(
          context: hp.buildContext, builder: iOSDatePickerBuilder);
      return picked;
    }
  }

  void setDoc({Document? document}) {
    if (document != null) {
      dt = document.type;
      nc.text = document.docName;
      dc.text = document.expiryDate;
      abc.text = document.type.type;
    } else {
      Future.delayed(Duration.zero, () async {
        final q = await pickImage(PopupType.modal);
        log(q);
      });
    }
  }

  void setProperty(Property p) {
    // pty.text = p.type.type;
    // log(pty.text);
    dc.text = p.date;
    pc.text = p.zipCode;
    final list = p.address.trim().split(',');
    List<String> whereAbouts = <String>[];
    list.removeWhere((element) => element.trim().isEmpty || element.isEmpty);
    for (String item in list) {
      whereAbouts.add(item.trim());
      log(item);
    }

    address = whereAbouts.join(', ').trim();
    adc.text = address ?? '';
    beforeAddress = props.value.address1;
    log(props.value);
    // adc.text = '${props.value.address1},${props.value.address2}';
    log(address);
    log('------------------');
    log(props.value.address);
    log('++++++++++++++++++');
    log(props.value.address1);
    log('==================');
    log(props.value.address2);
    log('__________________');
    setState(() {});
  }

  void showDialog() async {
    Widget dialogBuilder(BuildContext context) {
      Widget contentBuilder(
          BuildContext context, void Function(VoidCallback) setState) {
        final hpc = Helper.of(context);
        Widget getItem(BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                log(index);
                setState(() {
                  pt = types?[index];
                  log(pt?.type);
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
                            child: pt == types?[index]
                                ? Text(types?[index].type ?? '',
                                    textAlign: TextAlign.left,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                    ))
                                : Text(
                                    types?[index].type ?? '',
                                    textAlign: TextAlign.left,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ),

                        Flexible(
                            flex: 1,
                            child: Container(
                                child: pt == types?[index]
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
        }

        return AlertDialog(
          title: const Text(
            'Select Property type',
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
                  itemBuilder: getItem,
                  itemCount: types?.length)),
          actions: [
            TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  for (PropertyType p in types!) {
                    if (p.toString() == pty.text) {
                      setState(() {
                        pt = p;
                        log(p.type);
                      });
                    }
                  }
                  hpc.goBack(result: pt);
                }),
            TextButton(
              child: const Text(
                'OK',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                hpc.goBack(result: pt);
              },
            )
          ],
        );
      }

      return StatefulBuilder(builder: contentBuilder);
    }

    if (types?.isEmpty ?? true) {
      waitForPropertyTypes();
    }

    pty.text = (await showCupertinoDialog<PropertyType>(
                context: hp.buildContext, builder: dialogBuilder) ??
            PropertyType.empty)
        .toString();
  }

  Map<String, dynamic> getAddOrEditDocumentMap(
      {Document? document,
      Property? property,
      int? value,
      dynamic imageValue}) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = nc.text;
    map['type'] = dt!.typeID.toString();
    map['expire_date'] = dc.text.split('/').reversed.join('/');
    map['doc_id'] = document == null ? value.toString() : document.uuID;
    if (document == null && property != null) {
      map['prop_id'] = property.propID.toString();
      map['user_id'] =
          property.userID.toString(); //currentUser.value.userID; //
      log(gc?.getValue<String>('bucket_url'));
      log('log check in final api for add doc');
      // map['filename'] = imageURL.split(gc.getValue<String>('bucket_url')).last;
      map['filename'] = imageValue;
    }
    log(map);
    return map;
  }

  Future<List<XFile>> imageConversion(List<XFile> images) async {
    int height = 0;
    int width =
        im.decodeImage(File(images.first.path).readAsBytesSync())!.width;
    for (var item in images) {
      final image = im.decodeImage(File(item.path).readAsBytesSync());
      height += image!.height + 10;
      log(item.mimeType);
    }
    im.Image fullMergeImage;
    fullMergeImage = im.Image(width, height);
    int pos = 0;
    for (var item in images) {
      final image = im.decodeImage(File(item.path).readAsBytesSync());
      im.copyInto(fullMergeImage, image!, dstY: pos, blend: false);
      pos += image.height + 10;
    }
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = XFile('${documentDirectory.path}/merged_image.jpg');
    // file.writeAsBytesSync(im.encodeJpg(fullMergeImage));
    // XFile fiels = XFile('${documentDirectory.path}/merged_image.jpg');
    Loader.hide();

    imagesList = [];
    imagesList.add(file);
    log(imagesList);
    return imagesList;
  }

  void waitUntilAddOrEditDocument(Map<String, dynamic> body,
      {Document? document}) {
    document == null
        ? waitUntilDocumentAdd(body)
        : waitUntilDocumentUpdate(body);
  }

  void onModified(PropertyType? val) {
    setState(() => pt = val);
  }

  void onChanged(PossessorType? val) {
    setState(() => t = val);
  }

  void onSelected(DocumentType? val) {
    setState(() => dt = val);
  }

  void onAddressChanged(String? val) {
    setState(() => address = val);
  }

  // void addressFieldTap() {
  //   waitUntilAddressObtained(pc.text);
  // }

  Future<PickImageType?> pickImage(PopupType type) async {
    Widget pickerBuilder(BuildContext context) {
      final hpp = Helper.of(context);
      Widget getItem(BuildContext context, int index) {
        final hpg = Helper.of(context);
        IconData icon;
        switch (PickImageType.values[index]) {
          case PickImageType.camera:
            icon = Icons.camera_alt;
            break;
          case PickImageType.gallery:
            icon = Icons.photo;
            break;
        }
        return Card(
            child: InkWell(
                child: ListTile(
                    leading: Icon(icon),
                    title: Text(index == 1
                        ? 'Select From Gallery'
                        : EnumToString.convertToString(
                            PickImageType.values[index],
                            camelCase: true))),
                onTap: () {
                  hpg.goBack(result: PickImageType.values[index]);
                }));
      }

      CupertinoActionSheetAction mapItem(PickImageType type) {
        IconData icon;
        switch (type) {
          case PickImageType.camera:
            icon = Icons.camera_alt;
            break;
          case PickImageType.gallery:
            icon = Icons.photo_library;
            break;
        }
        return CupertinoActionSheetAction(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(child: Icon(icon, color: hp.theme.focusColor)),
              const SizedBox(
                width: 2,
              ),
              Flexible(
                  child: Text(
                      type.name == 'gallery'
                          ? 'Select From Gallery'
                          : EnumToString.convertToString(type, camelCase: true),
                      style: TextStyle(color: hp.theme.focusColor)))
            ]),
            onPressed: () {
              hpp.goBack(result: type);
            });
      }

      return type == PopupType.ios
          ? CupertinoActionSheet(
              cancelButton: CupertinoActionSheetAction(
                  onPressed: hpp.goBack,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Icon(Icons.cancel_outlined,
                                color: hp.theme.focusColor)),
                        Flexible(
                            child: Text(hp.loc.cancel,
                                style: TextStyle(color: hp.theme.focusColor)))
                      ])),
              title: const Text('Select Option'),
              // message: Text(hpp.loc.options),
              actions: PickImageType.values
                  .map<CupertinoActionSheetAction>(mapItem)
                  .toList())
          : ListView.builder(
              // shrinkWrap: true,
              // padding: EdgeInsets.only(top: hp.height / 1.28),
              itemBuilder: getItem,
              itemCount: PickImageType.values.length);
    }

    PopupMenuItem<PickImageType> mapMenuItem(PickImageType type) {
      IconData icon;
      switch (type) {
        case PickImageType.camera:
          icon = Icons.camera_alt;
          break;
        case PickImageType.gallery:
          icon = Icons.photo_library;
          break;
      }
      log(type.name);
      return PopupMenuItem<PickImageType>(
          child: InkWell(
              child: type.name == 'Gallery'
                  ? ListTile(
                      leading: Icon(icon),
                      title: const Text('Select from gallery'))
                  : ListTile(leading: Icon(icon), title: Text(type.name)),
              onTap: () {
                hp.goBack(result: type);
              }));
    }

    PickImageType? p;
    switch (type) {
      case PopupType.menu:
        p = await showMenu<PickImageType>(
            context: hp.buildContext,
            position: const RelativeRect.fromLTRB(0, 0, 0, 0),
            items: PickImageType.values
                .map<PopupMenuItem<PickImageType>>(mapMenuItem)
                .toList());
        break;
      case PopupType.modal:
        p = await showModalBottomSheet<PickImageType>(
            constraints: BoxConstraints(maxHeight: hp.height / 4.096),
            context: hp.buildContext,
            builder: pickerBuilder);
        break;
      case PopupType.ios:
        p = await showCupertinoModalPopup<PickImageType>(
            context: hp.buildContext, builder: pickerBuilder);
        break;
    }
    return p;
  }

  void getMedia() async {
    await Future.delayed(Duration.zero, pickMedia);
  }

  void pickMedia() async {
    pf = await pickImage(PopupType.ios);
    chooseMedia(pf);
  }

  void pickMultipleImages() async {
    void addPath(XFile element) {
      log(element.path);
      if (!imagePaths.contains(element.path)) {
        imagePaths.add(element.path);
      }
    }

    images = await picker.pickMultiImage();
    final pics = images ?? <XFile>[];

    log(pics.length);
    pics.isEmpty ? doNothing() : pics.forEach(addPath);
    log(imagePaths);
    imagePaths.isEmpty && !(state?.mounted ?? false)
        ? doNothing()
        : setState(doNothing);
  }

  void pickSingleImage(ImageSource source) async {
    image = await picker.pickImage(source: source);
    final pic = image ?? XFile('');
    log(pic.path);
    pic.path.isEmpty
        ? (imageURL.isEmpty ? hp.goBack() : doNothing())
        : setState(() => imageURL = pic.path);
  }

  void chooseMedia(PickImageType? type) {
    pit ??= type;
    pf = type;
    log(pit);
    switch (type) {
      case PickImageType.gallery:
        pickMultipleImages();
        break;
      case PickImageType.camera:
        pickSingleImage(ImageSource.camera);
        break;
      // case PickImageType.multiple:
      //   pickMultipleImages();
      //   break;
      default:
        pit == null && (image == null || images == null)
            ? hp.goBack()
            : doNothing();
        break;
    }
  }

  void waitForProperties() async {
    try {
      final list = await api.getProperties();
      setState(() => properties = list);
    } catch (e) {
      sendAppLog(e);
      setState(() => properties = <Property>[]);
      log(e);
    }
  }

  void waitForDocuments({Property? property}) async {
    try {
      final list = await api.getDocuments(property: property);
      setState(() => documents = list);
    } catch (e) {
      setState(() => documents = <Document>[]);
      log(e);
    }
  }

  void waitForPropertyTypes() async {
    try {
      final list = await api.getPropertyTypes();
      setState(() => types = list);
    } catch (e) {
      sendAppLog(e);
      setState(() => types = <PropertyType>[]);
    }
  }

  void waitUntilAddressObtained(String val, BuildContext context) async {
    try {
      log(val);
      if (val.isNotEmpty && val.trim().isNotEmpty) {
        Loader.show(context);
        final value = await api.getAddresses({'postcode': val});
        Loader.hide();
        if (!value.addresses.contains(address)) {
          setState(() {
            address = null;
          });
        }
        location.value = value;
        if (location.value.addresses.isNotEmpty) {
          flags = List<bool>.filled(location.value.addresses.length, false);
        } else if (await hp.showSimplePopup('OK', () {
          hp.goBack(result: true);
        },
            type: AlertType.cupertino,
            action:
                'You have entered a wrong postcode. Please enter a correct one.',
            title: 'Oops!!')) {
          log('RouteArgs');
        }
        location.value.onChange();
      }
    } catch (e) {
      Loader.hide();
      log(e);
    }
  }

  // void lookUpPress() {

  //   waitUntilAddressObtained(pc.text);
  // }

  void waitForPropertyResult(Map<String, dynamic> body) async {
    try {
      final hp = Helper.of(qrKey.currentContext!);
      final value = await api.getPropertyStatus(body);
      final rp = Reply.fromMap(value);
      if (rp.success) {
        final val = StatusPropertyBase.fromMap(value);
        final prop = val.property;
        remainingSpace.value = val.docCount;
        totalDocsCount.value = val.count;
        val.onChange();
        if (prop.userID != currentUser.value.userID &&
            currentUser.value.isContractor) {
          final v = await api.requestAccess(prop);
          // final fl = await revealToast(v.message);
          if (v.success) {
            hp.gotoForever('/mobile_home');
          }
        } else {
          hp.gotoForever('/mobile_home');
        }
      } else {
        final val = Reply.fromMap(value);
        final f = await hp.revealDialogBox(
          ['Cancel', 'OK'],
          [
            () {
              hp.goBack(result: false);
            },
            () {
              hp.goBack(result: true);
            }
          ],
          title: 'Confirm',
          type: AlertType.cupertino,
          action:
              'No existing property found, Do you want to add a new property?',
        );
        log(val.message);
        f
            ? hp.goTo('/add_property',
                args:
                    RouteArgument(content: val.message, tag: body['scancode']))
            : hp.goBack();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void waitUntilPropertyAdd(
      User user, String code, String propertyId, BuildContext context) async {
    try {
      if (key.currentState!.validate()) {
        final hp = Helper.of(key.currentContext!);
        log(dc.text.split('/').reversed.join('/'));
        final body = {
          'user_id': user.userID.toString(),
          'postcode': pc.text,
          'qrcode': code,
          'property_type': pt!.typeID.toString(),
          'address': flags.contains(true)
              ? location.value.addresses[flags.indexOf(true)]
              : '',
          'purchased_date': dc.text.split('/').reversed.join('-')
        };
        if (user.isOwner ||
            ((user.isContractor || user.isLandlord) && t == PossessorType.me)) {
          // final f1 =
          //     await revealToast('Please Wait....', length: Toast.LENGTH_LONG);
          Loader.show(context);
          final value = await api.addProperty(body);
          Loader.hide();
          // final f2 = await revealToast(value.reply.message);

          if (value.reply.success) {
            log(value.data);
            if (user.role.roleID == 3 ||
                ((user.role.roleID == 5 || user.role.roleID == 4) &&
                    t == PossessorType.me)) {
              final f2 = await showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MediaQuery(
                        data: MediaQueryData.fromWindow(
                                wb?.window ?? WidgetsBinding.instance.window)
                            .copyWith(boldText: false, textScaleFactor: 1.0),
                        child: CupertinoAlertDialog(
                          title: const Text(
                            'Success!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          content: Text(value.reply.message),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                body['type'] = pt?.type ?? '';
                                body['correctDate'] =
                                    body['purchased_date'].toString();
                                // .split('-')
                                // .reversed
                                // .join('/');
                                hp.goTo('/add_property_success',
                                    args: RouteArgument(params: body, id: 1));
                              },
                            ),
                          ],
                        ));
                  });
              // final f2 = await hp.showDialogBox(
              //   title: const Text(
              //     'Success!',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              //   ),
              //   content: Text(value.reply.message),
              //   type: AlertType.cupertino,
              //   actions: <Widget>[
              //     CupertinoDialogAction(
              //       child: const Text(
              //         'OK',
              //         style: TextStyle(
              //             color: Colors.blue, fontWeight: FontWeight.bold),
              //       ),
              //       onPressed: () {
              //         body['type'] = pt?.type ?? '';
              //         body['correctDate'] = body['purchased_date']
              //             .toString();
              //             // .split('-')
              //             // .reversed
              //             // .join('/');
              //         hp.goTo('/add_property_success',
              //             args: RouteArgument(params: body, id: 1));
              //       },
              //     ),
              //   ],
              // );
            } else {
              hp.gotoForever('/mobile_home');
            }
          } else {
            final f2 = await showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return MediaQuery(
                      data: MediaQueryData.fromWindow(
                              wb?.window ?? WidgetsBinding.instance.window)
                          .copyWith(boldText: false, textScaleFactor: 1.0),
                      child: CupertinoAlertDialog(
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                hp.goBack(result: false);
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                hp.goBack();
                                var data = {
                                  'user_id': user.userID.toString(),
                                  'property_id': value.data.toString(),
                                  'qrcode': code.toString()
                                };
                                Loader.show(context);
                                final value2 =
                                    await api.updatePropertyCode(data);
                                Loader.hide();
                                if (value2.success) {
                                  final f3 = await showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MediaQuery(
                                            data: MediaQueryData.fromWindow(
                                                    wb?.window ??
                                                        WidgetsBinding
                                                            .instance.window)
                                                .copyWith(
                                                    boldText: false,
                                                    textScaleFactor: 1.0),
                                            child: CupertinoAlertDialog(
                                              title: const Text(
                                                'Success!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: Text(value2.message),
                                              actions: <Widget>[
                                                CupertinoDialogAction(
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    hp.gotoForever(
                                                        '/mobile_home');
                                                  },
                                                ),
                                              ],
                                            ));
                                      });
                                  // final f3 = await hp.showDialogBox(
                                  //     title: const Text(
                                  //       'Success!',
                                  //       textAlign: TextAlign.center,
                                  //       style: TextStyle(
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //     content: Text(value2.message),
                                  //     actions: <Widget>[
                                  //       CupertinoDialogAction(
                                  //         child: const Text(
                                  //           'OK',
                                  //           style: TextStyle(
                                  //               color: Colors.blue,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //         onPressed: () {
                                  //           hp.gotoForever('/mobile_home');
                                  //         },
                                  //       ),
                                  //     ],
                                  //     type: AlertType.cupertino);
                                } else {
                                  final f4 = await showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MediaQuery(
                                            data: MediaQueryData.fromWindow(
                                                    wb?.window ??
                                                        WidgetsBinding
                                                            .instance.window)
                                                .copyWith(
                                                    boldText: false,
                                                    textScaleFactor: 1.0),
                                            child: CupertinoAlertDialog(
                                                title: const Text(
                                                  'Failure!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(value2.message),
                                                actions: <Widget>[
                                                  CupertinoDialogAction(
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      hp.gotoForever(
                                                          '/mobile_home');
                                                    },
                                                  ),
                                                ]));
                                      });
                                  // final f4 = await hp.showDialogBox(
                                  //     title: const Text(
                                  //       'Failure!',
                                  //       textAlign: TextAlign.center,
                                  //       style: TextStyle(
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //     content: Text(value2.message),
                                  //     actions: <Widget>[
                                  //       CupertinoDialogAction(
                                  //         child: const Text(
                                  //           'OK',
                                  //           style: TextStyle(
                                  //               color: Colors.blue,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //         onPressed: () {
                                  //           hp.gotoForever('/mobile_home');
                                  //         },
                                  //       ),
                                  //     ],
                                  //     type: AlertType.cupertino);
                                }
                              },
                            ),
                          ],
                          title: const Text(
                            'Confirm!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          content: Text(value.reply.message)));
                });
            // final f2 = await hp.showDialogBox(
            //   title: const Text(
            //     'Confirm!',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //   ),
            //   content: Text(value.reply.message),
            //   type: AlertType.cupertino,
            //   actions: <Widget>[
            //     CupertinoDialogAction(
            //       child: const Text(
            //         'Cancel',
            //         style: TextStyle(color: Colors.blue),
            //       ),
            //       onPressed: () {
            //         hp.goBack(result: false);
            //       },
            //     ),
            //     CupertinoDialogAction(
            //       child: const Text(
            //         'OK',
            //         style: TextStyle(
            //             color: Colors.blue, fontWeight: FontWeight.bold),
            //       ),
            //       onPressed: () async {
            //         hp.goBack();
            //         var data = {
            //           'user_id': user.userID.toString(),
            //           'property_id': value.data.toString(),
            //           'qrcode': code.toString()
            //         };
            //         final value2 = await api.updatePropertyCode(data);
            //         if (value2.success) {
            //           final f3 = await hp.showDialogBox(
            //               title: const Text(
            //                 'Success!',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     fontSize: 15, fontWeight: FontWeight.bold),
            //               ),
            //               content: Text(value2.message),
            //               type: AlertType.cupertino,
            //               actions: <Widget>[
            //                 CupertinoDialogAction(
            //                   child: const Text(
            //                     'OK',
            //                     style: TextStyle(
            //                         color: Colors.blue,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                   onPressed: () {
            //                     hp.gotoForever('/mobile_home');
            //                   },
            //                 ),
            //               ]);
            //         } else {
            //           final f4 = await hp.showDialogBox(
            //               title: const Text(
            //                 'Failure!',
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     fontSize: 15, fontWeight: FontWeight.bold),
            //               ),
            //               content: Text(value2.message),
            //               type: AlertType.cupertino,
            //               actions: <Widget>[
            //                 CupertinoDialogAction(
            //                   child: const Text(
            //                     'OK',
            //                     style: TextStyle(
            //                         color: Colors.blue,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                   onPressed: () {
            //                     hp.gotoForever('/mobile_home');
            //                   },
            //                 ),
            //               ]);
            //         }
            //       },
            //     ),
            //   ],
            // );
          }
        } else {
          if (t == PossessorType.other) {
            body['property_type_name'] = pt!.toString();
          }
          log(RouteArgument(content: code, params: body, tag: propertyId));
          hp.goTo(/*'/add_other_user'*/ '/add_landlord',
              args: RouteArgument(
                  content: code, params: body, tag: pt!.toString()));
        }
      }
    } catch (e) {
      Loader.hide();
      log(e);
    }
  }

  void waitUntilPropertyUpdate(
      Property property,
      User user,
      PinCodeResult result,
      bool flag,
      BuildContext context,
      int propertyTypeID,
      String content) async {
    try {
      log(pt);
      final bc = key1.currentContext ?? context;
      final hp = Helper.of(bc);
      if (key1.currentState?.validate() ?? false) {
        final body = {
          'user_id': user.userID.toString(),
          'puuid': property.uuID,
          'property_type': propertyTypeID.toString(),
          'postcode': pc.text,
          'purchased_date': dc.text.split('/').reversed.join('-'),
          'address': adc.text.replaceAll('  ', ', '),
        };
        log(body);
        // final f1 =
        //     await revealToast('Please Wait....', length: Toast.LENGTH_LONG);
        Loader.show(bc);
        final val = await api.updateProperty(body);
        Loader.hide();
        final f2 = await showCupertinoDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return MediaQuery(
                      data: MediaQueryData.fromWindow(
                              wb?.window ?? WidgetsBinding.instance.window)
                          .copyWith(boldText: false, textScaleFactor: 1.0),
                      child: CupertinoAlertDialog(
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  hp.goBack(result: true);
                                },
                                child: const Text('OK'))
                          ],
                          content: Text(val.message),
                          title: Text(val.success ? 'Success' : 'Failure')));
                }) ??
            false;
        // final f2 = await hp.showSimplePopup('OK', () {
        //   hp.goBack(result: true);
        // },
        //     action: val.message,
        //     type: AlertType.cupertino,
        //     title: val.success ? 'Success' : 'Failure');
        if (f2 && val.success) {
          hp.goBack();
          if (flag) {
            hp.goBack();
            if (content == 'true') {
              hp.goBack();
            }
          }
        }
      } else {
        log('else');
      }
    } catch (e) {
      Loader.hide();
      final error = e.toString();
      final f2 = await hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      },
          action: error.contains('RangeError')
              ? 'Please Select An Address'
              : (error.contains('Connection') ? 'Server Error!!!!' : error),
          type: AlertType.cupertino,
          title: 'Error');
      if (f2) {
        log(e);
      }
    }
  }

  void waitForDocumentTypes() async {
    try {
      final list = await api.getDocumentTypes();
      setState(() => kinds = list);
    } catch (e) {
      sendAppLog(e);
      setState(() => kinds = <DocumentType>[]);
      // rethrow;
    }
  }

  // void waitUntilUploadImage(XFile image) async {
  //   try {
  //     final hp =
  //         Helper.of(state == null ? states.first.context : state!.context);
  //     // final f1 =
  //     //     await revealToast('Please Wait.....', length: Toast.LENGTH_LONG);
  //     final val = await api.uploadImage(image);
  //     // final f2 = await revealToast(val.reply.message);
  //     if (val.reply.success) {
  //       hp.goBack();
  //       setState(() => imageURL = val.data.toString());
  //     }
  //   } catch (e) {
  //     sendAppLog(e);
  //   }
  // }

  void waitUntilDocumentAdd(Map<String, dynamic> body) async {
    try {
      final hp = Helper.of(key2.currentContext!);
      log(body);
      // final f1 =
      //     await revealToast('Please Wait.....', length: Toast.LENGTH_LONG);
      final value = await api.addDocument(body);
      // final f2 = await revealToast(value.message);
      log(value.success);
      if (value.success) {
        hp.goBack();
      }
    } catch (e) {
      // final f = await revealToast('Document Add Error');
      // if (f)
      log(e);
    }
  }

  void waitUntilDocumentUpdate(Map<String, dynamic> body) async {
    try {
      // final hp = Helper.of(key2.currentContext!);
      // final f1 =
      //     await revealToast('Please Wait.....', length: Toast.LENGTH_LONG);
      final value = await api.editDocument(body);
      // final f2 = await revealToast(value.message);
      if (value.success) {
        hp.gotoForever('/mobile_home');
      }
    } catch (e) {
      sendAppLog(e);
      // if (await revealToast(e.toString()))
      // rethrow;
    }
  }

  // void waitUntilAddMultipleImage(List<XFile> images) async {
  //   try {
  //     // final f1 =
  //     //     await revealToast('Please Wait.....', length: Toast.LENGTH_LONG);
  //     final val = await api.uploadMultipleImages(images);
  //     // final f2 = await revealToast(val.reply.message);
  //     if (val.reply.success) {
  //       hp.goBack();
  //       setState(() => imageURL = val.data.toString());
  //     }
  //   } catch (e) {
  //     sendAppLog(e);
  //   }
  // }

  void waitForContractorProperties() async {
    try {
      // hp.getConnectStatus(vcb: waitForContractorProperties);
      final val = await api.getContractorProperties();
      setState(() {
        properties = val.owned;
        othersProps = val.others;
      });
    } catch (e) {
      setState(() {
        properties = <Property>[];
        othersProps = <Property>[];
      });
      log(e);
    }
  }

  void waitForPropertyScanResult(Map<String, dynamic> body) async {
    try {
      // final p =
      //     await revealToast('Please Wait.....', length: Toast.LENGTH_LONG);
      final value = await api.getPropertyStatus(body);
      final rp = Reply.fromMap(value);
      // final q = await revealToast(rp.message);
      // if (p) {
      if (rp.success) {
        log('came here');
        final val = StatusPropertyBase.fromMap(value);
        final prop = val.property;
        log(prop);
        remainingSpace.value = val.docCount;
        totalDocsCount.value = val.count;
        if (prop.userID != currentUser.value.userID &&
            currentUser.value.isContractor) {
          // final v = await requestAccess(prop);
          // final fl = await revealToast(v.message);
          final map = body;
          props.value = prop;
          prop.onChange();
          val.onChange();
          log(map);
          hp.goTo('/own_property',
              args: RouteArgument(id: 1, tag: map['scancode'], params: map));
        } else {
          var intFind = 0;
          // final fl2 = await revealToast(
          //     'This is your property. You can witness the same at the "Owned" Section under Properties');
          // if (fl2) {
          props.value = prop;
          prop.onChange();
          val.onChange();
          hp.goTo('/own_property',
              args: RouteArgument(id: intFind, tag: body['scancode']));
          // }
        }
      } else {
        final val = OtherData.fromMap(value);
        // final f2 = await hp.showDialogBox(
        //     title: const Text(
        //       'Confirm',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        //     ),
        //     content: const Text(
        //         'No existing property found, Do you want to add a new property?'),
        //     actions: <Widget>[
        //       CupertinoDialogAction(
        //         child: const Text(
        //           'CANCEL',
        //           style: TextStyle(color: Colors.blue),
        //         ),
        //         onPressed: () {
        //           hp.goBack();
        //         },
        //       ),
        //       CupertinoDialogAction(
        //         child: const Text(
        //           'OK',
        //           style: TextStyle(color: Colors.blue),
        //         ),
        //         onPressed: () {
        //           hp.goBack();
        //           hp.goTo('/add_property',
        //               args: RouteArgument(
        //                   content: val.reply.message,
        //                   tag: body['scancode']), vcb: () {
        //             location.value = PinCodeResult.emptyResult;
        //             location.value.onChange();
        //           });
        //         },
        //       ),
        //     ],
        //     type: AlertType.cupertino);
        final f = await showCupertinoDialog(
            context: state?.context ?? states.first.context,
            builder: (BuildContext context) {
              return MediaQuery(
                  data: MediaQueryData.fromWindow(
                          wb?.window ?? WidgetsBinding.instance.window)
                      .copyWith(boldText: false, textScaleFactor: 1.0),
                  child: CupertinoAlertDialog(
                      title: const Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      content: const Text(
                          'No existing property found, Do you want to add a new property?'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            hp.goBack();
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            hp.goBack();
                            hp.goTo('/add_property',
                                args: RouteArgument(
                                    content: val.reply.message,
                                    tag: body['scancode']), vcb: () {
                              location.value = PinCodeResult.emptyResult;
                              location.value.onChange();
                            });
                          },
                        ),
                      ]));
            });
        // f
        //     ? hp.goTo('/add_property',
        //         args: RouteArgument(
        //             content: val.reply.message, tag: body['scancode']))
        //     :
      }
      // }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void waitForNotificationCount() {
    api.getNotificationCount();
  }

  void getPropertyData(Property property) async {
    try {
      final val = await api.getSinglePropertyData(property);
      log('asdas');
      log(val);
      setState(() {
        p = val;
      });
    } catch (e) {
      sendAppLog(e);
    }
  }
}
