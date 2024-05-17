import '../models/user.dart';
import '../backend/api.dart';
import '../helpers/helper.dart';
import '../widgets/loader.dart';
import '../models/property_type.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ControllerMVC {
  Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(),
      registerFormKey = GlobalKey<FormState>(),
      editProfileFormKey = GlobalKey<FormState>(),
      contractorDetailsFormKey = GlobalKey<FormState>(),
      resetPasswordFormKey = GlobalKey<FormState>(),
      tenantFormKey = GlobalKey<FormState>(),
      otherFormKey = GlobalKey<FormState>();
  String mailDesc = '', profileAddress = '', tenantMailDesc = '', token = '';
  String? address;
  Duration duration = const Duration(seconds: 5);
  List<bool> flags = <bool>[],
      ticks = List<bool>.filled(6, false),
      contFlags = <bool>[];
  TextEditingController emc = TextEditingController(),
      pwc = TextEditingController(),
      fnc = TextEditingController(),
      lnc = TextEditingController(),
      phc = TextEditingController(),
      pc = TextEditingController(),
      pcc = TextEditingController(),
      adc = TextEditingController(),
      phCc = TextEditingController(),
      cnc = TextEditingController(),
      crc = TextEditingController(),
      tfn = TextEditingController(),
      tln = TextEditingController(),
      tem = TextEditingController(),
      tph = TextEditingController(),
      tpw = TextEditingController(),
      tpc = TextEditingController(),
      compNa = TextEditingController(),
      compNo = TextEditingController(),
      compRegNo = TextEditingController();
  List<String> sectors = <String>[
        'Electrical',
        'Compliance',
        'Gas Safe',
        'Construction',
        'Fire',
        'Other'
      ],
      selected = <String>[];
  List<int> selectedIndices = <int>[];
  UserType? ut;
  User? user1, user2;
  bool? favouriteLandLordFlag = false,
      addToLikedFlag = false,
      landlordViewFlag = false,
      tenantViewFlag = false;
  bool emailFlag = false,
      tenantEmailFlag = false,
      passwordFlag = false,
      olp = true,
      olcp = true,
      otp = true,
      otcp = true,
      rm = false,
      suggestPassword = false,
      passwordcopypasteFlag = false,
      checkedLandlordFlag = false;
  String newPassword = '', newPassword2 = '', newPassword3 = '';
  final focus = FocusNode();
  Helper get hp => Helper.of(state == null && states.isNotEmpty
      ? states.first.context
      : state!.context);

  void setValues(User user) {
    try {
      fnc.text = user.firstName;
      lnc.text = user.lastName;
      emc.text = user.userEmail;
      phc.text = user.phoneNo;
      pc.text = user.pinCode;
      log(user);
      log(user.address1);
      log(user.address2);
      adc.text = '${user.address1}, ${user.address2}, ${user.city}';
      if (currentUser.value.role.roleID == 5) {
        compNa.text = user.companyName ?? '';
        compNo.text = user.companyPhone ?? '';
        compRegNo.text = user.companyNo ?? '';
        log(user.sectors!);
        if (user.sectors?.isNotEmpty ?? false) {
          for (int i in (user.sectors ?? <int>[])) {
            ticks[i - 1] = true;
          }
        } else {
          log('Hi');
        }
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void onAddToLikedFlagChanged(bool? val) {
    if (hp.mounted) {
      setState(() {
        addToLikedFlag = val;
      });
    }
  }

  void onTenantViewFlagChanged(bool? val) {
    if (hp.mounted) {
      setState(() {
        tenantViewFlag = val;
        log(tenantViewFlag);
        log('tenantviewflag');
        if (landlordViewFlag == true) {
          checkedLandlordFlag = false;
        } else {
          checkedLandlordFlag = tenantViewFlag ?? false;
        }
      });
    }
  }

  void onLandlordViewFlagChanged(bool? val) {
    if (hp.mounted) {
      setState(() {
        landlordViewFlag = val;
        log(tenantViewFlag);
        log('tenantViewFlag');
        checkedLandlordFlag = !(landlordViewFlag ?? false);
        if (tenantViewFlag == false) {
          checkedLandlordFlag = false;
        }
      });
    }
  }

  // void onFavouriteLandLordFlagChanged(bool? val) async {
  //   if (hp.mounted) {
  //     setState(() {
  //       favouriteLandLordFlag = val;
  //     });
  //     if (val ?? false) {
  //       final uv = await api.getFavouritelandLordData();
  //       if (await hp.showSimplePopup('OK', () {
  //             hp.goBack(result: true);
  //           }, type: AlertType.cupertino, action: uv.base.message) &&
  //           uv.base.success) {
  //         user = uv.user;
  //         setState(() {
  //           favouriteLandLordFlag = true;
  //         });
  //         fnc.text = uv.user.firstName;
  //         lnc.text = uv.user.lastName;
  //         emc.text = uv.user.userEmail;
  //         phc.text = uv.user.phoneNo;
  //         landLordMailFieldOnTap();
  //       } else {
  //         setState(() {
  //           favouriteLandLordFlag = false;
  //         });
  //         fnc.text = '';
  //         lnc.text = '';
  //         emc.text = '';
  //         phc.text = '';
  //       }
  //     } else {
  //       setState(() {
  //         favouriteLandLordFlag = val;
  //       });
  //       fnc.text = '';
  //       lnc.text = '';
  //       emc.text = '';
  //       phc.text = '';
  //     }
  //   }
  // }

  void emailOnChange(String? email) async {
    try {
      RegExp mailExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      final bc = otherFormKey.currentContext ??
          (state == null && states.isNotEmpty
              ? states.first.context
              : state!.context);
      final hp = Helper.of(bc);
      if (email != null && email.isNotEmpty && hp.mounted) {
        if (mailExp.hasMatch(email) && mailExp.allMatches(email).length == 1) {
          Loader.show(bc);
          final val = await api.checkValidMail(
              email, email == emc.text ? 4 : (email == tem.text ? 3 : 0));
          Loader.hide();
          final rp = val.base;
          if (rp.success && val.user.isNotEmpty) {
            hp.currentScope.unfocus();
            setState(() {
              fnc.text = val.user.firstName;
              lnc.text = val.user.lastName;
              phc.text = val.user.phoneNo;
            });
          }
          setState(() {
            if (val.user.isNotEmpty) {
              user1 = val.user;
            } else if (user1 != null) {
              user1 = null;
              fnc.text = '';
              lnc.text = '';
              phc.text = '';
            }
            emailFlag = rp.success;
            mailDesc = rp.message;
          });
        } else {
          fnc.text = '';
          lnc.text = '';
          phc.text = '';
          setState(() {
            emailFlag = false;
            if (user1 != null) {
              user1 = null;
            }
            mailDesc = 'Please Enter a Valid Email!!!';
          });
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
              ? 'Please Select An Address'
              : (error.contains('Connection') ? 'Server Error!!!!' : error),
          type: AlertType.cupertino,
          title: 'Error');
      if (f2) {
        log(e);
      }
    }
  }

  void tenantEmailOnChange(String? email) async {
    try {
      RegExp mailExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (email != null && email.isNotEmpty && hp.mounted) {
        if (mailExp.hasMatch(email) && mailExp.allMatches(email).length == 1) {
          final val = await api.checkValidMail(
              email, email == emc.text ? 4 : (email == tem.text ? 3 : 0));
          final rp = val.base;
          if (rp.success && val.user.isNotEmpty) {
            tfn.text = val.user.firstName;
            tln.text = val.user.lastName;
            tph.text = val.user.phoneNo;
          }
          setState(() {
            if (val.user.isNotEmpty) {
              user2 = val.user;
            }
            tenantEmailFlag = rp.success;
            tenantMailDesc = rp.message;
          });
        } else {
          tfn.text = '';
          tln.text = '';
          tph.text = '';
          setState(() {
            tenantEmailFlag = false;
            if (user2 != null) {
              user2 = null;
            }
            tenantMailDesc = 'Please Enter a Valid Email!!!';
          });
        }
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void onConfirmPassword() {
    setState(() {});
  }

  void onConfirmPasswordChanged(String? val) {
    setState(() {
      log(val);
    });
  }

  // Future<Reply> setFavLandLord() async {
  //   try {
  //     final item = await api.getFavouritelandLordData();
  //     user = item.user;
  //     // setState(() {
  //     fnc.text = item.user.firstName;
  //     lnc.text = item.user.lastName;
  //     emc.text = item.user.userEmail;
  //     phc.text = item.user.phoneNo;
  //     emailFieldOnTap();
  //     // });
  //     return item.base;
  //   } catch (e) {
  //     return Reply.emptyReply;
  //   }
  // }

  String? landLordPasswordValidator(String? password) {
    final passExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return password != null &&
            passExp.hasMatch(password) &&
            pwc.text == password
        ? null
        : (password != null &&
                pwc.text.isNotEmpty &&
                password.isNotEmpty &&
                passExp.hasMatch(password) &&
                passExp.hasMatch(pwc.text) &&
                pwc.text != password
            ? 'Password not matched!!'
            : 'Your password must be at least 10 characters \n\nYour password must contain at least 1 digit (i.e. 0-9) \n\n Your password must contain Uppercase');
  }

  String? tenantPasswordValidator(String? password) {
    final passExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return password != null &&
            passExp.hasMatch(password) &&
            tpw.text == password
        ? null
        : 'Password not matched!!';
  }

  void emailFieldOnTap() {
    if (emc.text.isNotEmpty) emailOnChange(emc.text);
  }

  void rememberMe(bool? value) async {
    final prefs = await sharedPrefs;
    log(value);
    final f = await ((value ?? false)
        ? prefs.setBool('rememberme', value ?? !rm)
        : prefs.remove('rememberme'));
    bool g = true, h = true;
    if (emc.text.isNotEmpty && pwc.text.isNotEmpty) {
      g = g && await prefs.setString('ruem', emc.text);
      h = h && await prefs.setString('rup', pwc.text);
    }
    if (hp.mounted && f && g && h) {
      setState(() {
        rm = value ?? !rm;
      });
    }
  }

  void getRememberMeValues() async {
    try {
      final prefs = await sharedPrefs;
      rm = prefs.containsKey('rememberme') &&
          (prefs.getBool('rememberme') ?? false);
      if (rm) {
        emc.text =
            prefs.containsKey('ruem') ? (prefs.getString('ruem') ?? '') : '';
        pwc.text =
            prefs.containsKey('rup') ? (prefs.getString('rup') ?? '') : '';
      }
      token = prefs.getString('spDeviceToken') ?? '';
      setState(() {});
    } catch (e) {
      sendAppLog(e);
    }
  }

  void waitForLogin() async {
    try {
      if (loginFormKey.currentState?.validate() ?? false) {
        final bc = loginFormKey.currentContext ??
            (state == null && states.isNotEmpty
                ? states.first.context
                : state!.context);
        final hp = Helper.of(bc);
        hp.currentScope.unfocus();
        Loader.show(bc);
        final value =
            await api.login({'username': emc.text, 'password': pwc.text});
        Loader.hide();
        final f2 = (value.base.success
            ? true
            : await hp.showSimplePopup('OK', () {
                hp.goBack(result: false);
              },
                type: AlertType.cupertino,
                title: 'Authentication Error!!',
                action: '${value.base.message}!!!!'));
        log(f2);
        log('bool');
        if (value.base.success && f2) {
          final prefs = await sharedPrefs;
          bool g = true, h = true;
          if (rm &&
              !(prefs.containsKey('ruem') ||
                  prefs.containsKey('rup') ||
                  emc.text.isEmpty ||
                  pwc.text.isEmpty) &&
              (prefs.getBool('rememberme') ?? false)) {
            g = g && await prefs.setString('ruem', emc.text);
            h = h && await prefs.setString('rup', pwc.text);
          }
          final p = await prefs.setString('User', value.user.toString()) &&
              await prefs.setInt('RoleID', value.user.role.roleID);
          final q = await api.addDevice({
            'registId': prefs.getString('spDeviceToken'),
            'device': defaultTargetPlatform.name,
            'userid': value.user.userID.toString(),
            'platform': defaultTargetPlatform.name
          });
          if (p && q.success && g && h) {
            hp.gotoForever('/mobile_home');
          } else {
            log(q.message);
          }
        } else {
          log(value.base.message);
        }
      } else {
        log('Hi');
      }
    } catch (e) {
      Loader.hide();
      sendAppLog(e);
    }
  }

  void carryOn(BuildContext context) async {
    if ((registerFormKey.currentState?.validate() ?? false) && ut != null) {
      final hp = Helper.of(registerFormKey.currentContext!);
      Map<String, dynamic> body = {
        'email': emc.text,
        'password': pwc.text == pcc.text ? pwc.text : '',
        'last_name': lnc.text,
        'first_name': fnc.text,
        'contact_no': phc.text,
        'contact_postcode': pc.text,
        'contact_address': location.value.addresses[flags.indexOf(true)],
        'usertype': (UserType.values.indexOf(ut!) + 1).toString()
      };
      if (ut == UserType.houseOwner) {
        waitUntilRegister(body, context);
      } else {
        hp.goTo('/register_contractor', args: RouteArgument(params: body));
      }
    }
  }

  void waitUntilRegister(
      Map<String, dynamic> body, BuildContext context) async {
    try {
      final hp = Helper.of(contractorDetailsFormKey.currentContext ??
          registerFormKey.currentContext!);
      log(body);
      Loader.show(context);
      final value = await api.register(body);
      Loader.hide();
      final f2 = await hp.revealDialogBox([
        'OK'
      ], [
        () {
          hp.goBack(result: true);
        }
      ],
          type: AlertType.cupertino,
          action:
              '${value.success ? 'Success' : 'Error'}!!!!!!\n\n${value.message}');
      f2 && value.success ? hp.gotoForever('/mobile_login') : log(title);
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }

  void waitUntilAddressObtained(String val, BuildContext context) async {
    // try {
    //   location.value = PinCodeResult.emptyResult;
    //   final value = await api.getAddresses({'postcode': val});
    //   location.value = value;
    //   if (location.value.addresses.isNotEmpty) {
    //     flags = List<bool>.filled(location.value.addresses.length, false);
    //   }
    // } catch (e) {
    // }

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
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }

  void waitUntilProfileUpdate(User user) async {
    try {
      if (editProfileFormKey.currentState!.validate()) {
        Map<String, dynamic> body = {
          'user_id': user.userID.toString(),
          'email': emc.text,
          'first_name': fnc.text,
          'last_name': lnc.text,
          'contact_no': phc.text,
          'contact_postcode': pc.text,
          'contact_address': adc.text,
          'usertype': ((user.role.roleID - 1) / 2).toString(),
          'password': pwc.text == pcc.text ? pwc.text : ''
        };

        if (user.role.roleID == 5) {
          body['companyname'] = compNa.text;
          body['companytel'] = compNo.text;
          body['companyregno'] = compRegNo.text;
        }
        if (user.role.roleID == 5) {
          int k = 0;
          for (bool i in ticks) {
            final index = ticks.indexOf(i, k);
            if (i && !selectedIndices.contains(index)) {
              selectedIndices.add(index);
              k = index + 1;
            } else {
              ++k;
            }
          }
          selectedIndices.sort();
          for (int i in selectedIndices) {
            final val = (i + 1).toString();
            if (!selected.contains(val)) {
              selected.add(val);
            }
          }
          body['sectors'] = selected;
        }
        final bc = editProfileFormKey.currentContext ??
            (state == null && states.isNotEmpty
                ? states.first.context
                : state!.context);
        final hp = Helper.of(bc);
        Loader.show(bc);
        final f = await api.updateUserDetails(body);
        Loader.hide();
        final f2 = await hp.showDialogBox(
          title: Text(
            f ? 'Success!' : 'Failure!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          content:
              Text(f ? 'User Updated Successfully.' : 'Error Updating Profile'),
          type: AlertType.cupertino,
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                hp.goBack();
                if (f) {
                  hp.notifyLocation();
                  hp.goBack();
                }
              },
            ),
          ],
        );
        if (f2 ?? false) {
          log('test');
        } else {
          log(body);
        }
      }
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }

  void waitUntilAddOtherUser(Map<String, dynamic> body) async {
    try {
      if (otherFormKey.currentState!.validate() && pwc.text == pcc.text) {
        Map<String, dynamic> map = body;
        map['password'] = pcc.text;
        map['last_name'] = lnc.text;
        map['first_name'] = fnc.text;
        map['phone'] = phc.text;
        map['email'] = emc.text;
        final bc = otherFormKey.currentContext ??
            (state == null && states.isNotEmpty
                ? states.first.context
                : state!.context);
        final hp = Helper.of(bc);
        Loader.show(bc);
        final val = await api.addPropertyForOther(map);
        Loader.hide();
        if (val.reply.success) {
          hp.goBackForeverTo('/mobile_home');
        }
      }
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }

  void waitUntilResetPassword(BuildContext context) async {
    try {
      if (resetPasswordFormKey.currentState!.validate()) {
        final bc = otherFormKey.currentContext ??
            (state == null && states.isNotEmpty
                ? states.first.context
                : state!.context);
        final hp = Helper.of(bc);
        Loader.show(bc);
        final val = await api.resetPassword({'email': emc.text});
        Loader.hide();
        final f2 = await hp.showSimplePopup('OK', () {
          hp.goBack(result: true);
        },
            action: val.message,
            type: AlertType.cupertino,
            title: val.success ? 'Success' : 'Oops!');

        if (f2 && val.success) {
          hp.goBack();
        }
      }
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }

  void waitUntilInstallerRegister(
      Map<String, dynamic> body, BuildContext context) {
    int k = 0;
    Map<String, dynamic> map = body;
    for (bool i in ticks) {
      /*final index = flags.indexOf(i, k);*/
      final index = ticks.indexOf(i, k);
      if (i && !selectedIndices.contains(index)) {
        selectedIndices.add(index);
        k = index + 1;
      } else {
        ++k;
      }
    }
    selectedIndices.sort();
    for (int i in selectedIndices) {
      final val = (i + 1).toString();
      if (!selected.contains(val)) {
        selected.add(val);
      }
    }
    log(selected);
    map['companyname'] = cnc.text;
    map['companytel'] = phCc.text;
    map['companyregno'] = crc.text;
    map['sectors'] = selected;
    waitUntilRegister(map, context);
  }

  void passwordFieldOnTap() {
    log('focused');
    suggestPassword = pwc.text.isEmpty;
    setState(passwordGeneration);
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

  void tenantPasswordFieldOnTap() {
    suggestPassword = tpw.text.isEmpty;
    setState(passwordGeneration);
  }

  void passwordValidation3(String password) {
    if (hp.passwordValidstructure(password) == null) {
      log('truth');
    } else {
      newPassword3 = hp.generatePassword(true, true, true, true, 10);
      passwordValidation3(newPassword3);
    }
  }

  void disableSuggestPassword() {
    setState(() {
      suggestPassword = false;
    });
  }

  void waitUntillAddLandLord(Map<String, dynamic> map) async {
    bool typeCriteria(PropertyType element) {
      return element.typeID == int.tryParse(map['property_type'].toString());
    }

    try {
      final body = Map<String, dynamic>.from(map);
      body['tenant_view_access'] = tenantViewFlag;
      body['landlord_favorite'] = addToLikedFlag ?? false;
      body['landlord_favorite_view'] = favouriteLandLordFlag;
      if (fnc.text.isNotEmpty) {
        body['landlord_first_name'] = fnc.text;
      }
      log(body);
      if (lnc.text.isNotEmpty) {
        body['landlord_last_name'] = lnc.text;
      }
      log(body);
      if (emc.text.isNotEmpty) {
        body['landlord_email'] = emc.text;
      }
      log(body);
      if (phc.text.isNotEmpty) {
        body['landlord_phone'] = phc.text;
      }
      log(body);
      body['landlord_password'] = pwc.text;
      log(body);
      final bc = otherFormKey.currentContext ??
          (state == null && states.isNotEmpty
              ? states.first.context
              : state!.context);
      final hp = Helper.of(bc);
      if (tenantViewFlag ?? false) {
        hp.goTo('/add_tenant', args: RouteArgument(params: body));
      } else {
        Loader.show(bc);
        final rp = await api.addLandLord(body);
        Loader.hide();
        final p = await hp.showSimplePopup('OK', () {
          hp.goBack(result: true);
        }, action: rp.message, type: AlertType.cupertino);
        if (rp.success && p) {
          final val = (await api.getPropertyTypes()).firstWhere(typeCriteria);
          log(val);
          hp.goTo('/add_property_success',
              args: RouteArgument(params: {
                'address': body['address'],
                'type': val.type,
                'correctDate': body['purchased_date']
                    .toString()
                    .split('-')
                    .reversed
                    .join('/')
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

  void addLandlordWithTenant(Map<String, dynamic> map) async {
    bool typeCriteria(PropertyType element) {
      return element.typeID == int.tryParse(map['property_type'].toString());
    }

    try {
      final body = Map<String, dynamic>.from(map);
      if (tfn.text.isNotEmpty) {
        body['tenant_first_name'] = tfn.text;
      }
      log(body);
      if (tln.text.isNotEmpty) {
        body['tenant_last_name'] = tln.text;
      }
      log(body);
      if (tem.text.isNotEmpty) {
        body['tenant_email'] = tem.text;
      }
      log(body);
      if (tph.text.isNotEmpty) {
        body['tenant_phone'] = tph.text;
      }
      log(body);
      body['tenant_password'] = tpw.text;
      log(body);
      final bc = tenantFormKey.currentContext ??
          (state == null && states.isNotEmpty
              ? states.first.context
              : state!.context);
      final hp = Helper.of(bc);
      Loader.show(bc);
      final rp = await api.addLandLord(body);
      Loader.hide();
      final p = await hp.showSimplePopup('OK', () {
        hp.goBack(result: true);
      }, action: rp.message, type: AlertType.cupertino);
      if (rp.success && p) {
        final val = (await api.getPropertyTypes()).firstWhere(typeCriteria);
        log(val);
        hp.goTo('/add_property_success',
            args: RouteArgument(params: {
              'address': body['address'],
              'type': val.type,
              'correctDate': body['purchased_date']
                  .toString()
                  .split('-')
                  .reversed
                  .join('/')
            }));
      }
    } catch (e) {
      sendAppLog(e);
      if (Loader.isShown) Loader.hide();
    }
  }
}
