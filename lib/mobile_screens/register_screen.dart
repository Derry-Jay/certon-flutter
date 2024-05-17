import 'package:flutter/services.dart';

import '../backend/api.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../models/pin_code_result.dart';
import '../controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/my_labelled_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends StateMVC<SignUpScreen> {
  late UserController con;
  bool passwordFlag = false;
  bool confirmPasswordFlag = false;
  bool emailFlag = false;
  bool phoneFlag = false;
  bool firstnameFlag = false;
  bool postcodeFlag = false;
  bool lastnameflag = false;
  bool radiobutt = false;
  bool lookupFlag = false;
  String phoneAlertText = '';
  bool sugestPassword = false;
  bool passwordVisible = false;
  String newPassword = '';
  String newPassword2 = '';
  String newPassword3 = '';
  bool passwordcopypasteFlag = false;
  final focus = FocusNode();
  bool buttonActive = true;
  bool suggestChange = false;
  Helper get hp => Helper.of(context);
  SignUpScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  void fieldOnChange(String val) {
    setState(() {
      log(val);
    });
  }

  void setRadioValue(UserType? type) {
    setState(() {
      con.ut = type;
      if (con.ut == null) {
        radiobutt = true;
      } else {
        radiobutt = false;
      }
      if (firstnameFlag == false &&
          lastnameflag == false &&
          emailFlag == false &&
          postcodeFlag == false &&
          phoneFlag == false &&
          passwordFlag == false &&
          confirmPasswordFlag == false &&
          radiobutt == false &&
          lookupFlag == false) {
        if (con.fnc.text.isNotEmpty &&
            con.lnc.text.isNotEmpty &&
            con.pc.text.isNotEmpty &&
            con.emc.text.isNotEmpty &&
            con.phc.text.isNotEmpty &&
            con.pwc.text.isNotEmpty &&
            con.pcc.text.isNotEmpty) {
          buttonActive = true;
        } else {
          buttonActive = false;
        }
      } else {
        buttonActive = false;
      }
      finishButton();
    });
  }

  Widget listBuilder(
      BuildContext context, PinCodeResult result, Widget? child) {
    return Visibility(
        visible: result.addresses.isNotEmpty,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: hp.height / 80),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: getItemBuilder,
            itemCount: result.addresses.length));
  }

  // Widget getItemBuilder(BuildContext context, int index) {
  //   void onChanged(bool? val) {
  //     if (con.flags.isNotEmpty) {
  //       setState(() {
  //         if (con.flags.contains(true)) {
  //           con.flags[con.flags.indexOf(true)] = false;
  //           con.flags[index] = true;
  //         } else {
  //           con.flags[index] = val ?? false;
  //         }
  //       });
  //     }
  //   }

  //   return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
  //     Expanded(
  //         child: Text(location.value.addresses.isEmpty
  //             ? ''
  //             : location.value.addresses[index])),
  //     Expanded(
  //         child: Checkbox(
  //             value: con.flags.isNotEmpty ? con.flags[index] : false,
  //             onChanged: onChanged))
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          bottomNavigationBar: const BottomWidget(),
          body: Form(
              key: con.registerFormKey,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Register Your Account',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //     height: hp.height / 10.24,
                            //     padding: EdgeInsets.only(
                            //         top: hp.height / 50, bottom: hp.height / 100),
                            //     child: TextFormField(
                            //         textInputAction: TextInputAction.next,
                            //         controller: con.fnc,
                            //         validator: nameValidator,
                            //         decoration: InputDecoration(
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: hp.height / 100,
                            //                 horizontal: hp.width / 40),
                            //             border: const OutlineInputBorder(),
                            //             hintText: 'First Name'))),
                            // Container(
                            //     height: hp.height / 10.24,
                            //     padding: EdgeInsets.only(
                            //         top: hp.height / 100,
                            //         bottom: hp.height / 100),
                            //     child: TextFormField(
                            //         textInputAction: TextInputAction.next,
                            //         controller: con.lnc,
                            //         validator: nameValidator,
                            //         decoration: InputDecoration(
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: hp.height / 100,
                            //                 horizontal: hp.width / 40),
                            //             border: const OutlineInputBorder(),
                            //             hintText: 'Last Name'))),
                            firstnamefield(),
                            lastnamefield(),
                            emailField(),
                            phoneField(),
                            // Container(
                            //     height: hp.height / 10.24,
                            //     padding: EdgeInsets.only(
                            //         top: hp.height / 100,
                            //         bottom: hp.height / 100),
                            //     child: TextFormField(
                            //         textInputAction: TextInputAction.next,
                            //         controller: con.emc,
                            //         validator: hp.emailValidator,
                            //         decoration: InputDecoration(
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: hp.height / 100,
                            //                 horizontal: hp.width / 40),
                            //             border: const OutlineInputBorder(),
                            //             hintText: 'Email Address'))),
                            // Container(
                            //     height: hp.height / 10.24,
                            //     padding: EdgeInsets.only(
                            //         top: hp.height / 100,
                            //         bottom: hp.height / 100),
                            //     child: TextFormField(
                            //         textInputAction: TextInputAction.next,
                            //         keyboardType: TextInputType.phone,
                            //         controller: con.phc,
                            //         validator: phoneNumberValidator,
                            //         decoration: InputDecoration(
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: hp.height / 100,
                            //                 horizontal: hp.width / 40),
                            //             border: const OutlineInputBorder(),
                            //             hintText: 'Phone Number'))),
                            // SizedBox(
                            //     height: hp.height / 14,
                            //     child: TextFormField(
                            //         textInputAction: TextInputAction.next,
                            //         controller: con.pc,
                            //         // onChanged: ,
                            //         decoration: InputDecoration(
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: hp.height / 100,
                            //                 horizontal: hp.width / 40),
                            //             border: const OutlineInputBorder(),
                            //             hintText: 'Postcode'))),
                            postcodeProcess(),
                            // MyLabelledButton(
                            //     type: ButtonType.text,
                            //     label: 'Lookup',
                            //     onPressed: () {
                            //       con.waitUntilAddressObtained(
                            //           con.pc.text, context);
                            //     }),

                            // Expanded(
                            //     flex: 2,
                            //     child:
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ValueListenableBuilder<PinCodeResult>(
                                    valueListenable: location,
                                    builder: addressListBuilder)),
                            // ),
                            // ValueListenableBuilder<PinCodeResult>(
                            //     valueListenable: location, builder: listBuilder),
                            SizedBox(height: hp.height / 40),
                            passwordField(),
                            confirmPasswordField(),
                            // SizedBox(
                            //     height: hp.height / 10.24,
                            //     child: TextFormField(
                            //         textInputAction: TextInputAction.next,
                            //         // onChanged: fieldOnChange,
                            //         obscureText: true,
                            //         controller: con.pwc,
                            //         validator: hp.passwordValidator,
                            //         decoration: InputDecoration(
                            //             suffixIcon: Transform.rotate(
                            //                 angle: con.pwc.text.isNotEmpty &&
                            //                         con.pcc.text.isNotEmpty &&
                            //                         con.pwc.text == con.pcc.text
                            //                     ? 0
                            //                     : pi / 4,
                            //                 child: Icon(
                            //                     con.pwc.text.isNotEmpty && con.pcc.text.isNotEmpty && con.pwc.text == con.pcc.text
                            //                         ? Icons.done_sharp
                            //                         : Icons.add,
                            //                     color: con.pwc.text.isNotEmpty &&
                            //                             con.pcc.text.isNotEmpty &&
                            //                             con.pwc.text ==
                            //                                 con.pcc.text
                            //                         ? Colors.green
                            //                         : Colors.red)),
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: hp.height / 100,
                            //                 horizontal: hp.width / 40),
                            //             border: const OutlineInputBorder(),
                            //             hintText: 'Password'))),
                            // SizedBox(
                            //     height: hp.height / 10.24,
                            //     child: TextFormField(
                            //         textInputAction: TextInputAction.done,
                            //         // onEditingComplete: () {
                            //         //   setState(() {});
                            //         // },
                            //         // onChanged: fieldOnChange,
                            //         obscureText: true,
                            //         controller: con.pcc,
                            //         validator: hp.passwordValidator,
                            //         decoration: InputDecoration(
                            //             suffixIcon: Transform.rotate(
                            //                 angle: con.pwc.text.isNotEmpty &&
                            //                         con.pcc.text.isNotEmpty &&
                            //                         con.pwc.text == con.pcc.text
                            //                     ? 0
                            //                     : pi / 4,
                            //                 child: Icon(
                            //                     con.pwc.text.isNotEmpty && con.pcc.text.isNotEmpty && con.pwc.text == con.pcc.text
                            //                         ? Icons.done_sharp
                            //                         : Icons.add,
                            //                     color: con.pwc.text.isNotEmpty &&
                            //                             con.pcc.text.isNotEmpty &&
                            //                             con.pwc.text ==
                            //                                 con.pcc.text
                            //                         ? Colors.green
                            //                         : Colors.red)),
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: hp.height / 100,
                            //                 horizontal: hp.width / 40),
                            //             border: const OutlineInputBorder(),
                            //             hintText: 'Confirm Password'))),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                                child: Text(
                              'I am a',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                            )),

                            for (UserType i in UserType.values)
                              Center(
                                child: SizedBox(
                                  width: 350,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio<UserType>(
                                          activeColor: hp.theme.primaryColor,
                                          value: i,
                                          groupValue: con.ut,
                                          onChanged: setRadioValue),
                                      // ${EnumToString.convertToString(i,
                                      //     camelCase: true)}
                                      Flexible(
                                        child: Text(
                                            i.index == 0
                                                ? 'Home Owner/Landlord/Tenant/User'
                                                : 'Contractor/Installer',
                                            softWrap: true,
                                            style: const TextStyle(fontSize: 16)
                                            // style: TextStyle(
                                            //     color: Colors.black,
                                            //     fontSize: 14,
                                            //     fontWeight: FontWeight.w600),
                                            ),
                                      ),
                                      // Checkbox(
                                      // value:  i.index == ,
                                      // onChanged: setRadioValue)
                                    ],
                                  ),
                                ),
                              ),
                            finishButton()
                            // Container(
                            //   padding: EdgeInsets.zero,
                            //   // color: hp.theme.primaryColor,
                            //   width: MediaQuery.of(context).size.width,
                            //   child: ElevatedButton(
                            //       onPressed:
                            //           con.registerFormKey.currentState == null
                            //               ? null
                            //               : () {
                            //                   con.carryOn(context);
                            //                 },
                            //       style: ElevatedButton.styleFrom(
                            //         primary: hp.theme.primaryColor,
                            //       ),
                            //       child: Text(
                            //         con.ut == UserType.contractor
                            //             ? 'Proceed Further'
                            //             : 'REGISTER',
                            //         style: const TextStyle(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.normal,
                            //             color: Colors.white),
                            //       )),
                            // )
                            // MyLabelledButton(
                            //     type: ButtonType.text,
                            // label: con.ut == UserType.contractor
                            //     ? 'Proceed Further'
                            //     : 'Register',
                            //     onPressed:
                            // con.registerFormKey.currentState == null
                            //     ? null
                            //     : con.carryOn)
                          ])))),
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Register',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }

  // void waitUntilAddressObtained(String val) async {
  //   try {
  //     if (val.isNotEmpty && val.trim().isNotEmpty) {
  //       final value = await api.getAddresses({'postcode': val});
  //       location.value = value;
  //       if (location.value.addresses.isNotEmpty) {
  //         con.flags = List<bool>.filled(location.value.addresses.length, false);
  //       }
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Widget addressListBuilder(
      BuildContext context, PinCodeResult result, Widget? child) {
    final hpl = Helper.of(context);
    return result.addresses.isEmpty
        ? SizedBox(height: hpl.height / 16, width: hpl.width)
        : ListView.builder(
            shrinkWrap: true,
            // padding: EdgeInsets.symmetric(vertical: hp.height / 80),
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
          log(con.flags[index]);

          lookupFlag = false;
          if (firstnameFlag == false &&
              lastnameflag == false &&
              emailFlag == false &&
              postcodeFlag == false &&
              phoneFlag == false &&
              passwordFlag == false &&
              confirmPasswordFlag == false &&
              radiobutt == false &&
              lookupFlag == false) {
            if (con.fnc.text.isNotEmpty &&
                con.lnc.text.isNotEmpty &&
                con.pc.text.isNotEmpty &&
                con.emc.text.isNotEmpty &&
                con.phc.text.isNotEmpty &&
                con.pwc.text.isNotEmpty &&
                con.pcc.text.isNotEmpty) {
              buttonActive = true;
            } else {
              buttonActive = false;
            }
          } else {
            buttonActive = false;
          }
          finishButton();
        });
      }
    }

    return GestureDetector(
        child: Padding(
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
          log(index);
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

// Container(
//                             padding: EdgeInsets.zero,
//                             // color: hp.theme.primaryColor,
//                             width: MediaQuery.of(context).size.width,
//                             child: ElevatedButton(
//                                 onPressed:
  // con.registerFormKey.currentState == null
  //     ? null
  //     : () {
  //         con.carryOn(context);
  //       },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: hp.theme.primaryColor,
//                                 ),
//                                 child: Text(
//                                   con.ut == UserType.contractor
//                                       ? 'Proceed Further'
//                                       : 'REGISTER',
//                                   style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal,
//                                       color: Colors.white),
//                                 )),
  // )
  Widget finishButton() {
    return SizedBox(
      height: 50,
      width: hp.width,
      child: ElevatedButton(
        onPressed: buttonActive && con.pwc.text == con.pcc.text
            ? () async {
                con.flags.contains(true)
                    ? con.ut == null
                        ? null
                        : con.carryOn(context)
                    : null;
              }
            : null,

        style: ElevatedButton.styleFrom(
            primary: hp.theme.primaryColor,
            onSurface: hp.theme
                .primaryColor), //ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(hp.theme.primaryColor)),
        child: Text(
          con.ut == UserType.contractor ? 'Proceed Further' : 'REGISTER',
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      // padding: EdgeInsets.only(
      //     top: hp.height / 100, bottom: hp.height / 100)
    );
  }

  Widget postcodeProcess() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: postcodeFlag ? 160 : 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                textInputAction: TextInputAction.next,
                controller: con.pc,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                onTap: () {
                  sugestPassword = false;
                  setState(() {});
                },
                /*onChanged: (value){
                  con.pc.value = (TextEditingValue(
                      text: value.toUpperCase(),
                      selection: con.pc.selection
                  ));
                },*/
                onChanged: (textLabel) {
                  con.pc.value = (TextEditingValue(
                      text: textLabel.toUpperCase(),
                      selection: con.pc.selection));
                  setState(() {
                    postcodeProcess();
                    log(firstnameFlag);
                    log(lastnameflag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(postcodeFlag);
                    if (!(firstnameFlag ||
                        lastnameflag ||
                        postcodeFlag ||
                        emailFlag ||
                        phoneFlag ||
                        passwordFlag ||
                        confirmPasswordFlag ||
                        lookupFlag ||
                        radiobutt)) {
                      if (!(con.fnc.text.isEmpty ||
                          con.pc.text.isEmpty ||
                          con.lnc.text.isEmpty ||
                          con.emc.text.isEmpty ||
                          con.phc.text.isEmpty ||
                          con.pwc.text.isEmpty ||
                          con.pcc.text.isEmpty)) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
                  });
                  // firstnamefield();
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  // FilteringTextInputFormatter.deny(
                  //     RegExp(r'[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]')),
                ],
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    // suffixIcon: (con.pwc.text.isNotEmpty) ? passwordFlag ? const Icon(Icons.cancel,color: Colors.red,) : const Icon(Icons.check, color: Colors.green,) : null,
                    // suffixIconColor: Colors.red,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Postcode')),
            const SizedBox(
              height: 5,
            ),
            MyLabelledButton(
                type: ButtonType.text,
                label: 'Lookup',
                onPressed: () {
                  if (con.pc.text.isEmpty) {
                    postcodeFlag = true;
                  } else {
                    postcodeFlag = false;
                    con.waitUntilAddressObtained(con.pc.text, context);
                  }
                  setState(() {
                    lookupFlag = true;
                    if (firstnameFlag == false &&
                        lastnameflag == false &&
                        emailFlag == false &&
                        postcodeFlag == false &&
                        phoneFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false &&
                        radiobutt == false &&
                        lookupFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
                          con.pc.text.isNotEmpty &&
                          con.emc.text.isNotEmpty &&
                          con.phc.text.isNotEmpty &&
                          con.pwc.text.isNotEmpty &&
                          con.pcc.text.isNotEmpty) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
                  });
                }),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: postcodeFlag,
              child: Text(
                con.pc.text.isEmpty ? 'Post Code Field is Required' : '',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget firstnamefield() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: firstnameFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                textInputAction: TextInputAction.next,
                controller: con.fnc,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onTap: () {
                  sugestPassword = false;
                  setState(() {});
                },
                onChanged: (textLabel) {
                  final validCharacters = RegExp(r'^[a-zA-Z]+$');
                  log(validCharacters.hasMatch(textLabel));
                  log('validCharacters.hasMatch(textLabel)');

                  if (textLabel.length > 1) {
                    firstnameFlag = false;
                  } else {
                    firstnameFlag = true;
                  }
                  // final validCharacters = RegExp(r'^[a-zA-Z]+$');
                  if (validCharacters.hasMatch(textLabel)) {
                    log('adfjnsljnsljfng');
                    firstnameFlag = false;
                  } else {
                    log('akjdhfwholwnrn');
                    firstnameFlag = true;
                  }

                  setState(() {
                    firstnamefield();
                    log(firstnameFlag);
                    log(lastnameflag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (!(firstnameFlag ||
                        lastnameflag ||
                        postcodeFlag ||
                        emailFlag ||
                        phoneFlag ||
                        passwordFlag ||
                        confirmPasswordFlag ||
                        lookupFlag ||
                        radiobutt)) {
                      if (!(con.fnc.text.isEmpty ||
                          con.lnc.text.isEmpty ||
                          con.pc.text.isEmpty ||
                          con.emc.text.isEmpty ||
                          con.phc.text.isEmpty ||
                          con.pwc.text.isEmpty ||
                          con.pcc.text.isEmpty)) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
                  });
                  // firstnamefield();
                },
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
                        ? (RegExp(r'^[a-zA-Z]+$').hasMatch(con.fnc.text))
                            ? ''
                            : 'Please only use Letters'
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
                textInputAction: TextInputAction.next,
                onTap: () {
                  sugestPassword = false;
                  setState(() {});
                },
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
                  final validCharacters = RegExp(r'^[a-zA-Z]+$');
                  if (validCharacters.hasMatch(textLabel)) {
                    log('adfjnsljnsljfng');
                    lastnameflag = false;
                  } else {
                    log('akjdhfwholwnrn');
                    lastnameflag = true;
                  }
                  setState(() {
                    lastnamefield();
                    log(firstnameFlag);
                    log(lastnameflag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstnameFlag == false &&
                        lastnameflag == false &&
                        emailFlag == false &&
                        phoneFlag == false &&
                        postcodeFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false &&
                        radiobutt == false &&
                        lookupFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
                          con.pc.text.isNotEmpty &&
                          con.emc.text.isNotEmpty &&
                          con.phc.text.isNotEmpty &&
                          con.pwc.text.isNotEmpty &&
                          con.pcc.text.isNotEmpty) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
                  });
                },
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
                        ? (RegExp(r'^[a-zA-Z]+$').hasMatch(con.lnc.text))
                            ? ''
                            : 'Please only use Letters'
                        : 'Minimum 2 characters',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget emailField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: emailFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                textInputAction: TextInputAction.next,
                onTap: () {
                  sugestPassword = false;
                  setState(() {});
                },
                controller: con.emc,
                onChanged: (textLabel) {
                  if (hp.emailValidator(textLabel) == null) {
                    emailFlag = false;
                  } else {
                    emailFlag = true;
                  }
                  setState(() {
                    emailField();
                    log(firstnameFlag);
                    log(lastnameflag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstnameFlag == false &&
                        lastnameflag == false &&
                        emailFlag == false &&
                        postcodeFlag == false &&
                        phoneFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false &&
                        radiobutt == false &&
                        lookupFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
                          con.emc.text.isNotEmpty &&
                          con.phc.text.isNotEmpty &&
                          con.pc.text.isNotEmpty &&
                          con.pwc.text.isNotEmpty &&
                          con.pcc.text.isNotEmpty) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
                  });
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
                con.emc.text.isEmpty
                    ? 'Please input your email'
                    : hp.emailValidator(con.emc.text) ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget phoneField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: phoneFlag ? 96 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                textInputAction: TextInputAction.next,
                onTap: () {
                  sugestPassword = false;
                  setState(() {});
                },
                controller: con.phc,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15),
                  FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),
                ],
                onChanged: (textLabel) {
                  if (phoneNumberValidator(con.phc.text) != null) {
                    log(phoneNumberValidator(con.phc.text));

                    phoneAlertText = 'Invalid Format';
                    phoneFlag = true;
                  } else {
                    phoneFlag = false;
                  }
                  if (phoneNumberValidator(textLabel) == null) {
                    phoneFlag = false;
                  } else {
                    phoneFlag = true;
                  }
                  setState(() {
                    phoneField();
                    log(firstnameFlag);
                    log(lastnameflag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstnameFlag == false &&
                        lastnameflag == false &&
                        emailFlag == false &&
                        postcodeFlag == false &&
                        phoneFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false &&
                        radiobutt == false &&
                        lookupFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
                          con.pc.text.isNotEmpty &&
                          con.emc.text.isNotEmpty &&
                          con.phc.text.isNotEmpty &&
                          con.pwc.text.isNotEmpty &&
                          con.pcc.text.isNotEmpty &&
                          con.ut != null) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
                  });
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
                con.phc.text.isEmpty
                    ? 'Please provide a contact telephone number'
                    : phoneAlertText,
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

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
        /*height: passwordFlag
            ? 230
            : sugestPassword
                ? 160
                : 60,*/
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
                    passwordField();
                    log(firstnameFlag);
                    log(lastnameflag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstnameFlag == false &&
                        lastnameflag == false &&
                        emailFlag == false &&
                        phoneFlag == false &&
                        postcodeFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false &&
                        radiobutt == false &&
                        lookupFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
                          con.emc.text.isNotEmpty &&
                          con.pc.text.isNotEmpty &&
                          con.phc.text.isNotEmpty &&
                          con.pwc.text.isNotEmpty &&
                          con.pcc.text.isNotEmpty) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
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
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
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
                            confirmPasswordFlag = false;
                            sugestPassword = false;
                            FocusScope.of(context).requestFocus(focus);
                            setState(() {
                              confirmPasswordFlag = false;
                              sugestPassword = false;
                              if (firstnameFlag == false &&
                                  lastnameflag == false &&
                                  emailFlag == false &&
                                  phoneFlag == false &&
                                  postcodeFlag == false &&
                                  passwordFlag == false &&
                                  confirmPasswordFlag == false &&
                                  radiobutt == false &&
                                  lookupFlag == false) {
                                if (con.fnc.text.isNotEmpty &&
                                    con.lnc.text.isNotEmpty &&
                                    con.emc.text.isNotEmpty &&
                                    con.pc.text.isNotEmpty &&
                                    con.phc.text.isNotEmpty &&
                                    con.pwc.text.isNotEmpty &&
                                    con.pcc.text.isNotEmpty) {
                                  buttonActive = true;
                                } else {
                                  buttonActive = false;
                                }
                              } else {
                                buttonActive = false;
                              }
                              finishButton();
                            });
                          },
                          child: Container(
                              /*height: 30,*/
                              width: 130,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
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
                            sugestPassword = false;
                            confirmPasswordFlag = false;
                            FocusScope.of(context).requestFocus(focus);
                            setState(() {
                              confirmPasswordFlag = false;
                              sugestPassword = false;
                              if (firstnameFlag == false &&
                                  lastnameflag == false &&
                                  emailFlag == false &&
                                  phoneFlag == false &&
                                  postcodeFlag == false &&
                                  passwordFlag == false &&
                                  confirmPasswordFlag == false &&
                                  radiobutt == false &&
                                  lookupFlag == false) {
                                if (con.fnc.text.isNotEmpty &&
                                    con.lnc.text.isNotEmpty &&
                                    con.emc.text.isNotEmpty &&
                                    con.pc.text.isNotEmpty &&
                                    con.phc.text.isNotEmpty &&
                                    con.pwc.text.isNotEmpty &&
                                    con.pcc.text.isNotEmpty) {
                                  buttonActive = true;
                                } else {
                                  buttonActive = false;
                                }
                              } else {
                                buttonActive = false;
                              }
                              finishButton();
                            });
                          },
                          child: Container(
                              /*height: 30,*/
                              width: 130,
                              // color: Colors.grey,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
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
                            sugestPassword = false;
                            confirmPasswordFlag = false;
                            FocusScope.of(context).requestFocus(focus);
                            setState(() {
                              confirmPasswordFlag = false;
                              sugestPassword = false;
                              if (firstnameFlag == false &&
                                  lastnameflag == false &&
                                  emailFlag == false &&
                                  phoneFlag == false &&
                                  postcodeFlag == false &&
                                  passwordFlag == false &&
                                  confirmPasswordFlag == false &&
                                  radiobutt == false &&
                                  lookupFlag == false) {
                                if (con.fnc.text.isNotEmpty &&
                                    con.lnc.text.isNotEmpty &&
                                    con.emc.text.isNotEmpty &&
                                    con.pc.text.isNotEmpty &&
                                    con.phc.text.isNotEmpty &&
                                    con.pwc.text.isNotEmpty &&
                                    con.pcc.text.isNotEmpty) {
                                  buttonActive = true;
                                } else {
                                  buttonActive = false;
                                }
                              } else {
                                buttonActive = false;
                              }
                              finishButton();
                            });
                          },
                          child: Container(
                              /*height: 30,*/
                              width: 130,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
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
                obscureText: true,
                controller: con.pcc,
                onChanged: (textLabel) {
                  log('sdfslasjfgklsdjfjkghedf');
                  if (con.pcc.text.isNotEmpty) {
                    if (con.pcc.text == con.pwc.text) {
                      //  setState(() { buttonActive = true; });
                      if (hp.passwordValidstructure(textLabel) == null) {
                        confirmPasswordFlag = false;
                      } else {
                        confirmPasswordFlag = true;
                      }
                    } else {
                      confirmPasswordFlag = true;
                    }
                  } else {
                    confirmPasswordFlag = false;
                  }
                  setState(() {
                    confirmPasswordField();
                    log(firstnameFlag);
                    log(lastnameflag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (!(firstnameFlag ||
                        lastnameflag ||
                        emailFlag ||
                        phoneFlag ||
                        passwordFlag ||
                        postcodeFlag ||
                        confirmPasswordFlag ||
                        lookupFlag ||
                        radiobutt)) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
                          con.emc.text.isNotEmpty &&
                          con.pc.text.isNotEmpty &&
                          con.phc.text.isNotEmpty &&
                          con.pwc.text.isNotEmpty &&
                          con.pcc.text.isNotEmpty) {
                        buttonActive = true;
                      } else {
                        buttonActive = false;
                      }
                    } else {
                      buttonActive = false;
                    }
                    finishButton();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location.value = PinCodeResult.emptyResult;
    location.value.onChange();
    buttonActive = false;
  }
}
