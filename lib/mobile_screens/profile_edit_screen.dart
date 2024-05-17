import '../models/pin_code_result.dart';
import '../models/route_argument.dart';

import '../backend/api.dart';
import '../models/user.dart';
import '../helpers/helper.dart';
import '../widgets/empty_widget.dart';
import '../widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/leading_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  final RouteArgument rar;
  const ProfileEditScreen({Key? key, required this.rar}) : super(key: key);

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends StateMVC<ProfileEditScreen> {
  late UserController con;
  FocusNode node = FocusNode();
  Helper get hp => Helper.of(context);
  bool firstnameFlag = false;
  bool lastnameflag = false;
  bool emailFlag = false;
  bool phoneFlag = false;
  bool passwordFlag = false;
  bool confirmPasswordFlag = false;
  bool buttonActive = true;
  bool loaderFlag = false;
  bool sugestPassword = false;
  bool passwordVisible = false;
  String newPassword = '';
  String newPassword2 = '';
  String newPassword3 = '';
  bool passwordcopypasteFlag = false;
  bool suggestChange = false;
  final focus = FocusNode();
  ProfileEditScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  Widget getItemBuilder(BuildContext context, int index) {
    void onChanged(bool? val) {
      if (con.flags.isNotEmpty) {
        setState(() {
          if (con.flags.contains(true)) {
            con.flags[con.flags.indexOf(true)] = false;
            con.flags[index] = true;
          } else {
            con.flags[index] = val ?? false;
          }
          con.adc.text = location.value.addresses[index];
        });
      }
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
          child: Text(location.value.addresses.isEmpty
              ? ''
              : location.value.addresses[index])),
      Expanded(
          child: Checkbox(
              value: con.flags.isNotEmpty ? con.flags[index] : false,
              onChanged: onChanged))
    ]);
  }

  // Widget getCheckBoxBuilder(BuildContext context, int index) {
  //   void onChanged(bool? val) {
  //     setState(() => con.ticks[index] = val ?? false);
  //   }

  //   return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
  //     Expanded(
  //         child: Text(con.sectors[index],
  //             style: TextStyle(
  //                 fontSize: 15,
  //                 decoration:
  //                     con.ticks[index] ? TextDecoration.underline : null,
  //                 color: con.ticks[index] ? Colors.blue : Colors.black))),
  //     Expanded(child: Checkbox(value: con.ticks[index], onChanged: onChanged))
  //   ]);
  // }

  Widget getCheckBoxBuilder(BuildContext context, int index) {
    final hpc = Helper.of(context);
    void onChanged(bool? val) {
      setState(() => con.ticks[index] = val ?? false);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      // Expanded(child: Text(hpc.sectors[index])),
      Flexible(
          flex: 6,
          child: (con.ticks[index] == true)
              ? Text(
                  sectors[index],
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                )
              : Text(
                  sectors[index],
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                )),
      Flexible(
          flex: 1,
          child: Checkbox(value: con.ticks[index], onChanged: onChanged))
    ]);
  }

  Widget pageBuilder(BuildContext context, User user, Widget? child) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MediaQuery(
          data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .copyWith(boldText: false, textScaleFactor: 1.0),
          child: Scaffold(
              //  key: hp.key,
              drawer:
                  Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
              bottomNavigationBar: const BottomWidget(),
              body: user.isEmpty
                  ? Center(
                      child: CustomLoader(
                          sizeFactor: 10,
                          duration: const Duration(seconds: 10),
                          color: hp.theme.primaryColor,
                          loaderType: LoaderType.fadingCircle))
                  : Form(
                      key: con.editProfileFormKey,
                      child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              horizontal: hp.width / 25,
                              vertical: hp.height / 50),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //     // color: Colors.amber,
                                //     height: 50,
                                //     padding: const EdgeInsets.only(top: 5, bottom: 0),
                                //     child: TextFormField(
                                //         controller: con.fnc,
                                //         validator: nameValidator,
                                //         decoration: InputDecoration(
                                //             contentPadding: EdgeInsets.symmetric(
                                //                 vertical: hp.height / 100,
                                //                 horizontal: hp.width / 40),
                                //             border: const OutlineInputBorder(),
                                //             hintText: 'First Name'))),
                                // Container(
                                //     height: 50,
                                //     padding: const EdgeInsets.only(top: 5, bottom: 0),
                                //     child: TextFormField(
                                //         controller: con.lnc,
                                //         validator: nameValidator,
                                //         decoration: InputDecoration(
                                //             contentPadding: EdgeInsets.symmetric(
                                //                 vertical: hp.height / 100,
                                //                 horizontal: hp.width / 40),
                                //             border: const OutlineInputBorder(),
                                //             hintText: 'Last Name'))),
                                const Text(
                                  'First Name',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                firstnamefield(),
                                const Text(
                                  'Last Name',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                lastnamefield(),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Email',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                emailField(),

                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Phone',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                phoneField(),
                                // Container(
                                //     height: 75,
                                //     child: TextFormField(
                                //         keyboardType: TextInputType.phone,
                                //         controller: con.phc,
                                //         validator: phoneNumberValidator,
                                //         decoration: InputDecoration(
                                //             contentPadding: EdgeInsets.symmetric(
                                //                 vertical: hp.height / 100,
                                //                 horizontal: hp.width / 40),
                                //             border: const OutlineInputBorder(),
                                //             hintText: 'Phone Number')),
                                //     padding: EdgeInsets.only(
                                //         top: 5, bottom: 0)),

                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Postcode',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: TextField(
                                            // onTap: con.lookUpButtonOnTap,
                                            controller: con.pc,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            onChanged: (value) {
                                              con.pc.value = (TextEditingValue(
                                                  text: value.toUpperCase(),
                                                  selection: con.pc.selection));
                                            },
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                            ],
                                            // onChanged: con.waitUntilAddressObtained,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Postcode')),
                                      ),
                                    ),

                                    //  const SizedBox(width: 10,),
                                    Flexible(
                                      flex: hp.dimensions.orientation ==
                                              Orientation.landscape
                                          ? hp.isTablet
                                              ? 1
                                              : 2
                                          : hp.isTablet
                                              ? 2
                                              : (hp.isMobile
                                                  ? (hp.height > 599 ? 4 : 6)
                                                  : 3),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          loaderFlag = true;
                                          setState(() {});
                                          // textFormField();
                                          con.adc.text = '';
                                          // hp.addLoader(const Duration(seconds: 10));
                                          if (con.pc.text.isNotEmpty) {
                                            pincodeAPI(con.pc.text);
                                          } else {
                                            final p = await hp.showSimplePopup(
                                                'OK', () {
                                              hp.goBack(result: true);
                                              location.value =
                                                  PinCodeResult.emptyResult;
                                              location.value.onChange();
                                              setState(() {
                                                loaderFlag = false;
                                                textFormField();
                                              });
                                            },
                                                action:
                                                    'Please enter the postcode to select an address.',
                                                type: AlertType.cupertino,
                                                title: title);
                                          }

                                          // hp.hideLoader(const Duration(seconds: 10));
                                        },
                                        style: ButtonStyle(
                                            fixedSize:
                                                MaterialStateProperty.all(
                                                    const Size(100, 50)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    hp.theme.primaryColor)),
                                        child: const Text(
                                          'Lookup',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 40,
                                ),

                                const Text(
                                  'Select an Address',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),

                                textFormField(),
                                // ValueListenableBuilder<PinCodeResult>(valueListenable: location, builder: addressesListBuilder),

                                const SizedBox(
                                  height: 40,
                                ),

                                Visibility(
                                    visible: user.role.roleID == 5,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            'Company Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              // color: Colors.amber,
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: TextFormField(
                                                  // maxLength: 100,
                                                  // maxLengthEnforcement: MaxLengthEnforcement.none,
                                                  controller: con.compNa,
                                                  onChanged: (String val) {
                                                    if (RegExp('\\s+').hasMatch(
                                                        con.compNa.text)) {
                                                      con.compNa.text =
                                                          val.replaceAll(
                                                              RegExp('\\s+'),
                                                              ' ');
                                                    }
                                                    con.compNa.selection =
                                                        TextSelection.collapsed(
                                                            offset: con.compNa
                                                                .text.length);
                                                  },
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        30),
                                                    // FilteringTextInputFormatter.deny(
                                                    //     RegExp(r'[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]')),
                                                    FilteringTextInputFormatter(
                                                        RegExp(
                                                            '[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]'),
                                                        allow: false)
                                                  ],
                                                  // validator: hp.nameValidator,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  hp.height /
                                                                      100,
                                                              horizontal:
                                                                  hp.width /
                                                                      40),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      hintText:
                                                          'Company Name')))
                                        ])),

                                Visibility(
                                    visible: user.role.roleID == 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Company Number',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            // color: Colors.amber,
                                            height: 50,
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: TextFormField(
                                                controller: con.compNo,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      15),
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp('[0-9 ]')),
                                                ],
                                                // validator: hp.nameValidator,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                hp.height / 100,
                                                            horizontal:
                                                                hp.width / 40),
                                                    border:
                                                        const OutlineInputBorder(),
                                                    hintText:
                                                        'Company Number'))),
                                      ],
                                    )),

                                Visibility(
                                    visible: user.role.roleID == 5,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            'Company Registration No',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              // color: Colors.amber,
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: TextFormField(
                                                  controller: con.compRegNo,
                                                  // validator: hp.nameValidator,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  hp.height /
                                                                      100,
                                                              horizontal:
                                                                  hp.width /
                                                                      40),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      hintText:
                                                          'Company Registration No'))),
                                        ])),

                                Visibility(
                                    visible: user.role.roleID == 5,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Sectors',
                                            textScaleFactor: 1.0,
                                            style: hp.textTheme.headline6))),
                                Visibility(
                                    visible: user.role.roleID == 5,
                                    child: SizedBox(
                                        height: con.sectors.length *
                                            (hp.isTablet
                                                ? 32
                                                : (hp.isMobile ? 32 : 20)),
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            // padding: const EdgeInsets.only(
                                            //     top:
                                            //         0), //EdgeInsets.only(top: hp.height / 64),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: hp.width /
                                                        (hp.height /
                                                            (hp.dimensions
                                                                        .orientation ==
                                                                    Orientation
                                                                        .landscape
                                                                ? hp.isTablet
                                                                    ? 6.5536
                                                                    : 3
                                                                : hp.isTablet
                                                                    ? 8.25
                                                                    : hp.height >
                                                                            699
                                                                        ? 6.5536
                                                                        : 4.6)),
                                                    crossAxisCount: 2),
                                            itemBuilder: getCheckBoxBuilder,
                                            itemCount: con.sectors.length))),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Password',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                passwordField(),
                                const SizedBox(height: 5),
                                const Text(
                                  'Confirm Password',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                confirmPasswordField(),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  width: hp.width,
                                  child: ElevatedButton(
                                    onPressed: buttonActive
                                        ? () async {
                                            formatNickname();
                                            log(con.compNa.text);
                                            log(con.compNa.text.length);
                                            if (user.role.roleID == 3) {
                                              if (con.pwc.text.isEmpty &&
                                                  con.pcc.text.isEmpty) {
                                                con.waitUntilProfileUpdate(
                                                    user);
                                              } else {
                                                if (con.pwc.text.isNotEmpty ||
                                                    con.pcc.text.isNotEmpty) {
                                                  if (con.pwc.text.isNotEmpty) {
                                                    if (con
                                                        .pcc.text.isNotEmpty) {
                                                      if (con.pwc.text ==
                                                          con.pcc.text) {
                                                        con.waitUntilProfileUpdate(
                                                            user);
                                                      } else {
                                                        hp.showSimplePopup('OK',
                                                            () {
                                                          hp.goBack(
                                                              result: true);
                                                        },
                                                            action:
                                                                'Password and Confirm Password is not same.',
                                                            type: AlertType
                                                                .cupertino,
                                                            title: 'Confirm!');
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            } else {
                                              con.waitUntilProfileUpdate(user);
                                            }
                                          }
                                        : null,

                                    style: ElevatedButton.styleFrom(
                                        primary: hp.theme.primaryColor,
                                        onSurface: hp.theme
                                            .primaryColor), //ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(hp.theme.primaryColor)),
                                    child: const Text('Update Profile',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  // padding: EdgeInsets.only(
                                  //     top: hp.height / 100, bottom: hp.height / 100)
                                ),
                              ]))),
              appBar: AppBar(
                  leadingWidth: hp.leadingWidth,
                  leading: const LeadingWidget(visible: false),
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: hp.theme.primaryColor,
                  foregroundColor: hp.theme.scaffoldBackgroundColor,
                  title: const Text('Edit Profile'))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return pageBuilder(context, widget.rar.params, const EmptyWidget());

    // ValueListenableBuilder<User>(
    //     valueListenable: currentUser,
    //     builder: pageBuilder,
    //     child: const EmptyWidget());
  }

  @override
  void initState() {
    node.addListener(() {
      if (!node.hasFocus) {
        formatNickname();
      }
    });
    super.initState();
    con.setValues(widget.rar.params);
    if (con.pc.text.isNotEmpty) {
      loaderFlag = true;
      pincodeAPI(con.pc.text);
    } else {
      pincodeAPI(widget.rar.params.pinCode);
    }
    // con.waitUntilAddressObtained(currentUser.value.pinCode);
  }

  void formatNickname() {
    con.compNa.text = con.compNa.text.replaceAll('  ', ' ');
  }

  Widget emailField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: emailFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                style: const TextStyle(
                  fontSize: 16,
                ),
                controller: con.emc,
                onChanged: (textLabel) {
                  if (hp.emailValidator(textLabel) == null) {
                    emailFlag = false;
                  } else {
                    emailFlag = true;
                  }
                  emailField();
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    // suffixIcon: (con.pwc.text.isNotEmpty) ? passwordFlag ? const Icon(Icons.cancel,color: Colors.red,) : const Icon(Icons.check, color: Colors.green,) : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Email Address')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: emailFlag,
              child: Text(
                hp.emailValidator(con.emc.text) ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget phoneField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: phoneFlag ? 78 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                style: const TextStyle(
                  fontSize: 16,
                ),
                controller: con.phc,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15),
                  FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),
                ],
                onChanged: (textLabel) {
                  //   if (RegExp('\\s+').hasMatch(con.compNa.text)) {
                  //   con.compNa.text = textLabel.replaceAll(RegExp('\\s+'), ' ');
                  // }
                  // con.compNa.selection =
                  //     TextSelection.collapsed(offset: con.compNa.text.length);
                  if (phoneNumberValidator(textLabel) == null) {
                    phoneFlag = false;
                  } else {
                    phoneFlag = true;
                  }
                  phoneField();
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    // suffixIcon: (con.pwc.text.isNotEmpty) ? passwordFlag ? const Icon(Icons.cancel,color: Colors.red,) : const Icon(Icons.check, color: Colors.green,) : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Phone Number')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: phoneFlag,
              child: Text(
                phoneNumberValidator(con.phc.text) ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

/*
  Widget passwordField() {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        height: passwordFlag ? 200 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                obscureText: true,
                controller: con.pwc,
                onChanged: (textLabel) {
                  setState(() {
                    buttonActive = false;
                  });
                  if (con.pwc.text.isNotEmpty) {
                    if (hp.passwordValidstructure(textLabel) == null) {
                      passwordFlag = false;
                    } else {
                      passwordFlag = true;
                    }
                  } else {
                    if (con.pwc.text.isEmpty && con.pcc.text.isEmpty) {
                      setState(() {
                        buttonActive = true;
                      });
                    } else {
                      setState(() {
                        buttonActive = false;
                      });
                    }
                    passwordFlag = false;
                  }
                  passwordField();
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    suffixIcon: (con.pwc.text.isNotEmpty)
                        ? passwordFlag
                            ? const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                        : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Password')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
                visible: passwordFlag,
                child: hp.passwordValidstructure(con.pwc.text) ?? const Text(''))
          ],
        ));
  }

  Widget confirmPasswordField() {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        height: confirmPasswordFlag ? 60 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                obscureText: true,
                controller: con.pcc,
                onChanged: (textLabel) {
                  if (con.pcc.text.isNotEmpty) {
                    if (con.pcc.text == con.pwc.text) {
                      //  setState(() { buttonActive = true; });
                      if (hp.passwordValidstructure(textLabel) == null) {
                        setState(() {
                          buttonActive = true;
                        });
                        confirmPasswordFlag = false;
                      } else {
                        setState(() {
                          buttonActive = false;
                        });
                        confirmPasswordFlag = true;
                      }
                    } else {
                      setState(() {
                        buttonActive = false;
                      });
                      confirmPasswordFlag = true;
                    }
                  } else {
                    if (con.pwc.text.isEmpty && con.pcc.text.isEmpty) {
                      setState(() {
                        buttonActive = true;
                      });
                    } else {
                      setState(() {
                        buttonActive = false;
                      });
                    }
                    confirmPasswordFlag = false;
                  }
                  confirmPasswordField();
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    suffixIcon: (con.pcc.text.isNotEmpty)
                        ? confirmPasswordFlag
                            ? const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                        : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Confirm Password')),
            // const SizedBox(height: 5,),
            // Visibility(child: Text(con.pcc.text != con.pwc.text ? '' : '', style: TextStyle(color: Colors.red),),visible: confirmPasswordFlag,)
          ],
        ));
  }
*/
  void passwordGeneration() {
    newPassword = hp.generatePassword(true, true, true, true, 10);
    passwordValidation(newPassword);
    newPassword2 = hp.generatePassword(true, true, true, true, 10);
    passwordValidation2(newPassword2);
    newPassword3 = hp.generatePassword(true, true, true, true, 10);
    passwordValidation3(newPassword3);
  }

  void passwordValidation(String password) {
    if (hp.passwordValidstructure(password) == null) {
      log('truth');
    } else {
      newPassword = hp.generatePassword(true, true, true, true, 10);
      passwordValidation(newPassword);
    }
  }

  void passwordValidation2(String password) {
    if (hp.passwordValidstructure(password) == null) {
      log('truth');
    } else {
      newPassword2 = hp.generatePassword(true, true, true, true, 10);
      passwordValidation2(newPassword2);
    }
  }

  void passwordValidation3(String password) {
    if (hp.passwordValidstructure(password) == null) {
      log('truth');
    } else {
      newPassword3 = hp.generatePassword(true, true, true, true, 10);
      passwordValidation3(newPassword3);
    }
  }

  Widget passwordField() {
    if (suggestChange == false) {
      passwordGeneration();
    }
    return Container(
        padding: const EdgeInsets.only(top: 5),
        height: passwordFlag
            ? 230
            : sugestPassword
                ? hp.dimensions.orientation == Orientation.landscape
                    ? 120
                    : 160
                : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                // mouseCursor: MouseCursor.,
                // textInputAction: TextInputAction.next,
                enableInteractiveSelection: passwordcopypasteFlag,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                onSubmitted: (text) {
                  // log(text);
                  sugestPassword = false;
                  setState(() {});
                },
                // onSaved: (text) {
                //   log(text);
                // },
                // onEditingComplete: () {
                //   log('text');
                // },
                onTap: () {
                  log('focused');
                  if (con.pwc.text.isEmpty) {
                    sugestPassword = true;
                  } else {
                    sugestPassword = false;
                  }
                  setState(() {});
                },
                // enableSuggestions: true,
                obscureText: !passwordVisible,
                controller: con.pwc,
                style: const TextStyle(
                  fontSize: 16,
                ),
                onChanged: (textLabel) {
                  suggestChange = false;
                  log(textLabel);
                  passwordcopypasteFlag = false;
                  log('afssdgdfsggdf');
                  if (con.pwc.text.isEmpty) {
                    sugestPassword = true;
                  } else {
                    sugestPassword = false;
                  }
                  if (con.pwc.text.isNotEmpty) {
                    if (hp.passwordValidstructure(textLabel) == null) {
                      passwordFlag = false;
                    } else {
                      passwordFlag = true;
                    }
                  } else {
                    passwordFlag = false;
                  }

                  if (con.pwc.text != con.pcc.text) {
                    confirmPasswordFlag = true;
                  } else {
                    confirmPasswordFlag = false;
                  }
                  setState(() {
                    buttonActive = false;
                  });
                  if (con.pwc.text.isNotEmpty) {
                    if (hp.passwordValidstructure(textLabel) == null) {
                      passwordFlag = false;
                    } else {
                      passwordFlag = true;
                    }
                  } else {
                    if (con.pwc.text.isEmpty && con.pcc.text.isEmpty) {
                      setState(() {
                        buttonActive = true;
                      });
                    } else {
                      setState(() {
                        buttonActive = false;
                      });
                    }
                    passwordFlag = false;
                  }

                  setState(() {
                    passwordField();
                  });
                  // passwordField();
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // added line
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        (con.pwc.text.isNotEmpty)
                            ? passwordFlag
                                ? const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                            : const Text(''),
                        IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              suggestChange = true;
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ],
                    ),
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Password')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
                visible: sugestPassword,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Suggested Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 10,
                      runSpacing: 10,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            passwordcopypasteFlag = true;
                            con.pcc.text = '';
                            con.pwc.text = newPassword;
                            con.pcc.text = newPassword;
                            buttonActive = true;

                            confirmPasswordFlag = false;
                            sugestPassword = false;
                            FocusScope.of(context).requestFocus(focus);
                            setState(() {});
                          },
                          child: Container(
                              height: 30,
                              width: 120,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: hp.theme.primaryColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Center(
                                  child: Text(
                                newPassword,
                                style: const TextStyle(color: Colors.white),
                              ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            passwordcopypasteFlag = true;
                            con.pcc.text = '';
                            con.pwc.text = newPassword2;
                            con.pcc.text = newPassword2;
                            buttonActive = true;
                            sugestPassword = false;
                            confirmPasswordFlag = false;
                            FocusScope.of(context).requestFocus(focus);
                            setState(() {});
                          },
                          child: Container(
                              height: 30,
                              width: 120,
                              // color: Colors.grey,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: hp.theme.primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                newPassword2,
                                style: const TextStyle(color: Colors.white),
                              ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            con.pcc.text = '';
                            passwordcopypasteFlag = true;
                            con.pwc.text = newPassword3;
                            con.pcc.text = newPassword3;
                            buttonActive = true;
                            sugestPassword = false;
                            confirmPasswordFlag = false;
                            FocusScope.of(context).requestFocus(focus);
                            setState(() {});
                          },
                          child: Container(
                              height: 30,
                              width: 120,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: hp.theme.primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                newPassword3,
                                style: const TextStyle(color: Colors.white),
                              ))),
                        ),
                      ],
                    )
                  ],
                )),
            Visibility(
                visible: passwordFlag,
                child:
                    hp.passwordValidstructure(con.pwc.text) ?? const Text(''))
          ],
        ));
  }

  Widget confirmPasswordField() {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        height: confirmPasswordFlag ? 60 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                enableInteractiveSelection: passwordcopypasteFlag,
                focusNode: focus,
                onTap: () {
                  log('sdfsgf');
                  sugestPassword = false;
                  setState(() {});
                },
                style: const TextStyle(
                  fontSize: 16,
                ),
                obscureText: true,
                controller: con.pcc,
                onChanged: (textLabel) {
                  log('sdfslasjfgklsdjfjkghedf');
                  if (con.pcc.text.isNotEmpty) {
                    if (con.pcc.text == con.pwc.text) {
                      //  setState(() { buttonActive = true; });
                      if (hp.passwordValidstructure(textLabel) == null) {
                        setState(() {
                          buttonActive = true;
                        });
                        confirmPasswordFlag = false;
                      } else {
                        setState(() {
                          buttonActive = false;
                        });
                        confirmPasswordFlag = true;
                      }
                    } else {
                      setState(() {
                        buttonActive = false;
                      });
                      confirmPasswordFlag = true;
                    }
                  } else {
                    if (con.pwc.text.isEmpty && con.pcc.text.isEmpty) {
                      setState(() {
                        buttonActive = true;
                      });
                    } else {
                      setState(() {
                        buttonActive = false;
                      });
                    }
                    confirmPasswordFlag = false;
                  }
                  setState(() {
                    confirmPasswordField();
                  });
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    suffixIcon: (con.pcc.text.isNotEmpty)
                        ? confirmPasswordFlag
                            ? const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                        : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Confirm Password')),
            // const SizedBox(height: 5,),
            // Visibility(child: Text(con.pcc.text != con.pwc.text ? '' : '', style: TextStyle(color: Colors.red),),visible: confirmPasswordFlag,)
          ],
        ));
  }

  void pincodeAPI(String val) async {
    try {
      log(val);
      if (val.isNotEmpty && val.trim().isNotEmpty) {
        final value = await api.getAddresses({'postcode': val});
        log(value);
        location.value = value;
        if (location.value.addresses.isNotEmpty) {
          con.flags = List<bool>.filled(location.value.addresses.length, false);
          // log(con.flags);
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
        final index = location.value.addresses
            .indexWhere((element) => element.contains(con.adc.text));
        if (index >= 0) {
          log('Using indexWhere: ${location.value.addresses[index]}');
          con.adc.text = location.value.addresses[index];
        }

        setState(() {
          loaderFlag = false;
          textFormField();
        });

        location.value.onChange();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void showDialog1() {
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
              /*height: 300.0,*/ // Change as per your requirement
              width: MediaQuery.of(context).size.width *
                  20, // Change as per your requirement
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                shrinkWrap: true,
                itemCount: location.value.addresses.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        log(index);
                        setState(() {
                          con.profileAddress = location.value.addresses[index];
                          log(con.profileAddress);
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
                                    child: con.profileAddress ==
                                            location.value.addresses[index]
                                        ? Text(location.value.addresses[index],
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            /*overflow:
                                                TextOverflow.ellipsis,*/
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                            ))
                                        : Text(
                                            location.value.addresses[index],
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
                                        child: con.profileAddress ==
                                                location.value.addresses[index]
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
                        con.profileAddress = p;
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
                con.adc.text = con.profileAddress;
                //      con.adc.selection = TextSelection.fromPosition(
                // TextPosition(offset: con.adc.text.length));

                textFormField();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }),
    );
  }

  Widget textFormField() {
    return loaderFlag
        ? CustomLoader(
            duration: const Duration(seconds: 10),
            color: hp.theme.primaryColor,
            loaderType: LoaderType.fadingCircle)
        : TextFormField(
            scrollPhysics: const NeverScrollableScrollPhysics(),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            controller: con.adc,
            // showCursor: false,
            enabled: true,
            readOnly: true,
            onTap: () {
              con.profileAddress = con.adc.text;
              showDialog1();
            },
            // onChanged: (text){
            //   con.adc.selection = TextSelection.fromPosition(
            //       TextPosition(offset: con.adc.text.length));

            // },
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                  vertical: hp.height / 100, horizontal: hp.width / 40),
              border: const OutlineInputBorder(),
              hintText: 'Select an Address',
              // label: Text(con.pt?.type ?? '', style: con.pt?.type.isEmpty ? const TextStyle(color: Colors.black) : TextStyle(color: Colors.grey[400]),),
              suffixIcon: const Icon(
                Icons.arrow_drop_down_outlined,
                color: Colors.black87,
              ),
            ),
          );
  }

  Widget firstnamefield() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: firstnameFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: con.fnc,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (textLabel) {
                  if (textLabel.length > 1) {
                    firstnameFlag = false;
                  } else {
                    firstnameFlag = true;
                  }
                  setState(() {});
                  firstnamefield();
                },
                style: const TextStyle(
                  fontSize: 16,
                ),
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    // suffixIcon: (con.pwc.text.isNotEmpty) ? passwordFlag ? const Icon(Icons.cancel,color: Colors.red,) : const Icon(Icons.check, color: Colors.green,) : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'First Name')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: firstnameFlag,
              child: Text(
                con.fnc.text.isEmpty
                    ? 'Please input your First name'
                    : con.fnc.text.length > 1
                        ? ''
                        : 'Minimum 2 characters',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget lastnamefield() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: lastnameflag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: con.lnc,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (textLabel) {
                  if (textLabel.length > 1) {
                    lastnameflag = false;
                  } else {
                    lastnameflag = true;
                  }
                  setState(() {});
                  lastnamefield();
                },
                style: const TextStyle(
                  fontSize: 16,
                ),
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    // suffixIcon: (con.pwc.text.isNotEmpty) ? passwordFlag ? const Icon(Icons.cancel,color: Colors.red,) : const Icon(Icons.check, color: Colors.green,) : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Last Name')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: lastnameflag,
              child: Text(
                con.lnc.text.isEmpty
                    ? 'Please input your Last name'
                    : con.lnc.text.length > 1
                        ? ''
                        : 'Minimum 2 characters',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }
}
