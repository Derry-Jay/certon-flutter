import '../backend/api.dart';
import '../widgets/loader.dart';
import 'package:flutter/services.dart';

import '../helpers/helper.dart';
import '../models/property_type.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../widgets/mobile/bottom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';

class AddTenantScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddTenantScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddTenantScreenState createState() => AddTenantScreenState();
}

class AddTenantScreenState extends StateMVC<AddTenantScreen> {
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
      tenantViewFlag = false,
      suggestChange = false,
      sugestPassword = false,
      passwordVisible = false,
      passwordcopypasteFlag = false;

  String firstNameAlertText = '',
      lastNameAlertText = '',
      emailAlertText = '',
      phoneAlertText = '',
      newPassword = '',
      newPassword2 = '',
      newPassword3 = '';
  final focus = FocusNode();

  AddTenantScreenState() : super(UserController()) {
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
          // const ,
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
          //                       'Property ID: ${widget.rar.params['qrcode']}',
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
          // physics: hp.size.shortestSide < 449 || hp.screenInsets.bottom > 0.0
          //     ? const AlwaysScrollableScrollPhysics()
          //     : const NeverScrollableScrollPhysics(),
          // padding: const EdgeInsets.all(20),
          child: SizedBox(
              height: hp.height * 1.125899906842624,
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
                                  style: TextStyle(
                                      color: Colors.lightGreenAccent)),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Text(
                                  'Property ID:  ${widget.rar.params['qrcode']}',
                                  softWrap: false,
                                  // maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(color: Colors.white))
                            ],
                          ),
                        )
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
                        //                 'Property ID: ${widget.rar.params['qrcode']}',
                        //                 // softWrap: false,
                        //                 // overflow: TextOverflow.ellipsis,
                        //                 style:
                        //                     const TextStyle(color: Colors.white)))
                        //       ],
                        //     ))
                      ],
                    )),
                Center(
                    child: Text('ADD TENANT', style: hp.textTheme.headline6)),
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
                    visible: con.user2 == null ? true : false,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: passwordField())),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                    visible: con.user2 == null ? true : false,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: confirmPasswordField())),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: finishButton())
              ]))),
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

  Widget firstName() {
    return Container(
        // height: firstNameFlag ? 100 : 71,
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text('Tenant First Name',
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
                  controller: con.tfn,
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
                      border: OutlineInputBorder(),
                      hintText: 'Tenant First Name')),
            ),
            Visibility(
              visible: firstNameFlag,
              child: Text(
                con.tfn.text.isEmpty
                    ? 'Please enter a First Name'
                    : con.tfn.text.length > 2
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
          const Text('Tenant Last Name',
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
                controller: con.tln,
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
                    border: OutlineInputBorder(),
                    hintText: 'Tenant Last Name')),
          ),
          Visibility(
            visible: lastNameFlag,
            child: Text(
              con.tln.text.isEmpty
                  ? 'Please enter a Last Name'
                  : con.tln.text.length > 2
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
            const SizedBox(height: 5),
            const Text('Tenant Email Address',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                textScaleFactor: 1.0),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                  onTap: () {
                    sugestPassword = false;

                    if (con.tem.text.isEmpty) {
                      emailFlag = true;
                      emailAlertText = 'Please enter a valid email.';
                    } else {
                      if (hp.emailValidator(con.tem.text) != null) {
                        emailAlertText = 'Please enter a valid email.';
                        emailFlag = true;
                      } else {
                        // if (currentUser.value.userEmail == con.emc.text) {
                        //     emailAlertText = 'You entered a landlord email for Tenant email.';
                        //   emailFlag = true;
                        // } else

                        if (currentUser.value.userEmail == con.tem.text) {
                          emailAlertText =
                              'You entered your email for Tenant email.';
                          emailFlag = true;
                        } else if (con.emc.text == con.tem.text) {
                          emailAlertText =
                              'You entered a landlord email for Tenant email.';
                          emailFlag = true;
                        } else {
                          // emailFlag = false;
                          // tenantEmailOnChange(con.tem.text);
                        }
                      }
                    }

                    if (con.user2 == null) {
                      con.tfn.text.isEmpty
                          ? firstNameFlag = true
                          : con.tfn.text.length > 2
                              ? firstNameFlag = false
                              : firstNameFlag = true;
                      con.tln.text.isEmpty
                          ? lastNameFlag = true
                          : con.tln.text.length > 2
                              ? lastNameFlag = false
                              : lastNameFlag = true;
                      // lastNameFlag = true;

                      con.tph.text.isEmpty
                          ? phoneFlag = true
                          : phoneNumberValidator(con.phc.text) != null
                              ? phoneFlag = true
                              : phoneFlag = false;

                      hp.passwordValidstructure(con.tpw.text) != null
                          ? passwordFlag = true
                          : passwordFlag = false;
                      hp.passwordValidstructure(con.tpc.text) != null
                          ? confirmPasswordFlag = true
                          : confirmPasswordFlag = false;
                    }
                    setState(() {});
                  },
                  controller: con.tem,
                  validator: hp.emailValidator,
                  onFieldSubmitted: (textlabel) {
                    if (currentUser.value.userEmail == textlabel) {
                      emailAlertText =
                          'You entered your email for Tenant email.';
                      emailFlag = true;
                    } else if (con.emc.text == textlabel) {
                      emailAlertText =
                          'You entered a landlord email for Tenant email.';
                      emailFlag = true;
                    } else {
                      emailFlag = false;
                      tenantEmailOnChange(textlabel);
                    }
                  },
                  onChanged: (textLabel) {
                    if (textLabel.isEmpty) {
                      emailFlag = true;
                      emailAlertText = 'Please enter a valid email.';
                    } else {
                      if (hp.emailValidator(textLabel) != null) {
                        emailAlertText = 'Please enter a valid email.';
                        emailFlag = true;
                      } else {
                        // if (currentUser.value.userEmail == con.emc.text) {
                        //     emailAlertText = 'You entered a landlord email for Tenant email.';
                        //   emailFlag = true;
                        // } else

                        if (currentUser.value.userEmail == textLabel) {
                          emailAlertText =
                              'You entered your email for Tenant email.';
                          emailFlag = true;
                        } else if (con.emc.text == textLabel) {
                          emailAlertText =
                              'You entered a landlord email for Tenant email.';
                          emailFlag = true;
                        } else {
                          emailFlag = false;
                          tenantEmailOnChange(textLabel);
                        }
                      }
                    }

                    if (con.user2 == null) {
                      con.tfn.text.isEmpty
                          ? firstNameFlag = true
                          : con.tfn.text.length > 2
                              ? firstNameFlag = false
                              : firstNameFlag = true;
                      con.tln.text.isEmpty
                          ? lastNameFlag = true
                          : con.tln.text.length > 2
                              ? lastNameFlag = false
                              : lastNameFlag = true;
                      // lastNameFlag = true;

                      con.tpc.text.isEmpty
                          ? phoneFlag = true
                          : phoneNumberValidator(con.tph.text) != null
                              ? phoneFlag = true
                              : phoneFlag = false;

                      hp.passwordValidstructure(con.tpw.text) != null
                          ? passwordFlag = true
                          : passwordFlag = false;
                      hp.passwordValidstructure(con.tpc.text) != null
                          ? confirmPasswordFlag = true
                          : confirmPasswordFlag = false;
                    }

                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Tenant Email Address')),
            ),
            Visibility(
              visible: emailFlag,
              child: Text(
                con.user2 == null
                    ? con.tem.text == con.emc.text
                        ? emailAlertText
                        : con.tem.text == currentUser.value.userEmail
                            ? emailAlertText
                            : 'Please enter a valid email.'
                    : emailAlertText,
                style: TextStyle(
                    color: con.user2 == null ? Colors.red : Colors.green),
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
            const Text('Tenant Contact Number',
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
                  controller: con.tph,
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
                      if (phoneNumberValidator(con.tph.text) != null) {
                        log(phoneNumberValidator(con.tph.text));

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
                      hintText: 'Tenant Contact Number')),
            ),
            Visibility(
              visible: phoneFlag,
              child: Text(
                con.tph.text.isEmpty
                    ? 'Please enter a Valid Phone Number.'
                    : (phoneNumberValidator(con.tph.text) != null)
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
    if (!suggestChange) {
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
            const Text('Tenant Password',
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
                  controller: con.tpw,
                  onChanged: (textLabel) {
                    log('anfdkjsnfsndf');
                    passwordcopypasteFlag = false;
                    suggestChange = false;
                    if (con.tpw.text.isEmpty) {
                      sugestPassword = true;
                    } else {
                      sugestPassword = false;
                    }

                    if (con.tpw.text.isNotEmpty) {
                      if (hp.passwordValidstructure(textLabel) == null) {
                        passwordFlag = false;
                        setState(() {
                          buttonActive = con.tpw.text == con.tpc.text;
                          confirmPasswordFlag = con.tpw.text != con.tpc.text;
                        });
                      } else {
                        log('adfssdfdgfhdghj');
                        passwordFlag = true;
                      }
                    } else {
                      log('adfsdgsdfgdfg');
                      if (sugestPassword) {
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
                          (con.tpw.text.isNotEmpty)
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
                      hintText: 'Tenant Password')),
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
                            con.tpw.text = newPassword;
                            con.tpc.text = newPassword;
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
                            con.tpw.text = newPassword2;
                            con.tpc.text = newPassword2;
                            confirmPasswordFlag = false;
                            sugestPassword = false;
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
                            con.tpw.text = newPassword3;
                            con.tpc.text = newPassword3;
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
              child: hp.passwordValidstructure(con.tpw.text) ?? const Text(''),
            )
          ],
        ));
  }

  Widget confirmPasswordField() {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        // height: confirmPasswordFlag ? 230 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text('Tenant Confirm Password',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                textScaleFactor: 1.0),
            const SizedBox(height: 5),
            SizedBox(
              child: TextFormField(
                  enableInteractiveSelection: passwordcopypasteFlag,
                  focusNode: focus,
                  onTap: () {
                    sugestPassword = false;
                    setState(() {});
                  },
                  obscureText: true,
                  controller: con.tpc,
                  onChanged: (textLabel) {
                    if (con.tpc.text.isNotEmpty) {
                      if (con.tpc.text == con.tpw.text) {
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
                      suffixIcon: con.tpw.text.isNotEmpty &&
                              con.tpc.text.isNotEmpty
                          ? (confirmPasswordFlag || con.tpw.text != con.tpc.text
                              ? const Icon(Icons.cancel, color: Colors.red)
                              : const Icon(Icons.check, color: Colors.green))
                          : null,
                      // suffixIconColor: Colors.red,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: hp.height / 100, horizontal: hp.width / 40),
                      border: const OutlineInputBorder(),
                      hintText: 'Tenant Confirm Password')),
            ),
            Visibility(
                visible: confirmPasswordFlag,
                child: con.tpc.text.isEmpty
                    ? const Text(
                        'Please enter the confirm password.',
                        style: TextStyle(color: Colors.red),
                      )
                    : hp.passwordValidstructure(con.tpc.text) == null
                        ? (con.tpc.text == con.tpw.text
                            ? const Text('')
                            : const Text(
                                'Password and Confirm Password are not same',
                                style: TextStyle(color: Colors.red),
                              ))
                        : const Text(
                            'Please enter the confirm password.',
                            style: TextStyle(color: Colors.red),
                          ))
          ],
        ));
  }

  Widget finishButton() {
    return SizedBox(
      height: 50,
      width: hp.width,
      child: ElevatedButton(
        onPressed: () async {
          if (con.user2 != null) {
            addLandlordWithTenant(widget.rar.params as Map<String, dynamic>);
          } else {
            // if () {
            //   emailFlag = true;
            // } else {
            //   emailFlag = false;
            // }

            // if () {
            //   firstNameFlag = true;
            // } else {
            //   firstNameFlag = false;
            // }

            // if () {
            //   lastNameFlag = true;
            // } else {
            //   lastNameFlag = false;
            // }

            // if () {
            //   phoneFlag = true;
            // } else {
            //   phoneFlag = false;
            // }

            // if (con.tpw.text.isEmpty) {
            //   passwordFlag = true;
            // } else {
            //   passwordFlag = false;
            // }

            // if (con.tpc.text.isEmpty) {
            //   confirmPasswordFlag = true;
            // } else {
            //   confirmPasswordFlag = false;
            // }

            setState(() {
              emailFlag = con.tem.text.isEmpty;
              firstNameFlag = con.tfn.text.isEmpty;
              lastNameFlag = con.tln.text.isEmpty;
              phoneFlag = con.tph.text.isEmpty;
              passwordFlag = con.tpw.text.isEmpty ||
                  hp.passwordValidstructure(con.tpc.text) != null;
              confirmPasswordFlag =
                  con.tpc.text.isEmpty || con.tpc.text != con.tpw.text;
            });
          }
          if (!(emailFlag ||
              firstNameFlag ||
              lastNameFlag ||
              phoneFlag ||
              passwordFlag ||
              confirmPasswordFlag)) {
            addLandlordWithTenant(widget.rar.params as Map<String, dynamic>);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: hp.theme.primaryColor,
        ),
        child: const Text('Finish', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void tenantEmailOnChange(String? email) async {
    try {
      RegExp mailExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (email != null && email.isNotEmpty && hp.mounted) {
        if (mailExp.hasMatch(email) &&
            mailExp.allMatches(email).length == 1 &&
            email != currentUser.value.userEmail) {
          final val = await api.checkValidMail(email,
              email == con.emc.text ? 4 : (email == con.tem.text ? 3 : 0));
          final rp = val.base;
          if (rp.success && val.user.isNotEmpty) {
            con.tfn.text = val.user.firstName;
            con.tln.text = val.user.lastName;
            con.tph.text = val.user.phoneNo;
            // con.fnc.text = val.user.firstName;
            // con.lnc.text = val.user.lastName;
            // con.phc.text = val.user.phoneNo;
            conditionalflag = false;
            showpasswordField = false;
            showConfirmPasswordField = false;
            firstNameFlag = false;
            lastNameFlag = false;
            phoneFlag = false;
            emailFlag = false;
            passwordFlag = false;
            confirmPasswordFlag = false;
          }
          setState(() {
            if (val.user.isNotEmpty) {
              con.user2 = val.user;
              emailAlertText = rp.message;
              emailFlag = rp.success;
            } else if (con.user2 != null) {
              con.user2 = null;
              con.tfn.text = '';
              con.tln.text = '';
              con.tph.text = '';
              con.tpw.text = '';
              con.tpc.text = '';
              emailAlertText = rp.message;
            }
            if (val.user.isEmpty) {
              log('checking');
              conditionalflag = true;
              con.tfn.text.isEmpty
                  ? firstNameFlag = true
                  : con.tfn.text.length > 2
                      ? firstNameFlag = false
                      : firstNameFlag = true;
              con.tln.text.isEmpty
                  ? lastNameFlag = true
                  : con.tln.text.length > 2
                      ? lastNameFlag = false
                      : lastNameFlag = true;
              // lastNameFlag = true;

              con.tph.text.isEmpty
                  ? phoneFlag = true
                  : phoneNumberValidator(con.tph.text) != null
                      ? phoneFlag = true
                      : phoneFlag = false;

              hp.passwordValidstructure(con.tpw.text) != null
                  ? passwordFlag = true
                  : passwordFlag = false;
              hp.passwordValidstructure(con.tpc.text) != null
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
          });
        } else {
          con.tfn.text = '';
          con.tln.text = '';
          con.tph.text = '';
          con.tpw.text = '';
          con.tpc.text = '';
          conditionalflag = true;
          showpasswordField = true;
          showConfirmPasswordField = true;
          setState(() {
            emailFlag = false;
            if (con.user2 != null) {
              con.user2 = null;
            }
            emailAlertText = 'Please Enter a Valid Email!!!';
          });
        }
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void addLandlordWithTenant(Map<String, dynamic> map) async {
    bool typeCriteria(PropertyType element) {
      return element.typeID == int.tryParse(map['property_type'].toString());
    }

    try {
      final body = Map<String, dynamic>.from(map);
      if (con.tfn.text.isNotEmpty) {
        body['tenant_first_name'] = con.tfn.text;
      }
      log(body);
      if (con.tln.text.isNotEmpty) {
        body['tenant_last_name'] = con.tln.text;
      }
      log(body);
      if (con.tem.text.isNotEmpty) {
        body['tenant_email'] = con.tem.text;
      }
      log(body);
      if (con.tph.text.isNotEmpty) {
        body['tenant_phone'] = con.tph.text;
      }
      log(body);
      body['tenant_password'] = con.tpw.text;
      log(body);
      log('object');
      Loader.show(context);
      final rp = await api.addLandLord(body);
      Loader.hide();
      final p = await hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      }, action: rp.message, type: AlertType.cupertino);
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
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }
}

/*
class AddTenantScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddTenantScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddTenantScreenState createState() => AddTenantScreenState();
}

class AddTenantScreenState extends StateMVC<AddTenantScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);
  AddTenantScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hp.getConnectStatus();
  }

  // @override
  // void didUpdateWidget(AddTenantScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   log('testing is calling');
  // }

  @override
  Widget build(BuildContext context) {
    final st = con.tenantFormKey.currentState;
    log(widget.rar);
    return Scaffold(
        bottomNavigationBar: const BottomWidget(),
        drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: hp.width / 32),
            child: Form(
                key: con.tenantFormKey,
                child: SizedBox(
                    width: hp.width,
                    height: hp.height *
                        (con.user2 == null || con.user2!.isEmpty
                            ? 1.09
                            : 0.65536),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            flex: 5,
                            child: Text('ADD TENANT',
                                style: hp.textTheme.headline6)),
                        Expanded(
                            flex: 3,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      flex: 9,
                                      child: TextFormField(
                                          controller: con.tem,
                                          onTap: con.disableSuggestPassword,
                                          onChanged: con.tenantEmailOnChange,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Tenant Email'))),
                                  Visibility(
                                      visible: con.tem.text.isNotEmpty,
                                      child: Expanded(
                                          flex: 3,
                                          child: Text(con.tenantMailDesc,
                                              style: TextStyle(
                                                  color: con.tenantEmailFlag
                                                      ? Colors.green
                                                      : hp.theme.errorColor))))
                                ]))
                        // Flexible(
                        //     flex: 4,
                        //     child: TextFormField(
                        //         controller: con.tem,
                        //         onChanged: con.tenantEmailOnChange,
                        //         decoration: const InputDecoration(
                        //             border: OutlineInputBorder(),
                        //             hintText: 'Tenant Email'))),
                        // Visibility(
                        //     visible: con.tem.text.isNotEmpty,
                        //     child: Flexible(
                        //         flex: 2,
                        //         child: Text(con.tenantMailDesc,
                        //             style: TextStyle(
                        //                 color: con.tenantEmailFlag
                        //                     ? Colors.green
                        //                     : hp.theme.errorColor))))
                        ,
                        Flexible(
                            flex: 4,
                            child: TextFormField(
                                onTap: con.disableSuggestPassword,
                                controller: con.tfn,
                                validator: nameValidator,
                                readOnly:
                                    con.user2 != null && con.user2!.isNotEmpty,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Tenant First Name'))),
                        Flexible(
                            flex: 4,
                            child: TextFormField(
                                onTap: con.disableSuggestPassword,
                                controller: con.tln,
                                validator: nameValidator,
                                readOnly:
                                    con.user2 != null && con.user2!.isNotEmpty,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Tenant Last Name'))),
                        Flexible(
                            flex: 4,
                            child: TextFormField(
                                onTap: con.disableSuggestPassword,
                                controller: con.tph,
                                validator: phoneNumberValidator,
                                readOnly:
                                    con.user2 != null && con.user2!.isNotEmpty,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Tenant Contact Number'))),
                        Visibility(
                            visible:
                                !(con.user2 != null && con.user2!.isNotEmpty),
                            child: Flexible(
                                flex: 10,
                                child: TextFormField(
                                    controller: con.tpw,
                                    obscureText: con.otp,
                                    enableInteractiveSelection:
                                        con.passwordcopypasteFlag,
                                    onChanged: (String val) {
                                      // setState(() {
                                      //   con.passwordcopypasteFlag = false;
                                      // });
                                    },
                                    onTap: con.tenantPasswordFieldOnTap,
                                    validator: hp.passwordValidator,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                con.otp = !con.otp;
                                              });
                                            },
                                            icon: Icon(con.olp
                                                ? Icons.visibility
                                                : Icons
                                                    .visibility_off_outlined)),
                                        border: const OutlineInputBorder(),
                                        hintText: 'Tenant Password')))),
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
                                        con.tpw.text = con.newPassword;
                                        con.suggestPassword = false;
                                        hp.currentScope.requestFocus(con.focus);
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
                                        con.tpw.text = con.newPassword2;
                                        con.suggestPassword = false;
                                        hp.currentScope.requestFocus(con.focus);
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
                                        con.tpw.text = con.newPassword3;
                                        con.suggestPassword = false;
                                        hp.currentScope.requestFocus(con.focus);
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
                            visible:
                                !(con.user2 != null && con.user2!.isNotEmpty),
                            child: Flexible(
                                flex: 8,
                                child: TextFormField(
                                    focusNode: con.focus,
                                    controller: con.tpc,
                                    obscureText: con.otcp,
                                    onTap: con.disableSuggestPassword,
                                    validator: con.tenantPasswordValidator,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Confirm Password for Tenant')))),
                        Flexible(
                            flex: 3,
                            child: MyLabelledButton(
                                label: 'Finish',
                                onPressed: st == null
                                    ? null
                                    : (st.validate() && con.tenantEmailFlag
                                        ? () {
                                            con.addLandlordWithTenant(
                                                widget.rar.params
                                                    as Map<String, dynamic>);
                                          }
                                        : null),
                                type: ButtonType.text,
                                flag: st == null
                                    ? !con.tenantEmailFlag
                                    : !(st.validate() && con.tenantEmailFlag),
                                padding: EdgeInsets.symmetric(
                                    horizontal: hp.width /
                                        (hp.isMobile
                                            ? (hp.size.shortestSide < 400
                                                ? 2.5
                                                : 2.417851639229258349412352)
                                            : 2.305843009213693952),
                                    vertical: hp.height / 64)))
                      ],
                    )))),
        appBar: AppBar(
            leading: const LeadingWidget(visible: false),
            leadingWidth: hp.leadingWidth,
            bottom: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: Container(
                  height: 60,
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
                            blurRadius: 0.0),
                      ],
                      gradient: LinearGradient(
                          colors: [hp.theme.hintColor, hp.theme.hintColor],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                  child: Center(
                      child: Row(
                    children: [
                      Icon(Icons.qr_code_scanner_outlined,
                          color: hp.theme.scaffoldBackgroundColor,
                          size: hp.radius / 20),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('CODE SCANNED',
                              style: TextStyle(color: Colors.lightGreenAccent)),
                          const SizedBox(height: 5),
                          Text('Property ID: ${widget.rar.params['qrcode']}',
                              style: const TextStyle(color: Colors.white))
                        ],
                      )
                    ],
                  )),
                )),
            elevation: 0,
            centerTitle: true,
            backgroundColor: hp.theme.primaryColor,
            foregroundColor: hp.theme.scaffoldBackgroundColor,
            title: const Text('Add Tenant',
                style: TextStyle(fontWeight: FontWeight.w600))));
  }
}

*/

/*import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../widgets/mobile/bottom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
import '../widgets/mobile/my_labelled_button.dart';

class AddTenantScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddTenantScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddTenantScreenState createState() => AddTenantScreenState();
}

class AddTenantScreenState extends StateMVC<AddTenantScreen> {
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

  AddTenantScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hp.getConnectStatus();
  }

  // @override
  // void didUpdateWidget(AddTenantScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   log('testing is calling');
  // }

  @override
  Widget build(BuildContext context) {
    final st = con.tenantFormKey.currentState;
    log(widget.rar);
    return Scaffold(
        bottomNavigationBar: const BottomWidget(),
        drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: hp.width / 32),
            child: Form(
                key: con.tenantFormKey,
                child: SizedBox(
                    width: hp.width,
                    height: hp.height *
                        (con.user2 == null || con.user2!.isEmpty
                            ? 1.09
                            : 0.65536),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            flex: 5,
                            child: Text('ADD TENANT',
                                style: hp.textTheme.headline6)),
                        Expanded(
                            flex: 3,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      flex: 9,
                                      child: TextFormField(
                                          controller: con.tem,
                                          onTap: () {
                                            suggestPassword = false;
                                            setState(() {});
                                          },
                                          onChanged: con.tenantEmailOnChange,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Tenant Email'))),
                                  Visibility(
                                      visible: con.tem.text.isNotEmpty,
                                      child: Expanded(
                                          flex: 3,
                                          child: Text(con.tenantMailDesc,
                                              style: TextStyle(
                                                  color: con.tenantEmailFlag
                                                      ? Colors.green
                                                      : hp.theme.errorColor))))
                                ]))
                        // Flexible(
                        //     flex: 4,
                        //     child: TextFormField(
                        //         controller: con.tem,
                        //         onChanged: con.tenantEmailOnChange,
                        //         decoration: const InputDecoration(
                        //             border: OutlineInputBorder(),
                        //             hintText: 'Tenant Email'))),
                        // Visibility(
                        //     visible: con.tem.text.isNotEmpty,
                        //     child: Flexible(
                        //         flex: 2,
                        //         child: Text(con.tenantMailDesc,
                        //             style: TextStyle(
                        //                 color: con.tenantEmailFlag
                        //                     ? Colors.green
                        //                     : hp.theme.errorColor))))
                        ,
                        Flexible(
                            flex: 4,
                            child: TextFormField(
                                onTap:  () {
                                  suggestPassword = false;
                                  setState(() {});
                                },
                                controller: con.tfn,
                                validator: nameValidator,
                                readOnly:
                                    con.user2 != null && con.user2!.isNotEmpty,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Tenant First Name'))),
                        Flexible(
                            flex: 4,
                            child: TextFormField(
                                onTap:  () {
                                  suggestPassword = false;
                                  setState(() {});
                                },
                                controller: con.tln,
                                validator: nameValidator,
                                readOnly:
                                    con.user2 != null && con.user2!.isNotEmpty,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Tenant Last Name'))),
                        Flexible(
                            flex: 4,
                            child: TextFormField(
                                onTap:  () {
                                  suggestPassword = false;
                                  setState(() {});
                                },
                                controller: con.tph,
                                validator: phoneNumberValidator,
                                readOnly:
                                    con.user2 != null && con.user2!.isNotEmpty,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Tenant Contact Number'))),
                        Visibility(
                            visible:
                                !(con.user2 != null && con.user2!.isNotEmpty),
                            child: Flexible(
                                flex: 10,
                                child: TextFormField(
                                    controller: con.tpw,
                                    obscureText: con.otp,
                                    enableInteractiveSelection:
                                        passwordcopypasteFlag,
                                    onChanged: (String val) {
                                      setState(() {
                                        passwordcopypasteFlag = false;
                                      });
                                    },
                                    onTap: () {
                                       log('focused');
                                      if (con.pwc.text.isEmpty) {
                                        suggestPassword = true;
                                      } else {
                                        suggestPassword = false;
                                      }
                                      setState(() {});
                                    },
                                    validator: hp.passwordValidator,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                con.otp = !con.otp;
                                              });
                                            },
                                            icon: Icon(con.olp
                                                ? Icons.visibility
                                                : Icons
                                                    .visibility_off_outlined)),
                                        border: const OutlineInputBorder(),
                                        hintText: 'Tenant Password')))),
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
                                        con.tpw.text = newPassword;
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
                                        con.tpw.text = newPassword2;
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
                                        con.tpw.text = newPassword3;
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
                            visible:
                                !(con.user2 != null && con.user2!.isNotEmpty),
                            child: Flexible(
                                flex: 8,
                                child: TextFormField(
                                    focusNode: focus,
                                    controller: con.tpc,
                                    obscureText: con.otcp,
                                    onTap:  () {
                                            suggestPassword = false;
                                            setState(() {});
                                          },
                                    validator: con.tenantPasswordValidator,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Confirm Password for Tenant')))),
                        Flexible(
                            flex: 3,
                            child: MyLabelledButton(
                                label: 'Finish',
                                onPressed: st == null
                                    ? null
                                    : (st.validate() && con.tenantEmailFlag
                                        ? () {
                                            con.addLandlordWithTenant(
                                                widget.rar.params
                                                    as Map<String, dynamic>);
                                          }
                                        : null),
                                type: ButtonType.text,
                                flag: st == null
                                    ? !con.tenantEmailFlag
                                    : !(st.validate() && con.tenantEmailFlag),
                                padding: EdgeInsets.symmetric(
                                    horizontal: hp.width /
                                        (hp.isMobile
                                            ? (hp.size.shortestSide < 400
                                                ? 2.5
                                                : 2.417851639229258349412352)
                                            : 2.305843009213693952),
                                    vertical: hp.height / 64)))
                      ],
                    )))),
        appBar: AppBar(
            leading: const LeadingWidget(visible: false),
            leadingWidth: hp.leadingWidth,
            bottom: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: Container(
                  height: 60,
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
                            blurRadius: 0.0),
                      ],
                      gradient: LinearGradient(
                          colors: [hp.theme.hintColor, hp.theme.hintColor],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                  child: Center(
                      child: Row(
                    children: [
                      Icon(Icons.qr_code_scanner_outlined,
                          color: hp.theme.scaffoldBackgroundColor,
                          size: hp.radius / 20),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('CODE SCANNED',
                              style: TextStyle(color: Colors.lightGreenAccent)),
                          const SizedBox(height: 5),
                          Text('Property ID: ${widget.rar.params['qrcode']}',
                              style: const TextStyle(color: Colors.white))
                        ],
                      )
                    ],
                  )),
                )),
            elevation: 0,
            centerTitle: true,
            backgroundColor: hp.theme.primaryColor,
            foregroundColor: hp.theme.scaffoldBackgroundColor,
            title: const Text('Add Tenant',
                style: TextStyle(fontWeight: FontWeight.w600))));
  }
}
*/
