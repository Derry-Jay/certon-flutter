import '../backend/api.dart';
import '../models/property_type.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../controllers/user_controller.dart';
import '../widgets/loader.dart';
import '../widgets/mobile/bottom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';

// /*
class AddLandlordUserScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddLandlordUserScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddLandlordUserScreenState createState() => AddLandlordUserScreenState();
}

class AddLandlordUserScreenState extends StateMVC<AddLandlordUserScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);

  bool firstNameFlag = false,
      lastNameFlag = false,
      emailFlag = false,
      phoneFlag = false,
      passwordFlag = false,
      confirmPasswordFlag = false,
      buttonActive = true,
      showpasswordField = true,
      showConfirmPasswordField = true,
      conditionalflag = true,
      tenantViewFlag = false;

  bool suggestChange = false;

  String firstNameAlertText = '',
      lastNameAlertText = '',
      emailAlertText = '',
      phoneAlertText = '';
  bool sugestPassword = false;
  bool passwordVisible = false;
  String newPassword = '';
  String newPassword2 = '';
  String newPassword3 = '';
  bool passwordcopypasteFlag = false;
  final focus = FocusNode();

  AddLandlordUserScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hp.getConnectStatus();
  }

  @override
  Widget build(BuildContext context) {
    final sf = Scaffold(
      drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
      bottomNavigationBar: const BottomWidget(),
      appBar: AppBar(
          leading: const LeadingWidget(visible: false),
          leadingWidth:
              hp.dimensions.orientation == Orientation.landscape ? 175 : 125,
          // bottom: PreferredSize(
          //     preferredSize: const Size(double.infinity, kToolbarHeight),
          //     child: Container(
          //       height: 60,
          //       decoration: BoxDecoration(
          //           borderRadius:
          //               const BorderRadius.all(Radius.circular(0.0)),
          //           boxShadow: <BoxShadow>[
          //             BoxShadow(
          //                 color: hp.theme.hintColor,
          //                 offset: const Offset(0.0, 0.0),
          //                 blurRadius: 0.0),
          //             BoxShadow(
          //                 color: hp.theme.hintColor,
          //                 offset: const Offset(0.0, 0.0),
          //                 blurRadius: 0.0),
          //           ],
          //           gradient: LinearGradient(
          //               colors: [hp.theme.hintColor, hp.theme.hintColor],
          //               begin: const FractionalOffset(0.2, 0.2),
          //               end: const FractionalOffset(1.0, 1.0),
          //               stops: const [0.0, 1.0],
          //               tileMode: TileMode.clamp)),
          //       child: Center(
          //           child: Row(
          //         children: [
          //           Icon(Icons.qr_code_scanner_outlined,
          //               color: hp.theme.scaffoldBackgroundColor,
          //               size: hp.radius / 20),
          //           const SizedBox(
          //             width: 15,
          //           ),
          //           Expanded(
          //               child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               const Text('CODE SCANNED',
          //                   style: TextStyle(color: Colors.lightGreenAccent)),
          //               const SizedBox(
          //                 height: 5,
          //               ),
          //               Flexible(
          //                   child: Text(
          //                       'Property ID: ${widget.rar.content ?? ''}',
          //                       // softWrap: false,
          //                       // overflow: TextOverflow.ellipsis,
          //                       style: const TextStyle(color: Colors.white)))
          //             ],
          //           ))
          //         ],
          //       )),
          //     )),
          elevation: 0,
          centerTitle: true,
          backgroundColor: hp.theme.primaryColor,
          foregroundColor: hp.theme.scaffoldBackgroundColor,
          title: const Text('Add For Another User',
              style: TextStyle(fontWeight: FontWeight.w600))),
      body: SingleChildScrollView(
        // physics: MediaQuery.of(context).size.height
        //     ? const AlwaysScrollableScrollPhysics()
        //     : const NeverScrollableScrollPhysics(),
        // padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
              height: hp.height /
                  (hp.pageOrientation == Orientation.landscape
                      ? 6.5536
                      : 13.1072),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: hp.theme.hintColor,
                  borderRadius: const BorderRadius.all(Radius.zero)),
              child: Row(
                children: [
                  // Flexible(
                  //     child: Icon(Icons.qr_code_scanner_outlined,
                  //         color: hp.theme.scaffoldBackgroundColor,
                  //         size: hp.radius / 20)),
                  // const SizedBox(
                  //   width: 15,
                  // ),
                  // Expanded(
                  //     flex: 3,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         const Text('CODE SCANNED',
                  //             style:
                  //                 TextStyle(color: Colors.lightGreenAccent)),
                  //         // const SizedBox(
                  //         //   height: 5,
                  //         // ),
                  //         Flexible(
                  //             child: Text(
                  //                 'Property ID: ${widget.rar.content}',
                  //                 // softWrap: false,
                  //                 // overflow: TextOverflow.ellipsis,
                  //                 style:
                  //                     const TextStyle(color: Colors.white)))
                  //       ],
                  //     ))
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
                            style: TextStyle(color: Colors.lightGreenAccent)),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Text('Property ID:  ${widget.rar.content}',
                            softWrap: false,
                            // maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
                child: Text('2/2 ADD FOR A CUSTOMER',
                    style: hp.textTheme.headline6)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: emailId()),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: firstName()),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: lastName()),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: mobileno()),
          const SizedBox(
            height: 5,
          ),
          Visibility(
              visible: con.user1 == null ? true : false,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: passwordField())),
          const SizedBox(
            height: 5,
          ),
          Visibility(
              visible: con.user1 == null ? true : false,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: confirmPasswordField())),
          const SizedBox(
            height: 20,
          ),
          tickBoxLandlord(),
          SizedBox(
            height: con.checkedLandlordFlag ? 10 : 0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 20),
            alignment: Alignment.topLeft,
            child: RichText(
                textAlign: TextAlign.start,
                text: const TextSpan(children: [
                  TextSpan(
                    text:
                        'Tick ‘Tenant View Access’ box if you would like to set-up a tenant account',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ])),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Checkbox(
                    value: con.tenantViewFlag,
                    onChanged: con.onTenantViewFlagChanged),
                Flexible(
                  child: SelectableText('Tenant View Access', onTap: () {
                    if (mounted) {
                      setState(() {
                        con.tenantViewFlag = !(con.tenantViewFlag ?? true);
                      });
                    }
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 20),
            alignment: Alignment.topLeft,
            child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(children: [
                  const TextSpan(
                    text:
                        'To see important information how a Tenant can view documents for this property click ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                      text: 'here',
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialo1();
                        }),
                ])),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: finishButton()),
          const SizedBox(height: 30),
        ]),
      ),
    );
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          top: isAndroid,
          bottom: isAndroid,
          child: isAndroid
              ? sf
              : MediaQuery(
                  data:
                      MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                          .copyWith(boldText: false, textScaleFactor: 1.0),
                  child: sf),
        ));
  }

  Widget tickBoxLandlord() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                  value: con.landlordViewFlag,
                  onChanged: con.onLandlordViewFlagChanged),
              Flexible(
                child: SelectableText(
                    'Tick this Box if this property is for a Landlord',
                    onTap: () {
                  log(mounted);
                  log('mounted');
                  if (mounted) {
                    con.landlordViewFlag = !(con.landlordViewFlag ?? true);
                    con.checkedLandlordFlag = !(con.landlordViewFlag ?? false);
                    log(con.landlordViewFlag);
                    log(con.checkedLandlordFlag);
                    log('con.landlordViewFlag');
                    log('con.checkedLandlordFlag');
                    setState(() {
                      tickBoxLandlord();
                    });
                  }
                }),
              ),
            ],
          ),
          Visibility(
            visible: con.checkedLandlordFlag,
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Please tick this box to proceed for tenant',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstName() {
    return Container(
        // height: firstNameFlag ? 100 : 71,
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text('First Name',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                textScaleFactor: 1.0),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                  onTap: () {
                    sugestPassword = false;
                    setState(() {});
                  },
                  controller: con.fnc,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                  ],
                  onChanged: (textLabel) {
                    if (textLabel.isEmpty) {
                      firstNameAlertText = 'Please enter a First Name';
                    } else {
                      if (textLabel.length > 1) {
                        firstNameFlag = false;
                      } else {
                        firstNameAlertText = 'Minimum 2 Characters';
                        firstNameFlag = true;
                      }
                    }

                    setState(() {
                      firstName();
                    });
                  },
                  // validator: firstNameValidator,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'First Name')),
            ),
            Visibility(
              visible: firstNameFlag,
              child: Text(
                con.fnc.text.isEmpty
                    ? 'Please enter a First Name'
                    : con.fnc.text.length > 2
                        ? ''
                        : 'Minimum 2 Characters',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget lastName() {
    return Container(
      // height: lastNameFlag ? 100 : 71,
      padding: const EdgeInsets.only(top: 10, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Text('Last Name',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
              textScaleFactor: 1.0),
          const SizedBox(height: 5),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: TextFormField(
                onTap: () {
                  sugestPassword = false;
                  setState(() {});
                },
                controller: con.lnc,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (textLabel) {
                  if (textLabel.isEmpty) {
                    lastNameAlertText = 'Please enter a Last Name';
                  } else {
                    if (textLabel.length > 1) {
                      lastNameFlag = false;
                    } else {
                      lastNameAlertText = 'Minimum 2 Characters';
                      lastNameFlag = true;
                    }
                  }

                  // setState(() { lastName(); });

                  setState(() {
                    lastName();
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Last Name')),
          ),
          Visibility(
            visible: lastNameFlag,
            child: Text(
              con.lnc.text.isEmpty
                  ? 'Please enter a Last Name'
                  : con.lnc.text.length > 2
                      ? ''
                      : 'Minimum 2 Characters',
              style: const TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  Widget emailId() {
    return Container(
        // height: emailFlag ? 100 : 71,
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text('Email Address',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                textScaleFactor: 1.0),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                  onTap: () {
                    sugestPassword = false;
                    if (con.emc.text.isEmpty) {
                      log('object');
                      emailFlag = true;
                      emailAlertText = 'Please enter a valid email.';
                    } else {
                      if (hp.emailValidator(con.emc.text) != null) {
                        emailAlertText = 'Please enter a valid email.';
                        emailFlag = true;
                      } else {
                        log(currentUser.value.userEmail);
                        if (con.emc.text == currentUser.value.userEmail) {
                          log('wrong');
                          emailFlag = true;
                          emailAlertText =
                              'You have entered your own email for customer email.';
                        } else {
                          // emailFlag = false;
                          // emailOnChange(con.emc.text);
                        }
                      }
                    }

                    if (con.user1 == null) {
                      con.fnc.text.isEmpty
                          ? firstNameFlag = true
                          : con.fnc.text.length > 2
                              ? firstNameFlag = false
                              : firstNameFlag = true;
                      con.lnc.text.isEmpty
                          ? lastNameFlag = true
                          : con.lnc.text.length > 2
                              ? lastNameFlag = false
                              : lastNameFlag = true;
                      // lastNameFlag = true;

                      con.phc.text.isEmpty
                          ? phoneFlag = true
                          : phoneNumberValidator(con.phc.text) != null
                              ? phoneFlag = true
                              : phoneFlag = false;

                      hp.passwordValidstructure(con.pwc.text) != null
                          ? passwordFlag = true
                          : passwordFlag = false;
                      hp.passwordValidstructure(con.pcc.text) != null
                          ? confirmPasswordFlag = true
                          : confirmPasswordFlag = false;
                    }
                    setState(() {});
                  },
                  controller: con.emc,
                  validator: hp.emailValidator,
                  onChanged: (textLabel) {
                    if (textLabel.isEmpty) {
                      emailFlag = true;
                      emailAlertText = 'Please enter a valid email.';
                    } else {
                      if (hp.emailValidator(textLabel) != null) {
                        emailAlertText = 'Please enter a valid email.';
                        emailFlag = true;
                      } else {
                        log(currentUser.value.userEmail);
                        if (textLabel == currentUser.value.userEmail) {
                          log('wrong');
                          emailFlag = true;
                          emailAlertText =
                              'You have entered your own email for customer email.';
                        } else {
                          emailFlag = false;
                          emailOnChange(textLabel);
                        }
                      }
                    }

                    if (con.user1 == null) {
                      con.fnc.text.isEmpty
                          ? firstNameFlag = true
                          : con.fnc.text.length > 2
                              ? firstNameFlag = false
                              : firstNameFlag = true;
                      con.lnc.text.isEmpty
                          ? lastNameFlag = true
                          : con.lnc.text.length > 2
                              ? lastNameFlag = false
                              : lastNameFlag = true;
                      // lastNameFlag = true;

                      con.phc.text.isEmpty
                          ? phoneFlag = true
                          : phoneNumberValidator(con.phc.text) != null
                              ? phoneFlag = true
                              : phoneFlag = false;

                      hp.passwordValidstructure(con.pwc.text) != null
                          ? passwordFlag = true
                          : passwordFlag = false;
                      hp.passwordValidstructure(con.pcc.text) != null
                          ? confirmPasswordFlag = true
                          : confirmPasswordFlag = false;
                    }

                    setState(() {});

                    // setState(() {
                    //   emailId();

                    //   if (firstNameFlag == false &&
                    //       lastNameFlag == false &&
                    //       emailFlag == false &&
                    //       phoneFlag == false &&
                    //       passwordFlag == false &&
                    //       confirmPasswordFlag == false) {
                    //     if (con.fnc.text.isNotEmpty &&
                    //         con.lnc.text.isNotEmpty &&
                    //         con.emc.text.isNotEmpty &&
                    //         con.phc.text.isNotEmpty &&
                    //         con.pwc.text.isNotEmpty &&
                    //         con.pcc.text.isNotEmpty) {
                    //       buttonActive = true;
                    //     } else {
                    //       buttonActive = false;
                    //     }
                    //   } else {
                    //     buttonActive = false;
                    //   }
                    //   finishButton();
                    // });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Email Address')),
            ),
            Visibility(
              visible: emailFlag,
              child: Text(
                con.user1 == null
                    ? currentUser.value.userEmail == con.emc.text
                        ? emailAlertText
                        : 'Please enter a valid email.'
                    : emailAlertText,
                style: TextStyle(
                    color: con.user1 == null ? Colors.red : Colors.green),
              ),
            )
          ],
        ));
  }

  Widget mobileno() {
    return Container(
        // height: phoneFlag ? 100 : 71,
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text('Contact Number',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                textScaleFactor: 1.0),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                  onTap: () {
                    sugestPassword = false;
                    setState(() {});
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  controller: con.phc,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                    FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),
                  ],
                  validator: phoneNumberValidator,
                  onChanged: (textLabel) {
                    log(textLabel);
                    if (textLabel.isEmpty) {
                      phoneAlertText = 'Please enter the phone number';
                    } else {
                      if (phoneNumberValidator(con.phc.text) != null) {
                        log(phoneNumberValidator(con.phc.text));

                        phoneAlertText = 'Invalid Format';
                        phoneFlag = true;
                      } else {
                        phoneFlag = false;
                      }
                    }

                    setState(() {
                      mobileno();
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Contact Number')),
            ),
            Visibility(
              visible: phoneFlag,
              child: Text(
                con.phc.text.isEmpty
                    ? 'Please enter a Valid Phone Number.'
                    : (phoneNumberValidator(con.phc.text) != null)
                        ? 'Invalid Format'
                        : '',
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
        // height: passwordFlag
        //     ? sugestPassword
        //         ? 320
        //         : 230
        //     : sugestPassword
        //         ? 160
        //         : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text('Password',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                textScaleFactor: 1.0),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                  enableInteractiveSelection: passwordcopypasteFlag,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  onSubmitted: (text) {
                    log('anfdkjsnfsndf');
                    sugestPassword = false;
                    setState(() {});
                  },
                  onEditingComplete: () {
                    log('editingcomplete');
                  },
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
                    log('anfdkjsnfsndf');
                    passwordcopypasteFlag = false;
                    suggestChange = false;
                    if (con.pwc.text.isEmpty) {
                      sugestPassword = true;
                    } else {
                      sugestPassword = false;
                    }

                    if (con.pwc.text.isNotEmpty) {
                      if (hp.passwordValidstructure(textLabel) == null) {
                        passwordFlag = false;
                        setState(() {
                          buttonActive = con.pwc.text == con.pcc.text;
                          confirmPasswordFlag = con.pwc.text != con.pcc.text;
                        });
                      } else {
                        log('adfssdfdgfhdghj');
                        passwordFlag = true;
                      }
                    } else {
                      log('adfsdgsdfgdfg');
                      if (sugestPassword == true) {
                        passwordFlag = true;
                      } else {
                        passwordFlag = false;
                      }
                    }

                    // if (con.pwc.text != con.pcc.text) {
                    //   confirmPasswordFlag = true;
                    // } else {
                    //   confirmPasswordFlag = false;
                    // }

                    setState(() {
                      passwordField();

                      // if (firstNameFlag == false &&
                      //     lastNameFlag == false &&
                      //     emailFlag == false &&
                      //     phoneFlag == false &&
                      //     passwordFlag == false &&
                      //     confirmPasswordFlag == false) {
                      //   if (con.fnc.text.isNotEmpty &&
                      //       con.lnc.text.isNotEmpty &&
                      //       con.emc.text.isNotEmpty &&
                      //       con.phc.text.isNotEmpty &&
                      //       con.pwc.text.isNotEmpty &&
                      //       con.pcc.text.isNotEmpty) {
                      //     buttonActive = true;
                      //   } else {
                      //     buttonActive = false;
                      //   }
                      // } else {
                      //   buttonActive = false;
                      // }
                      // finishButton();
                    });
                  },
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
            ),
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
                            con.pwc.text = newPassword;
                            con.pcc.text = newPassword;
                            confirmPasswordFlag = false;
                            sugestPassword = false;
                            passwordFlag = false;
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
                                newPassword,
                                style: const TextStyle(color: Colors.white),
                              ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            passwordcopypasteFlag = true;
                            con.pwc.text = newPassword2;
                            sugestPassword = false;
                            con.pcc.text = newPassword2;
                            confirmPasswordFlag = false;
                            passwordFlag = false;
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
                            passwordcopypasteFlag = true;
                            con.pwc.text = newPassword3;
                            con.pcc.text = newPassword3;
                            confirmPasswordFlag = false;
                            sugestPassword = false;
                            passwordFlag = false;
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
              child: hp.passwordValidstructure(con.pwc.text) ?? const Text(''),
            )
          ],
        ));
  }

  void showDialo1() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text(
            'Tenant View Access',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffe09c58), fontWeight: FontWeight.w500),
          ),
          content: SizedBox(
            /*height: 300.0,*/ // Change as per your requirement
            width: MediaQuery.of(context).size.width *
                20, // Change as per your requirement
            child: const Text(
              'An email to the Tenant at this address will be sent to confirm CertOn HUB is installed in this property. Tenants will not be able to view the documents uploaded by an Installer until the Landlord ‘Grants Access’ to view the property documents. The Tenant will need to scan the QR code in the property and send an ‘Access Request’ to the Landlord. Landlords can give 1 day, 1 week, 1 month, Forever Access to view property documents, or decline the request.',
              textAlign: TextAlign.justify,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text(
                  'More information',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  // if (await launchUrl(
                  //   Uri.tryParse('https://www.certon.co.uk/hub-faq/') ?? Uri())) {
                  //   log('Hi');
                  // }
                  Navigator.of(context).pop();
                }),
          ],
        );
      }),
    );
  }

  void launchURL() async {
    const uri = 'https://www.certon.co.uk/hub-faq/';
    if (await canLaunchUrl(Uri.tryParse(uri) ?? Uri()) &&
        await launchUrl(Uri.tryParse(uri) ?? Uri())) {
      log(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  Widget confirmPasswordField() {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        // passwordFlag
        //     ? sugestPassword ? 300 : 230
        //     : sugestPassword
        //         ? 160
        //         : 60
        // height: confirmPasswordFlag ? 230 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text('Confirm Password',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                textScaleFactor: 1.0),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                  enableInteractiveSelection: passwordcopypasteFlag,
                  focusNode: focus,
                  onTap: () {
                    sugestPassword = false;
                    setState(() {});
                  },
                  obscureText: true,
                  controller: con.pcc,
                  onChanged: (textLabel) {
                    if (con.pcc.text.isNotEmpty) {
                      if (con.pcc.text == con.pwc.text) {
                        if (hp.passwordValidstructure(textLabel) == null) {
                          confirmPasswordFlag = false;
                        } else {
                          confirmPasswordFlag = true;
                        }
                      } else {
                        confirmPasswordFlag = true;
                      }
                    } else {
                      confirmPasswordFlag = true;
                    }
                    setState(() {
                      confirmPasswordField();
                    });
                  },
                  // validator: hp.passwordValidator,
                  decoration: InputDecoration(
                      suffixIcon: con.pwc.text.isNotEmpty &&
                              con.pcc.text.isNotEmpty
                          ? (confirmPasswordFlag || con.pwc.text != con.pcc.text
                              ? const Icon(Icons.cancel, color: Colors.red)
                              : const Icon(Icons.check, color: Colors.green))
                          : null,
                      // suffixIconColor: Colors.red,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: hp.height / 100, horizontal: hp.width / 40),
                      border: const OutlineInputBorder(),
                      hintText: 'Confirm Password')),
            ),
            Visibility(
              visible: confirmPasswordFlag,
              child: con.pcc.text.isEmpty
                  ? const Text(
                      'Please enter the confirm password.',
                      style: TextStyle(color: Colors.red),
                    )
                  : hp.passwordValidstructure(con.pcc.text) == null
                      ? (con.pcc.text == con.pwc.text
                          ? const Text('')
                          : const Text(
                              'Password and Confirm Password are not same',
                              style: TextStyle(color: Colors.red),
                            ))
                      : const Text(
                          'Please enter the confirm password.',
                          style: TextStyle(color: Colors.red),
                        ),
            )
          ],
        ));
  }

  Widget finishButton() {
    return SizedBox(
      height: 50,
      width: hp.width,
      child: ElevatedButton(
        onPressed: () async {
          if (con.user1 != null) {
            log('kjkjhhhjkj');
            if ((con.tenantViewFlag == false &&
                    con.landlordViewFlag == false) ||
                (con.tenantViewFlag == true && con.landlordViewFlag == true) ||
                (con.landlordViewFlag == true && con.tenantViewFlag == false)) {
              waitUntillAddLandLord(widget.rar.params as Map<String, dynamic>);
            } else {
              log('sagknsjgbksan');
            }
          } else {
            // if (con.emc.text.isEmpty) {
            //    = true;
            // } else {
            //   emailFlag = false;
            // }
            // if (con.fnc.text.isEmpty) {
            //    = true;
            // } else {
            //   firstNameFlag = false;
            // }
            // if (con.lnc.text.isEmpty) {
            //    = true;
            // } else {
            //   lastNameFlag = false;
            // }
            // if (con.phc.text.isEmpty) {
            //    = true;
            // } else {
            //   phoneFlag = false;
            // }
            // if (con.pwc.text.isEmpty) {
            //    = true;
            // } else {
            //   passwordFlag = false;
            // }
            // if (con.pcc.text.isEmpty) {
            //    = true;
            // } else {
            //   confirmPasswordFlag = false;
            // }
            // emailFlag == false &&
            //       firstNameFlag == false &&
            //       lastNameFlag == false &&
            //       phoneFlag == false
            //   &&
            //   passwordFlag == false &&
            //   confirmPasswordFlag == false
            setState(() {
              emailFlag = con.emc.text.isEmpty;
              firstNameFlag = con.fnc.text.isEmpty;
              lastNameFlag = con.lnc.text.isEmpty;
              phoneFlag = con.phc.text.isEmpty;
              passwordFlag = con.pwc.text.isEmpty ||
                  hp.passwordValidator(con.pwc.text) != null;
              confirmPasswordFlag =
                  con.pcc.text.isEmpty || con.pcc.text != con.pwc.text;
            });
          }
          if (!(emailFlag ||
                  firstNameFlag ||
                  lastNameFlag ||
                  phoneFlag ||
                  passwordFlag ||
                  confirmPasswordFlag) &&
              (!(con.tenantViewFlag ?? true) ||
                  (con.landlordViewFlag ?? false))) {
            waitUntillAddLandLord(widget.rar.params as Map<String, dynamic>);
            // if ((con.tenantViewFlag == false &&
            //         con.landlordViewFlag == false) ||
            //     (con.tenantViewFlag == true && con.landlordViewFlag == true) ||
            //     (con.landlordViewFlag == true && con.tenantViewFlag == false)) {
            //   waitUntillAddLandLord(widget.rar.params as Map<String, dynamic>);
            // }
          } else {
            log('sagknsjgbksan');
          }
        },
        style: ElevatedButton.styleFrom(
          primary: hp.theme.primaryColor,
        ),
        child: Text(
            (con.tenantViewFlag ?? false) ? 'Proceed to Add Tenant' : 'Finish',
            style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  void emailOnChange(String? email) async {
    try {
      RegExp mailExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if (email != null && email.isNotEmpty && hp.mounted) {
        if (mailExp.hasMatch(email) && mailExp.allMatches(email).length == 1) {
          Loader.show(context);
          final val = await api.checkValidMail(email,
              email == con.emc.text ? 4 : (email == con.tem.text ? 3 : 0));
          Loader.hide();
          final rp = val.base;
          if (rp.success && val.user.isNotEmpty) {
            hp.currentScope.unfocus();
            setState(() {
              con.fnc.text = val.user.firstName;
              con.lnc.text = val.user.lastName;
              con.phc.text = val.user.phoneNo;
              conditionalflag = false;
              showpasswordField = false;
              showConfirmPasswordField = false;
              firstNameFlag = false;
              lastNameFlag = false;
              phoneFlag = false;
              emailFlag = false;
              passwordFlag = false;
              confirmPasswordFlag = false;
            });
          } else {}
          setState(() {
            if (val.user.isNotEmpty) {
              con.user1 = val.user;
              emailAlertText = rp.message;
              emailFlag = rp.success;
            } else if (con.user1 != null) {
              con.user1 = null;
              con.fnc.text = '';
              con.lnc.text = '';
              con.phc.text = '';
              con.pwc.text = '';
              con.pcc.text = '';
              emailAlertText = rp.message;
            }
            if (val.user.isEmpty) {
              conditionalflag = true;
              con.fnc.text.isEmpty
                  ? firstNameFlag = true
                  : con.fnc.text.length > 2
                      ? firstNameFlag = false
                      : firstNameFlag = true;
              con.lnc.text.isEmpty
                  ? lastNameFlag = true
                  : con.lnc.text.length > 2
                      ? lastNameFlag = false
                      : lastNameFlag = true;
              // lastNameFlag = true;

              con.phc.text.isEmpty
                  ? phoneFlag = true
                  : phoneNumberValidator(con.phc.text) != null
                      ? phoneFlag = true
                      : phoneFlag = false;

              hp.passwordValidstructure(con.pwc.text) != null
                  ? passwordFlag = true
                  : passwordFlag = false;
              hp.passwordValidstructure(con.pcc.text) != null
                  ? confirmPasswordFlag = true
                  : confirmPasswordFlag = false;
              emailFlag = true;
              emailAlertText = 'Please Enter a Valid Email';
              if (rp.message == 'The given email is available for use') {
                emailFlag = false;
                emailAlertText = '';
              }
              // emailAlertText = 'Please Enter a Valid Email';
            }
            // emailFlag = rp.success;
          });
        } else {
          con.fnc.text = '';
          con.lnc.text = '';
          con.phc.text = '';
          con.pwc.text = '';
          con.pcc.text = '';
          conditionalflag = true;
          showpasswordField = true;
          showConfirmPasswordField = true;
          setState(() {
            emailFlag = false;
            if (con.user1 != null) {
              con.user1 = null;
            }
            emailAlertText = 'Please Enter a Valid Email!!!';
          });
        }
      }
    } catch (e) {
      sendAppLog(e);
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

  void waitUntillAddLandLord(Map<String, dynamic> map) async {
    bool typeCriteria(PropertyType element) {
      return element.typeID == int.tryParse(map['property_type'].toString());
    }

    try {
      final body = Map<String, dynamic>.from(map);
      body['tenant_view_access'] = con.tenantViewFlag;
      body['landlord_favorite'] = con.addToLikedFlag ?? false;
      body['landlord_favorite_view'] = con.favouriteLandLordFlag;
      body['save_as_landlord'] = con.landlordViewFlag;
      if (con.fnc.text.isNotEmpty) {
        body['landlord_first_name'] = con.fnc.text;
      }
      log(body);
      if (con.lnc.text.isNotEmpty) {
        body['landlord_last_name'] = con.lnc.text;
      }
      log(body);
      if (con.emc.text.isNotEmpty) {
        body['landlord_email'] = con.emc.text;
      }
      log(body);
      if (con.phc.text.isNotEmpty) {
        body['landlord_phone'] = con.phc.text;
      }
      log(body);
      body['landlord_password'] = con.pwc.text;
      log(body);

      body['tenant_first_name'] = '';
      body['tenant_last_name'] = '';
      body['tenant_email'] = '';
      body['tenant_phone'] = '';
      body['tenant_password'] = '';

      if ((con.tenantViewFlag ?? false) && con.landlordViewFlag == true) {
        hp.goTo('/add_tenant', args: RouteArgument(params: body));
      } else {
        Loader.show(context);
        final rp = await api.addLandLord(body);
        Loader.hide();
        final p = await hp.showSimplePopup('OK', () {
          hp.goBack(result: true);
        }, action: rp.message, title: title, type: AlertType.cupertino);
        if (rp.success && p) {
          final val = (await api.getPropertyTypes()).firstWhere(typeCriteria);
          log(val);
          hp.goTo('/add_landlord_success',
              args: RouteArgument(params: {
                'first_name': body['landlord_first_name'],
                'last_name': body['landlord_last_name'],
                'email': body['landlord_email'],
                'address': body['address'],
                'type': val.type,
                'correctDate': body['purchased_date']
                // .toString()
                // .split('-')
                // .reversed
                // .join('/')
              }));
        }
      }
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
      final error = e.toString();
      final f2 = await hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      },
          action: error.contains('RangeError')
              ? 'Please Select Any'
              : (error.contains('Connection') ||
                      error.contains('FormatException')
                  ? 'Server Error!!!!'
                  : error),
          type: AlertType.cupertino,
          title: 'Error');
      if (f2) {
        log(e);
      }
    }
  }
}

// */

/*
class AddLandlordUserScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddLandlordUserScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddLandlordUserScreenState createState() => AddLandlordUserScreenState();
}

class AddLandlordUserScreenState extends StateMVC<AddLandlordUserScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);

  AddLandlordUserScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hp.getConnectStatus();
  }

  @override
  Widget build(BuildContext context) {
    final st = con.otherFormKey.currentState;
    return Scaffold(
        drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
        bottomNavigationBar: const BottomWidget(),
        body: SingleChildScrollView(
            physics: hp.size.shortestSide < 449 || hp.screenInsets.bottom > 0.0
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: hp.width / 32),
            child: Form(
                // onChanged: () {
                //   log(con.emailFlag);
                //   log('-----------------');
                //   log(st!.validate());
                //   log('_________________');
                //   st.setState(() {});
                // },
                autovalidateMode: AutovalidateMode.always,
                key: con.otherFormKey,
                child: SizedBox(
                    width: hp.width,
                    height: hp.height *
                        ((hp.size.shortestSide < 400)
                            ? (hp.isTablet
                                ? 1.31072
                                : (hp.isMobile
                                    ? (con.user1 == null || con.user1!.isEmpty
                                        ? (hp.size.longestSide < 599 ? 2 : 0.8)
                                        : (hp.size.longestSide < 599
                                            ? 1.6
                                            : 1.25))
                                    : 1.28))
                            : (con.user1 == null || con.user1!.isEmpty
                                ? (hp.isTablet
                                    ? (st == null
                                        ? 0.64
                                        : 0.79228162514264337593543950336)
                                    : 0.9903520314283042199192993792)
                                : (hp.isTablet ? 0.64 : 0.65536))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                              child: Center(
                                  child: Text('2/2 ADD FOR A CUSTOMER',
                                      style: hp.textTheme.headline6))),
                          // Flexible(
                          //     flex: hp.isMobile ? 2 : 1,
                          //     child: Row(children: [
                          //   Flexible(
                          //       child: Checkbox(
                          //           value: con.favouriteLandLordFlag,
                          //           onChanged:
                          //               con.onFavouriteLandLordFlagChanged)),
                          //   Flexible(
                          //       child: SelectableText('Get Favourite Landlord',
                          //           onTap: con.favouriteLandLordOnTap))
                          // ])),
                          Expanded(
                              flex: 2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 7,
                                        child: TextFormField(
                                            controller: con.emc,
                                            onTap: con.disableSuggestPassword,
                                            onChanged: con.emailOnChange,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Email'))),
                                    Visibility(
                                        visible: con.emc.text.isNotEmpty,
                                        child: Expanded(
                                            flex: 3,
                                            child: Text(con.mailDesc,
                                                style: TextStyle(
                                                    color: con.emailFlag
                                                        ? Colors.green
                                                        : hp.theme
                                                            .errorColor))))
                                  ])),
                          // Flexible(
                          //     flex: 2,
                          //     child: TextFormField(
                          //         controller: con.emc,
                          //         // validator: con.fieldOnChange,
                          //         onChanged: con.emailOnChange,
                          //         decoration: const InputDecoration(
                          //             border: OutlineInputBorder(),
                          //             hintText: 'Email'))),
                          // Visibility(
                          //     visible: con.emc.text.isNotEmpty,
                          //     child: Flexible(
                          //         child: Text(con.mailDesc,
                          //             style: TextStyle(
                          //                 color: con.emailFlag
                          //                     ? Colors.green
                          //                     : hp.theme.errorColor)))),
                          Flexible(
                              flex: 3,
                              child: TextFormField(
                                  controller: con.fnc,
                                  onTap: con.disableSuggestPassword,
                                  validator: nameValidator,
                                  readOnly: con.user1 != null &&
                                      con.user1!.isNotEmpty,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'First Name'))),
                          Flexible(
                              flex: 3,
                              child: TextFormField(
                                  controller: con.lnc,
                                  onTap: con.disableSuggestPassword,
                                  validator: nameValidator,
                                  readOnly: con.user1 != null &&
                                      con.user1!.isNotEmpty,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Last Name'))),
                          // Visibility(
                          //     visible:
                          //         !(con.user1 == null || con.user1!.isEmpty),
                          //     child: Flexible(
                          //         flex: hp.isMobile ? 2 : 1,
                          //         child: Row(
                          //           children: [
                          //             Flexible(
                          //                 child: Checkbox(
                          //                     value: con.addToLikedFlag,
                          //                     onChanged:
                          //                         con.onAddToLikedFlagChanged)),
                          //             Flexible(
                          //                 child: SelectableText(
                          //                     'Add to Favourites?', onTap: () {
                          //               if (mounted) {
                          //                 setState(() {
                          //                   con.addToLikedFlag =
                          //                       !(con.addToLikedFlag ?? true);
                          //                 });
                          //               }
                          //             }))
                          //           ],
                          //         ))),
                          Flexible(
                              flex: 3,
                              child: TextFormField(
                                  controller: con.phc,
                                  onTap: con.disableSuggestPassword,
                                  validator: phoneNumberValidator,
                                  readOnly: con.user1 != null &&
                                      con.user1!.isNotEmpty,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Contact Number'))),
                          Visibility(
                              visible: con.user1 == null || con.user1!.isEmpty,
                              child: Flexible(
                                  flex: hp.isTablet ? 4 : 5,
                                  child: TextFormField(
                                      controller: con.pwc,
                                      obscureText: con.olp,
                                      enableInteractiveSelection:
                                          con.passwordcopypasteFlag,
                                      onChanged: (String val) {
                                        // setState(() {
                                        //   con.passwordcopypasteFlag = false;
                                        // });
                                      },
                                      onTap: con.passwordFieldOnTap,
                                      validator: hp.passwordValidator,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  con.olp = !con.olp;
                                                });
                                              },
                                              icon: Icon(!con.olp
                                                  ? Icons.visibility
                                                  : Icons
                                                      .visibility_off_outlined)),
                                          border: const OutlineInputBorder(),
                                          hintText: 'Password')))),
                          Visibility(
                              visible: con.suggestPassword,
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
                                          con.passwordcopypasteFlag = true;
                                          con.pwc.text = con.newPassword;
                                          con.suggestPassword = false;
                                          hp.currentScope
                                              .requestFocus(con.focus);
                                          setState(() {});
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: hp.theme.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              con.newPassword,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          con.passwordcopypasteFlag = true;
                                          con.pwc.text = con.newPassword2;
                                          con.suggestPassword = false;
                                          hp.currentScope
                                              .requestFocus(con.focus);
                                          setState(() {});
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            // color: Colors.grey,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: hp.theme.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              con.newPassword2,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          con.passwordcopypasteFlag = true;
                                          con.pwc.text = con.newPassword3;
                                          con.suggestPassword = false;
                                          hp.currentScope
                                              .requestFocus(con.focus);
                                          setState(() {});
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: hp.theme.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              con.newPassword3,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ))),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Visibility(
                              visible: con.user1 == null || con.user1!.isEmpty,
                              child: Flexible(
                                  flex: hp.isTablet ? 4 : 5,
                                  child: TextFormField(
                                      focusNode: con.focus,
                                      controller: con.pcc,
                                      obscureText: con.olcp,
                                      onTap: con.disableSuggestPassword,
                                      validator: con.landLordPasswordValidator,
                                      onChanged: con.onConfirmPasswordChanged,
                                      onEditingComplete: con.onConfirmPassword,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Confirm Password')))),
                          Flexible(
                              child: Row(
                            children: [
                              Flexible(
                                  child: Checkbox(
                                      value: con.tenantViewFlag,
                                      onChanged: con.onTenantViewFlagChanged)),
                              Flexible(
                                  child: SelectableText('Tenant View Access',
                                      onTap: () {
                                if (mounted) {
                                  setState(() {
                                    con.tenantViewFlag =
                                        !(con.tenantViewFlag ?? true);
                                  });
                                }
                              }))
                            ],
                          )),
                          Flexible(
                              flex: (con.tenantViewFlag ?? false) ? 3 : 2,
                              child: MyLabelledButton(
                                  label: (con.tenantViewFlag ?? false)
                                      ? 'Proceed to Add Tenant'
                                      : 'Finish',
                                  onPressed: st == null
                                      ? null
                                      : (st.validate() && con.emailFlag
                                          ? () {
                                              con.waitUntillAddLandLord(
                                                  widget.rar.params
                                                      as Map<String, dynamic>);
                                            }
                                          : null),
                                  type: ButtonType.text,
                                  flag: st == null
                                      ? !con.emailFlag
                                      : !(st.validate() && con.emailFlag),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: hp.width /
                                          (hp.isMobile
                                              ? (hp.size.shortestSide < 400
                                                  ? 2.5
                                                  : ((con.tenantViewFlag ??
                                                          false)
                                                      ? 4
                                                      : 2.417851639229258349412352))
                                              : ((con.tenantViewFlag ?? false)
                                                  ? 2.7
                                                  : 2.305843009213693952)),
                                      vertical: hp.height /
                                          ((con.tenantViewFlag ?? false)
                                              ? 64
                                              : ((con.favouriteLandLordFlag ??
                                                      false)
                                                  ? 80
                                                  : 64)))))
                        ])))),
        appBar: AppBar(
            leading: const LeadingWidget(visible: false),
            leadingWidth: hp.leadingWidth,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                    height: hp.height /
                        (hp.isTablet
                            ? 16.384
                            : (hp.size.shortestSide < 400 ? 10 : 16)),
                    width: hp.width,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: hp.theme.hintColor,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0),
                          BoxShadow(
                              color: hp.theme.hintColor,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0)
                        ],
                        gradient: LinearGradient(
                            colors: [hp.theme.hintColor, hp.theme.hintColor],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Icon(Icons.qr_code_scanner_outlined,
                                  color: hp.theme.scaffoldBackgroundColor,
                                  size: hp.radius / 20)),
                          Expanded(
                              flex: hp.isMobile ? 6 : 9,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Flexible(
                                        child: Text('CODE SCANNED',
                                            style: TextStyle(
                                                color:
                                                    Colors.lightGreenAccent))),
                                    Flexible(
                                        child: Text(
                                            'Property ID: ${widget.rar.content!}',
                                            style: const TextStyle(
                                                color: Colors.white)))
                                  ]))
                        ]))),
            elevation: 0,
            centerTitle: true,
            backgroundColor: hp.theme.primaryColor,
            foregroundColor: hp.theme.scaffoldBackgroundColor,
            title: const Text('Scan Code',
                style: TextStyle(fontWeight: FontWeight.w600))));
  }
}




*/

/*import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';
import '../controllers/user_controller.dart';
import '../widgets/mobile/bottom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/mobile/my_labelled_button.dart';

class AddLandlordUserScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddLandlordUserScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddLandlordUserScreenState createState() => AddLandlordUserScreenState();
}

class AddLandlordUserScreenState extends StateMVC<AddLandlordUserScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);

  bool suggestPassword = false;
  bool passwordVisible = false;
  String newPassword = '';
  String newPassword2 = '';
  String newPassword3 = '';
  bool passwordcopypasteFlag = false;
  final focus = FocusNode();
  bool buttonActive = true;
  bool suggestChange = false;

  AddLandlordUserScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hp.getConnectStatus();
  }

  @override
  Widget build(BuildContext context) {
    final st = con.otherFormKey.currentState;
    return Scaffold(
        drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
        bottomNavigationBar: const BottomWidget(),
        body: SingleChildScrollView(
            physics: hp.size.shortestSide < 449 || hp.screenInsets.bottom > 0.0
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: hp.width / 32),
            child: Form(
                // onChanged: () {
                //   log(con.emailFlag);
                //   log('-----------------');
                //   log(st!.validate());
                //   log('_________________');
                //   st.setState(() {});
                // },
                autovalidateMode: AutovalidateMode.always,
                key: con.otherFormKey,
                child: SizedBox(
                    width: hp.width,
                    height: hp.height *
                        ((hp.size.shortestSide < 400)
                            ? (hp.isTablet
                                ? 1.31072
                                : (hp.isMobile
                                    ? (con.user1 == null || con.user1!.isEmpty
                                        ? (hp.size.longestSide < 599 ? 2 : 0.8)
                                        : (hp.size.longestSide < 599
                                            ? 1.6
                                            : 1.25))
                                    : 1.28))
                            : (con.user1 == null || con.user1!.isEmpty
                                ? (hp.isTablet
                                    ? (st == null
                                        ? 0.64
                                        : 0.79228162514264337593543950336)
                                    : 0.9903520314283042199192993792)
                                : (hp.isTablet ? 0.64 : 0.65536))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                              child: Center(
                                  child: Text('2/2 ADD FOR A CUSTOMER',
                                      style: hp.textTheme.headline6))),
                          // Flexible(
                          //     flex: hp.isMobile ? 2 : 1,
                          //     child: Row(children: [
                          //   Flexible(
                          //       child: Checkbox(
                          //           value: con.favouriteLandLordFlag,
                          //           onChanged:
                          //               con.onFavouriteLandLordFlagChanged)),
                          //   Flexible(
                          //       child: SelectableText('Get Favourite Landlord',
                          //           onTap: con.favouriteLandLordOnTap))
                          // ])),
                          Expanded(
                              flex: 2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 7,
                                        child: TextFormField(
                                            controller: con.emc,
                                            onTap: () {
                                              suggestPassword = false;
                                              setState(() {});
                                            },
                                            onChanged: con.emailOnChange,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Email'))),
                                    Visibility(
                                        visible: con.emc.text.isNotEmpty,
                                        child: Expanded(
                                            flex: 3,
                                            child: Text(con.mailDesc,
                                                style: TextStyle(
                                                    color: con.emailFlag
                                                        ? Colors.green
                                                        : hp.theme
                                                            .errorColor))))
                                  ])),
                          // Flexible(
                          //     flex: 2,
                          //     child: TextFormField(
                          //         controller: con.emc,
                          //         // validator: con.fieldOnChange,
                          //         onChanged: con.emailOnChange,
                          //         decoration: const InputDecoration(
                          //             border: OutlineInputBorder(),
                          //             hintText: 'Email'))),
                          // Visibility(
                          //     visible: con.emc.text.isNotEmpty,
                          //     child: Flexible(
                          //         child: Text(con.mailDesc,
                          //             style: TextStyle(
                          //                 color: con.emailFlag
                          //                     ? Colors.green
                          //                     : hp.theme.errorColor)))),
                          Flexible(
                              flex: 3,
                              child: TextFormField(
                                  controller: con.fnc,
                                  onTap: () {
                                    suggestPassword = false;
                                    setState(() {});
                                  },
                                  validator: nameValidator,
                                  readOnly: con.user1 != null &&
                                      con.user1!.isNotEmpty,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'First Name'))),
                          Flexible(
                              flex: 3,
                              child: TextFormField(
                                  controller: con.lnc,
                                  onTap: () {
                                    suggestPassword = false;
                                    setState(() {});
                                  },
                                  validator: nameValidator,
                                  readOnly: con.user1 != null &&
                                      con.user1!.isNotEmpty,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Last Name'))),
                          // Visibility(
                          //     visible:
                          //         !(con.user1 == null || con.user1!.isEmpty),
                          //     child: Flexible(
                          //         flex: hp.isMobile ? 2 : 1,
                          //         child: Row(
                          //           children: [
                          //             Flexible(
                          //                 child: Checkbox(
                          //                     value: con.addToLikedFlag,
                          //                     onChanged:
                          //                         con.onAddToLikedFlagChanged)),
                          //             Flexible(
                          //                 child: SelectableText(
                          //                     'Add to Favourites?', onTap: () {
                          //               if (mounted) {
                          //                 setState(() {
                          //                   con.addToLikedFlag =
                          //                       !(con.addToLikedFlag ?? true);
                          //                 });
                          //               }
                          //             }))
                          //           ],
                          //         ))),
                          Flexible(
                              flex: 3,
                              child: TextFormField(
                                  controller: con.phc,
                                  onTap: () {
                                    suggestPassword = false;
                                    setState(() {});
                                  },
                                  validator: phoneNumberValidator,
                                  readOnly: con.user1 != null &&
                                      con.user1!.isNotEmpty,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Contact Number'))),
                          Visibility(
                              visible: con.user1 == null || con.user1!.isEmpty,
                              child: Flexible(
                                  flex: hp.isTablet ? 4 : 5,
                                  child: TextFormField(
                                      controller: con.pwc,
                                      obscureText: con.olp,
                                      enableInteractiveSelection:
                                          passwordcopypasteFlag,
                                      onChanged: (String val) {
                                        suggestChange = false;
                                        log(val);
                                        passwordcopypasteFlag = false;
                                        log("afssdgdfsggdf");
                                        if (con.pwc.text.isEmpty) {
                                          suggestPassword = true;
                                          //  passwordGeneration();
                                        } else {
                                          suggestPassword = false;
                                        }

                                      
                                        setState(() {});
                                      },
                                      onTap: () {
                                        if (con.pwc.text.isEmpty) {
                                            passwordGeneration();
                                        }
                                        suggestPassword = false;
                                        setState(() {});
                                      },
                                     
                                      validator: hp.passwordValidator,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  con.olp = !con.olp;
                                                });
                                              },
                                              icon: Icon(con.olp
                                                  ? Icons.visibility_off
                                                  : Icons.visibility)),
                                          border: const OutlineInputBorder(),
                                          hintText: 'Password')))),
                          Visibility(
                              visible: suggestPassword,
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
                                          con.pwc.text = newPassword;
                                          suggestPassword = false;
                                          hp.currentScope.requestFocus(focus);
                                          setState(() {});
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: hp.theme.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              newPassword,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          passwordcopypasteFlag = true;
                                          con.pwc.text = newPassword2;
                                          suggestPassword = false;
                                          hp.currentScope.requestFocus(focus);
                                          setState(() {});
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            // color: Colors.grey,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: hp.theme.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              newPassword2,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          passwordcopypasteFlag = true;
                                          con.pwc.text = newPassword3;
                                          suggestPassword = false;
                                          hp.currentScope.requestFocus(focus);
                                          setState(() {});
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: hp.theme.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              newPassword3,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ))),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          Visibility(
                              visible: con.user1 == null || con.user1!.isEmpty,
                              child: Flexible(
                                  flex: hp.isTablet ? 4 : 5,
                                  child: TextFormField(
                                      focusNode: focus,
                                      controller: con.pcc,
                                      obscureText: con.olcp,
                                      onTap: () {
                                        suggestPassword = false;
                                        setState(() {});
                                      },
                                      validator: con.landLordPasswordValidator,
                                      onChanged: con.onConfirmPasswordChanged,
                                      onEditingComplete: con.onConfirmPassword,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Confirm Password')))),
                          Flexible(
                              child: Row(
                            children: [
                              Flexible(
                                  child: Checkbox(
                                      value: con.tenantViewFlag,
                                      onChanged: con.onTenantViewFlagChanged)),
                              Flexible(
                                  child: SelectableText('Tenant View Access',
                                      onTap: () {
                                if (mounted) {
                                  setState(() {
                                    con.tenantViewFlag =
                                        !(con.tenantViewFlag ?? true);
                                  });
                                }
                              }))
                            ],
                          )),
                          Flexible(
                              flex: (con.tenantViewFlag ?? false) ? 3 : 2,
                              child: MyLabelledButton(
                                  label: (con.tenantViewFlag ?? false)
                                      ? 'Proceed to Add Tenant'
                                      : 'Finish',
                                  onPressed: st == null
                                      ? null
                                      : (st.validate() && con.emailFlag
                                          ? () {
                                              con.waitUntillAddLandLord(
                                                  widget.rar.params
                                                      as Map<String, dynamic>);
                                            }
                                          : null),
                                  type: ButtonType.text,
                                  flag: st == null
                                      ? !con.emailFlag
                                      : !(st.validate() && con.emailFlag),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: hp.width /
                                          (hp.isMobile
                                              ? (hp.size.shortestSide < 400
                                                  ? 2.5
                                                  : ((con.tenantViewFlag ??
                                                          false)
                                                      ? 4
                                                      : 2.417851639229258349412352))
                                              : ((con.tenantViewFlag ?? false)
                                                  ? 2.7
                                                  : 2.305843009213693952)),
                                      vertical: hp.height /
                                          ((con.tenantViewFlag ?? false)
                                              ? 64
                                              : ((con.favouriteLandLordFlag ??
                                                      false)
                                                  ? 80
                                                  : 64)))))
                        ])))),
        appBar: AppBar(
            leading: const LeadingWidget(visible: false),
            leadingWidth: hp.leadingWidth,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                    height: hp.height /
                        (hp.isTablet
                            ? 16.384
                            : (hp.size.shortestSide < 400 ? 10 : 16)),
                    width: hp.width,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: hp.theme.hintColor,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0),
                          BoxShadow(
                              color: hp.theme.hintColor,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0)
                        ],
                        gradient: LinearGradient(
                            colors: [hp.theme.hintColor, hp.theme.hintColor],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Icon(Icons.qr_code_scanner_outlined,
                                  color: hp.theme.scaffoldBackgroundColor,
                                  size: hp.radius / 20)),
                          Expanded(
                              flex: hp.isMobile ? 6 : 9,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Flexible(
                                        child: Text('CODE SCANNED',
                                            style: TextStyle(
                                                color:
                                                    Colors.lightGreenAccent))),
                                    Flexible(
                                        child: Text(
                                            'Property ID: ${widget.rar.content!}',
                                            style: const TextStyle(
                                                color: Colors.white)))
                                  ]))
                        ]))),
            elevation: 0,
            centerTitle: true,
            backgroundColor: hp.theme.primaryColor,
            foregroundColor: hp.theme.scaffoldBackgroundColor,
            title: const Text('Scan Code',
                style: TextStyle(fontWeight: FontWeight.w600))));
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
}*/
