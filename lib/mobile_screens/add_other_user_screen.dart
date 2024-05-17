import 'package:flutter/services.dart';

import '../widgets/loader.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/drawer_widget.dart';
import '../widgets/mobile/leading_widget.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class AddOtherUserScreen extends StatefulWidget {
  final RouteArgument rar;
  const AddOtherUserScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AddOtherUserScreenState createState() => AddOtherUserScreenState();
}

class AddOtherUserScreenState extends StateMVC<AddOtherUserScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);
  bool firstNameFlag = false,
      lastNameFlag = false,
      emailFlag = false,
      phoneFlag = false,
      passwordFlag = false,
      confirmPasswordFlag = false,
      buttonActive = true;
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

  AddOtherUserScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  void fieldOnChange(String val) {
    setState(() {
      log(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.rar.tag);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          body: Form(
              key: con.otherFormKey,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: hp.width / 25,
                              right: hp.width / 25,
                              bottom: hp.height / 50,
                              top: hp.height / 50),
                          child: Text('2/2 ADD CUSTOMER',
                              style: hp.textTheme.headline6)),
                      firstName(),
                      lastName(),
                      emailId(),
                      mobileno(),
                      passwordField(),
                      confirmPasswordField(),
                      const SizedBox(
                        height: 15,
                      ),
                      finishButton()
                    ],
                  ))),
          appBar: AppBar(
              leading: const LeadingWidget(visible: false),
              leadingWidth: 110,
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
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('CODE SCANNED',
                                style:
                                    TextStyle(color: Colors.lightGreenAccent)),
                            const SizedBox(
                              height: 5,
                            ),
                            Flexible(
                                child: Text(
                                    'Property ID: ${widget.rar.content ?? ''}',
                                    // softWrap: false,
                                    // overflow: TextOverflow.ellipsis,
                                    style:
                                        const TextStyle(color: Colors.white)))
                          ],
                        ))
                      ],
                    )),
                  )),
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Add For Another User',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hp.getConnectStatus();
    buttonActive = false;
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    log('testing is calling');
  }

  Widget firstName() {
    return Container(
        height: firstNameFlag ? 100 : 71,
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
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
                    log(firstNameFlag);
                    log(lastNameFlag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (!(firstNameFlag ||
                        lastNameFlag ||
                        emailFlag ||
                        phoneFlag ||
                        passwordFlag ||
                        confirmPasswordFlag)) {
                      if (!(con.fnc.text.isEmpty ||
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
                },
                // validator: firstNameValidator,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'First Name')),
            Visibility(
              visible: firstNameFlag,
              child: Text(
                firstNameAlertText,
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget lastName() {
    return Container(
      height: lastNameFlag ? 100 : 71,
      padding: const EdgeInsets.only(top: 10, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
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
                  log(firstNameFlag);
                  log(lastNameFlag);
                  log(emailFlag);
                  log(phoneFlag);
                  log(passwordFlag);
                  log(confirmPasswordFlag);
                  if (firstNameFlag == false &&
                      lastNameFlag == false &&
                      emailFlag == false &&
                      phoneFlag == false &&
                      passwordFlag == false &&
                      confirmPasswordFlag == false) {
                    if (con.fnc.text.isNotEmpty &&
                        con.lnc.text.isNotEmpty &&
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
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Last Name')),
          Visibility(
            visible: lastNameFlag,
            child: Text(
              lastNameAlertText,
              style: const TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  Widget emailId() {
    return Container(
        height: emailFlag ? 100 : 71,
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                onTap: () {
                  sugestPassword = false;
                  setState(() {});
                },
                controller: con.emc,
                validator: hp.emailValidator,
                onChanged: (textLabel) {
                  if (textLabel.isEmpty) {
                    emailAlertText = 'Please enter a valid email.';
                  } else {
                    if (hp.emailValidator(textLabel) != null) {
                      emailAlertText = 'Please enter a valid email.';
                      emailFlag = true;
                    } else {
                      emailFlag = false;
                    }
                  }

                  setState(() {
                    emailId();
                    log(firstNameFlag);
                    log(lastNameFlag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstNameFlag == false &&
                        lastNameFlag == false &&
                        emailFlag == false &&
                        phoneFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email Address')),
            Visibility(
              visible: emailFlag,
              child: Text(
                emailAlertText,
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget mobileno() {
    return Container(
        height: phoneFlag ? 100 : 71,
        padding: const EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
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
                      //  if (con.phc.text.contains(' ')) {
                      //   phoneAlertText = 'Invalid Format, please do not leave space';
                      //  } else {
                      //  }

                      phoneAlertText = 'Invalid Format';
                      phoneFlag = true;
                    } else {
                      phoneFlag = false;
                    }
                  }

                  setState(() {
                    mobileno();
                    log(firstNameFlag);
                    log(lastNameFlag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstNameFlag == false &&
                        lastNameFlag == false &&
                        emailFlag == false &&
                        phoneFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Contact Number')),
            Visibility(
              visible: phoneFlag,
              child: Text(
                phoneAlertText,
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  /*Widget passwordField() {
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
                  log('anfdkjsnfsndf');
                  if (con.pwc.text.isNotEmpty) {
                    if (hp.passwordValidstructure(textLabel) == null) {
                      passwordFlag = false;
                      setState(() {
                        buttonActive = con.pwc.text == con.pcc.text;
                        confirmPasswordFlag = con.pwc.text != con.pcc.text;
                      });
                    } else {
                      passwordFlag = true;
                    }
                  } else {
                    passwordFlag = false;
                  }
                  setState(() {
                    passwordField();
                    log(firstNameFlag);
                    log(lastNameFlag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstNameFlag == false &&
                        lastNameFlag == false &&
                        emailFlag == false &&
                        phoneFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
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
              child:hp.passwordValidstructure(con.pwc.text) ?? Text(''),
            )
          ],
        ));
  }*/

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
    passwordGeneration();
    return Container(
        padding: const EdgeInsets.only(top: 5),
        height: passwordFlag
            ? 230
            : sugestPassword
                ? 160
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
                onChanged: (textLabel) {
                  passwordcopypasteFlag = false;
                  if (con.pwc.text.isEmpty) {
                    sugestPassword = true;
                  } else {
                    sugestPassword = false;
                  }

                  log('anfdkjsnfsndf');
                  if (con.pwc.text.isNotEmpty) {
                    if (hp.passwordValidstructure(textLabel) == null) {
                      passwordFlag = false;
                      setState(() {
                        buttonActive = con.pwc.text == con.pcc.text;
                        confirmPasswordFlag = con.pwc.text != con.pcc.text;
                      });
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
                    log(firstNameFlag);
                    log(lastNameFlag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (firstNameFlag == false &&
                        lastNameFlag == false &&
                        emailFlag == false &&
                        phoneFlag == false &&
                        passwordFlag == false &&
                        confirmPasswordFlag == false) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
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
                // {
                //   log(textLabel);
                //   passwordcopypasteFlag = false;
                // if (con.pwc.text.isEmpty) {
                //   sugestPassword = true;
                // } else {
                //   sugestPassword = false;
                // }
                //   if (con.pwc.text.isNotEmpty) {
                //     if (hp.passwordValidstructure(textLabel) == null) {
                //       passwordFlag = false;
                //     } else {
                //       passwordFlag = true;
                //     }
                //   } else {
                //     passwordFlag = false;
                //   }
                //   setState(() {});
                //   // passwordField();
                // },
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
                            con.pwc.text = newPassword;
                            con.pcc.text = newPassword;
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
                            con.pcc.text = newPassword2;
                            confirmPasswordFlag = false;
                            sugestPassword = false;
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
                    log(firstNameFlag);
                    log(lastNameFlag);
                    log(emailFlag);
                    log(phoneFlag);
                    log(passwordFlag);
                    log(confirmPasswordFlag);
                    if (!(firstNameFlag ||
                        lastNameFlag ||
                        emailFlag ||
                        phoneFlag ||
                        passwordFlag ||
                        confirmPasswordFlag)) {
                      if (con.fnc.text.isNotEmpty &&
                          con.lnc.text.isNotEmpty &&
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
          ],
        ));
  }

  Widget finishButton() {
    return SizedBox(
      height: 50,
      width: hp.width,
      child: ElevatedButton(
        onPressed: buttonActive && con.pwc.text == con.pcc.text
            ? () async {
                Map<String, dynamic> map =
                    widget.rar.params as Map<String, dynamic>;
                map['email'] = con.emc.text;
                map['first_name'] = con.fnc.text;
                map['last_name'] = con.lnc.text;
                map['phone'] = con.phc.text.trim().replaceAll(RegExp(' +'), '');
                map['password'] = con.pwc.text;
                log(map['phone']);

                hp.currentScope.unfocus();
                log(map);
                waitUntilAddOtherUser(map);
              }
            : null,

        style: ElevatedButton.styleFrom(
            primary: hp.theme.primaryColor,
            onSurface: hp.theme
                .primaryColor), //ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(hp.theme.primaryColor)),
        child: const Text('Finish', style: TextStyle(color: Colors.white)),
      ),
      // padding: EdgeInsets.only(
      //     top: hp.height / 100, bottom: hp.height / 100)
    );
  }

  void waitUntilAddOtherUser(Map<String, dynamic> body) async {
    try {
      // final typeName = body['property_type_name'];
      log(body);
      log('come does');
      // body.removeWhere((key, value) => key == 'property_type_name');
      Loader.show(context);
      final val = await api.addPropertyForOther(body);
      Loader.hide();
      final f2 = await (hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      }, type: AlertType.cupertino, action: val.reply.message));
      if (f2 && val.reply.success) {
        // body['property_type_name'] = typeName;
        hp.goTo('/add_property_other_success',
            args: RouteArgument(params: body, tag: widget.rar.tag));
      } else {
        log('object');
        // hp.goBackForeverTo('/mobile_home');
      }
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) log('for outside');
      Loader.hide();
    }
  }
}
