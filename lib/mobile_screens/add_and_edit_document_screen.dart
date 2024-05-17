import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../backend/api.dart';
import '../models/misc_data.dart';
import '../models/reply.dart';
import '../widgets/loader.dart';
import '../helpers/helper.dart';
import '../models/document.dart';
import '../models/property.dart';
import '../models/document_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/property_and_document_controller.dart';

class AddAndEditDocumentScreen extends StatefulWidget {
  final Document? document;

  const AddAndEditDocumentScreen({Key? key, this.document}) : super(key: key);

  @override
  AddAndEditDocumentScreenState createState() =>
      AddAndEditDocumentScreenState();
}

class AddAndEditDocumentScreenState extends StateMVC<AddAndEditDocumentScreen> {
  File? file;
  dynamic valueOfDate;
  bool doctype = false;
  ImagePicker picker = ImagePicker();
  List<XFile> imagesList = <XFile>[];
  late PropertyAndDocumentController con;
  Helper get hp => Helper.of(context);

  AddAndEditDocumentScreenState() : super(PropertyAndDocumentController()) {
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
    return MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(boldText: false, textScaleFactor: 1.0),
        child: otherScaffolds(context, property, child));
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
    hp.getConnectStatus();
    con.waitForDocumentTypes();
    wb?.addPostFrameCallback(show);
  }

  void show(Duration time) async {
    // void check(XFile file) async {
    //   try {
    //     final bytes = await file.readAsBytes();
    //     final kb = bytes.lengthInBytes / 1024;
    //     final mb = kb / 1024;
    //     log('Size: $mb MB ($kb KB)');
    //     // if (mounted) {
    //     //   setState(() {
    //     sizeInKB += kb;
    //     sizeInMB += mb;
    //     //   });
    //     // }
    //   } catch (e) {
    //     sendAppLog(e);
    //   }
    // }
    log(time);
    log('object');
    final p = await Future.delayed(time > Duration.zero ? Duration.zero : time,
        () async {
      // Loader.show(context);
      final p = await showCupertinoModalPopup<PickImageType>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext cont) {
            final hpb = Helper.of(cont);
            return CupertinoActionSheet(
              title: const Text('Select an option'),
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      hpb.goBack(result: PickImageType.camera);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Open Camera',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )),
                CupertinoActionSheetAction(
                  onPressed: () {
                    hpb.goBack(result: PickImageType.gallery);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.image,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Select From Gallery',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                )
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: hpb.goBack,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.cancel,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            );
          });
      // Loader.hide();
      if (imagesList.length > 10 &&
          await hp.showSimplePopup('OK', () {
            hp.goBack(result: true);
          },
              action: 'Please select a maximum of 10 images ONLY.',
              type: AlertType.cupertino,
              title: title)) {
      } else {
        switch (p) {
          case PickImageType.camera:
            _imgFromCamera();
            break;
          case PickImageType.gallery:
            _imgFromGallery();
            break;
          default:
            imagesList.isEmpty ? hp.goBack() : doNothing();
            break;
        }
      }
    });
    log(p);
  }

  void _imgFromCamera() async {
    try {
      Loader.show(context);
      final image =
          await picker.pickImage(source: ImageSource.camera) ?? XFile('');
      Loader.hide();
      log(image);
      if (image.path.isNotEmpty && imagesList.length < 10) {
        imagesList.add(image);
        switchAccordingToOs(acb: () async {
          final sf = await ut.savePDF(await ut.createPDF(imagesList));
          mounted
              ? setState(() {
                  file = sf;
                })
              : doNothing();
        }, dcb: () {
          mounted ? setState(() {}) : doNothing();
        });
      } else if (imagesList.length >= 10 &&
          await hp.showSimplePopup(hp.loc.ok, () {
            hp.goBack(result: true);
          },
              title: title,
              type: AlertType.cupertino,
              action: 'Please select a maximum of 10 images ONLY.')) {
        log('object');
      } else {
        log('Exception');
      }
    } catch (e) {
      Loader.hide();
      sendAppLog(e);
    }
  }

  void _imgFromGallery() async {
    try {
      Loader.show(context);
      final images = await picker.pickMultiImage(imageQuality: 20) ?? <XFile>[];
      Loader.hide();
      log(images);
      if (images.isNotEmpty && images.length + imagesList.length <= 10) {
        imagesList.addAll(images);
        log(imagesList);
        switchAccordingToOs(acb: () async {
          final sf = await ut.savePDF(await ut.createPDF(imagesList));
          mounted
              ? setState(() {
                  file = sf;
                })
              : doNothing();
        }, dcb: () {
          mounted ? setState(() {}) : doNothing();
        });
      } else if ((images.length + imagesList.length > 10) &&
          await hp.showSimplePopup(hp.loc.ok, () {
            hp.goBack(result: true);
          },
              title: title,
              type: AlertType.cupertino,
              action: 'Please select a maximum of 10 images ONLY.')) {
        imagesList.length < 10 ? _imgFromGallery() : log('object');
      } else {}
    } catch (e) {
      Loader.hide();
      sendAppLog(e);
    }
  }

  Widget otherScaffolds(
      BuildContext context, Property property, Widget? child) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: hp.leadingWidth,
          leading: const LeadingWidget(visible: false),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         log(hp.height);
          //       },
          //       icon: const Icon(Icons.abc))
          // ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: hp.theme.primaryColor,
          foregroundColor: hp.theme.scaffoldBackgroundColor,
          title: Text('${widget.document == null ? "Add" : "Edit"} Document',
              style: const TextStyle(fontWeight: FontWeight.w600))),
      drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
      bottomNavigationBar: const BottomWidget(),
      body: viewLoad(context, property, child),
    );
  }

  Widget viewLoad(BuildContext context, Property property, Widget? child) {
    final hpv = Helper.of(context);
    double ht;
    Widget imgs;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        ht = (hpv.height * imagesList.length) /
            (imagesList.length < 4
                ? (hpv.height < 815 ? 8 : 8.192)
                : (imagesList.length < 9
                    ? (hpv.height > 815
                        ? 12.5
                        : (hpv.height < 815
                            ? 11.25899906842624
                            : 11.52921504606846976))
                    : (imagesList.length < 10
                        ? (hpv.height < 815 ? 12.5 : 15.625)
                        : (hpv.height < 815
                            ? 14.4115188075855872
                            : 17.179869184))));
        imgs = SfPdfViewer.file(file ?? File(''));
        break;
      default:
        imgs = ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext ctx, int index) {
              return Image.file(File(imagesList[index].path),
                  width: hpv.width / 2.56,
                  height: hpv.height / 4,
                  fit: BoxFit.contain,
                  errorBuilder: errorBuilder,
                  semanticLabel: imagesList[index].name);
            },
            itemCount: imagesList.length);
        ht = (imagesList.length * hpv.height) / 2.56;
        break;
    }
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Document Details',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Document Capture',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
                visible: widget.document == null,
                child: file == null || imagesList.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          show(Duration.zero);
                        },
                        child: Image.asset('${assetImagePath}logo.png',
                            fit: BoxFit.contain,
                            width: double.infinity,
                            errorBuilder: errorBuilder,
                            height: 150))
                    : RawGestureDetector(
                        gestures: {
                            AllowMultipleGestureRecognizer:
                                GestureRecognizerFactoryWithHandlers<
                                    AllowMultipleGestureRecognizer>(
                              () =>
                                  AllowMultipleGestureRecognizer(), //constructor
                              (AllowMultipleGestureRecognizer instance) {
                                //initializer
                                instance.onTap = () => show(Duration.zero);
                                instance.onTapUp = (TapUpDetails details) {
                                  log(details.kind);
                                  log(imagesList.length);
                                };
                                instance.onTapDown = (TapDownDetails details) {
                                  log(details.kind);
                                  log(imagesList.length);
                                };
                              },
                            )
                          },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)),
                            height: ht,
                            child: imgs))),
            Visibility(
                visible: con.alertFlags ? imagesList.isEmpty : false,
                child: const Text('Please Choose a file',
                    style: TextStyle(color: Colors.red))),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Document Name',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
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
            Visibility(
                visible: con.alertFlags ? con.nc.text.isEmpty : false,
                child: const Text('Enter the Document name',
                    style: TextStyle(color: Colors.red))),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Document Type',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
            ),
            const SizedBox(
              height: 5,
            ),
            textFormField(context),
            errordoctype(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Expiration Date',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
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
                  final dt = await con.getDatePicker(
                      alertType: AlertType.cupertino, context: context);
                  log(valueOfDate);
                  log('enathan varudhu');
                  log(dt);
                  valueOfDate = dt;
                  setState(() {
                    con.dc.text = putDateToString(valueOfDate);
                  });
                }),
            Visibility(
                visible: con.alertFlags ? con.dc.text.isEmpty : false,
                child: const Text('Select the Expiration date',
                    style: TextStyle(color: Colors.red))),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<int>(
                valueListenable: totalDocsCount,
                builder: (BuildContext context, int value, Widget? child) =>
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            con.nc.text.isEmpty ||
                                    con.abc.text.isEmpty ||
                                    con.dc.text.isEmpty ||
                                    imagesList.isEmpty ||
                                    imagesList.length > 10 && mounted
                                ? setState(() {
                                    con.alertFlags = true;
                                  })
                                : waitUntilAddMultipleImage(
                                    imagesList, property, value);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  hp.theme.primaryColor)),
                          child: const Text(
                            'Upload and Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )),
                    ))
          ],
        ));
  }

  void waitUntilAddMultipleImage(
      List<XFile> images, Property property, int value) async {
    try {
      Loader.show(context);
      log(images.length);
      // final val = await api.uploadImages(images);
      final val = await uploadImages(images);
      Loader.hide();
      if (val.reply.success) {
        log(val.data);
        log(property.userID);
        log(property.propID);
        waitUntilDocumentAdd(con.getAddOrEditDocumentMap(
            document: widget.document,
            property: property,
            value: value,
            imageValue: val.data));
      } else if (await hp.showSimplePopup(hp.loc.ok, () {
        hp.goBack(result: true);
      },
          title: 'Error',
          type: AlertType.cupertino,
          action: val.reply.message)) {
        log('object');
      }
    } on SocketException {
      Loader.hide();
      !hp.isDialogOpen &&
              await hp.showSimplePopup('OK', () {
                hp.goBack(result: true);
              },
                  title: 'Error',
                  type: AlertType.cupertino,
                  action: 'No Internet connection 😑')
          ? log('No Internet connection 😑')
          : doNothing();
    } on HttpException {
      Loader.hide();
      !hp.isDialogOpen &&
              await hp.showSimplePopup('OK', () {
                hp.goBack(result: true);
              },
                  title: 'Error',
                  type: AlertType.cupertino,
                  action: 'Service not found. Please try later.....')
          ? log("Couldn't find the post 😱")
          : doNothing();
    } on FormatException {
      Loader.hide();
      !hp.isDialogOpen &&
              await hp.showSimplePopup('OK', () {
                hp.goBack(result: true);
              },
                  title: 'Error',
                  type: AlertType.cupertino,
                  action: 'Server error. Please try later.....')
          ? log('Bad response format 👎')
          : doNothing();
    }
  }

  void waitUntilDocumentAdd(Map<String, dynamic> body) async {
    try {
      Loader.show(context);
      log(body);
      final value = await api.addDocument(body);
      log(value.success);
      Loader.hide();
      if (value.success &&
          await hp.showSimplePopup('OK', () {
            hp.goBack(result: true);
          },
              action: value.message.replaceAll('.', ''),
              type: AlertType.cupertino,
              title: 'Success')) {
        hp.goBack();
      } else if (await hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      }, action: value.message, type: AlertType.cupertino, title: 'Failure')) {
        log('error');
      }
    } on SocketException {
      Loader.hide();
      !hp.isDialogOpen &&
              await hp.showSimplePopup('OK', () {
                hp.goBack(result: true);
              },
                  title: 'Error',
                  type: AlertType.cupertino,
                  action: 'No Internet connection 😑')
          ? log('No Internet connection 😑')
          : doNothing();
    } on HttpException {
      Loader.hide();
      !hp.isDialogOpen &&
              await hp.showSimplePopup('OK', () {
                hp.goBack(result: true);
              },
                  title: 'Error',
                  type: AlertType.cupertino,
                  action: 'Service not found. Please try later.....')
          ? log("Couldn't find the post 😱")
          : doNothing();
    } on FormatException {
      Loader.hide();
      !hp.isDialogOpen &&
              await hp.showSimplePopup('OK', () {
                hp.goBack(result: true);
              },
                  title: 'Error',
                  type: AlertType.cupertino,
                  action: 'Server error. Please try later.....')
          ? log('Bad response format 👎')
          : doNothing();
    } on DioError {
      doNothing();
    }
  }

  Future<OtherData> uploadImages(List<XFile> images) async {
    final dio = Dio(BaseOptions(
        sendTimeout: 120000, connectTimeout: 120000, receiveTimeout: 120000));
    try {
      // num sizeInMB = 0.0;
      log('${api.baseURL}upload_documents');
      final formData = await generateFormData(images);
      final reponse = await dio.post<String>('${api.baseURL}upload_documents',
          data: formData);
      dio.close();
      // log('Total Size: $sizeInMB MB');
      log(reponse.data);
      log(reponse.statusCode);
      final od = OtherData.fromMap(
          json.decode(reponse.data ?? '{}') ?? <String, dynamic>{});
      od.onChange();
      return reponse.statusCode == 200 ? od : OtherData(Reply.emptyReply, null);
    } catch (e) {
      Loader.hide();
      String s = '';
      sendAppLog(e);
      if (e is DioError) {
        log('7685645764');
        log(e.message);
        log('_result');
        log(e.type);
        log('_result2');
        log(e.error.toString());
        log('0990909');
        switch (e.type) {
          case DioErrorType.sendTimeout:
          case DioErrorType.connectTimeout:
          case DioErrorType.receiveTimeout:
            s = 'Check your connection and try again.....';
            break;
          case DioErrorType.response:
            s = (e.response?.statusCode ?? 404) == 404
                ? 'Request not found !!!!'
                : (e.response?.statusCode == 403
                    ? 'Unauthorized request !!!!'
                    : 'Server error. Please try later.....');
            break;
          case DioErrorType.cancel:
            s = 'Request Cancelled.....';
            break;
          case DioErrorType.other:
          default:
            s = e.message.contains('Socket')
                ? 'Check your connection and try again.....'
                : e.message;
            break;
        }
      } else {
        s = e.toString();
      }
      !hp.isDialogOpen &&
              await hp.showSimplePopup('OK', () {
                hp.goBack(result: true);
              }, title: 'Error', type: AlertType.cupertino, action: s)
          ? log(s)
          : doNothing();
      rethrow;
    } finally {
      dio.close(force: true);
    }
  }

  Widget textFormField(BuildContext context) {
    return TextFormField(
      controller: con.abc,
      textAlign: TextAlign.start,
      readOnly: true,
      onTap: () {
        showDialog1(context);
      },
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(
            vertical: hp.height / 100, horizontal: hp.width / 40),
        border: const OutlineInputBorder(),
        hintText: 'Select Document Type',
        // label: Text(con.pt?.type ?? '', style: con.pt?.type == '' ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
        suffixIcon: const Icon(
          Icons.arrow_drop_down_outlined,
          color: Colors.black87,
        ),
      ),
    );
  }

  void showDialog2(BuildContext context) {
    hp.currentScope.unfocus();
    hp.currentScope.unfocus();
    if (con.kinds?.isEmpty ?? true) {
      Loader.show(context);
      con.waitForDocumentTypes();
      Loader.hide();
    }

    showCupertinoDialog(
        context: context,
        builder: (context) {
          // final hpd = Helper.of(context);
          return StatefulBuilder(
            builder: (context, setState) {
              return CupertinoAlertDialog(
                title: const Text('Select Document type'),
                content: SizedBox(
                    height: 300.0, // Change as per your requirement
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Container(padding: const EdgeInsets.only(top:15),child:

                                      // Text(con.types?[index].type ?? '',textAlign: TextAlign.left, style: const TextStyle(fontSize: 15, color: Colors.black,),

                                      // ),

                                      Expanded(
                                        flex: 10,
                                        child: Container(
                                          //  color: Colors.red,

                                          child: con.dt == con.kinds?[index]
                                              ? Text(
                                                  con.kinds?[index].type ?? '',
                                                  textAlign: TextAlign.left,
                                                  softWrap: true,

                                                  /*overflow:

                                                      TextOverflow.ellipsis,*/

                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blue,
                                                  ))
                                              : Text(
                                                  con.kinds?[index].type ?? '',
                                                  textAlign: TextAlign.left,
                                                  softWrap: true,

                                                  /*overflow:

                                                      TextOverflow.ellipsis,*/

                                                  style: const TextStyle(
                                                    fontSize: 12,
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
                actions: [
                  CupertinoDialogAction(
                      child: const Text('Cancel'),
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
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () {
                      con.abc.text = con.dt?.type ?? '';
                      setState(() {
                        doctype = con.dt?.type.isNotEmpty ?? false;
                        textFormField(context);
                        errordoctype();
                        errordoctype();
                      });
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        });

    /*setState((){

    });*/
  }

  void showDialog1(BuildContext context) {
    hp.currentScope.unfocus();
    hp.currentScope.unfocus();
    if (con.kinds?.isEmpty ?? true) {
      Loader.show(context);
      con.waitForDocumentTypes();
      Loader.hide();
    }

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
          alignment: Alignment.topCenter,
          content: SizedBox(

              /*height: 300.0, */ // Change as per your requirement

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

                                Expanded(
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
                                              fontSize: 12,
                                              color: Colors.blue,
                                            ))
                                        : Text(
                                            con.kinds?[index].type ?? '',
                                            textAlign: TextAlign.left,
                                            softWrap: true,

                                            /*overflow:

                                      TextOverflow.ellipsis,*/

                                            style: const TextStyle(
                                              fontSize: 12,
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
                setState(() {
                  doctype = con.dt?.type.isNotEmpty ?? false;
                  textFormField(context);
                  errordoctype();
                  errordoctype();
                });

                Navigator.of(context).pop();
              },
            )
          ],
        );
      }),
    );
  }

  Future<DateTime?> getDatePicker(
      {AlertType? alertType,
      DateTime? dateTime,
      required BuildContext context}) async {
    // final today = DateTime.now();
    final DateTime picked;
    switch (alertType) {
      case AlertType.cupertino:
        picked = (await showIOSStyleDatePicker(initial: dateTime))!;
        break;
      case AlertType.normal:
      default:
        picked = (await showIOSStyleDatePicker(initial: dateTime))!;
        break;
    }
    log(picked);
    return picked;
  }

  Future<DateTime?> showIOSStyleDatePicker({DateTime? initial}) async {
    Widget iOSDatePickerBuilder(BuildContext context) {
      dynamic dat;

      //  dynamic donedat;

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

                              hp.goBack(result: valueOfDate);
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

                              hp.goBack(result: valueOfDate);
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

                    // maximumDate: lastDate,

                    initialDateTime: initial,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: onDateTimeChanged))
          ]));
    }

    if (initial == null) {
      final picked = await showCupertinoModalPopup<DateTime>(
          context: context, builder: iOSDatePickerBuilder);

      return picked;
    } else {
      final picked = await showCupertinoModalPopup<DateTime>(
          context: context, builder: iOSDatePickerBuilder);

      return picked;
    }
  }

  Widget errordoctype() {
    log(con.abc.text);
    log(con.alertFlags);
    log(con.abc.text.isEmpty);
    return Visibility(
        visible: con.alertFlags ? con.abc.text.isEmpty : false,
        child: const Text('Select the Document type',
            style: TextStyle(color: Colors.red)));
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
