import 'package:flutter/foundation.dart';
import '../widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../widgets/mobile/bottom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends StateMVC<LoginScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);
  LoginScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  Widget emailField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0, left: 0, right: 0),
        height: hp.width > 350
            ? (con.emailFlag ? 79 : 64)
            : (con.emailFlag ? 69 : 54),
        width: hp.isTablet ? 300 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                style: hp.width > 350
                    ? const TextStyle()
                    : const TextStyle(
                        fontSize: 16.0, height: 1.25, color: Colors.black),
                controller: con.emc,
                onChanged: (textLabel) {
                  con.emailFlag = textLabel.isEmpty;
                  emailField();
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    isDense: hp.width > 350 ? false : true,
                    // suffixIcon: (con.pwc.text.isNotEmpty) ? passwordFlag ? const Icon(Icons.cancel,color: Colors.red,) : const Icon(Icons.check, color: Colors.green,) : null,
                    // suffixIconColor: Colors.red,
                    contentPadding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 25),
                    // EdgeInsets.symmetric(
                    //     vertical: hp.height/100, horizontal: hp.width/40),
                    border: const OutlineInputBorder(),
                    hintText: 'Email Address')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: con.emailFlag,
              child: Text(
                con.emc.text.isEmpty ? 'Username is required' : '',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget passwordField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, left: 0, right: 0),
        height: hp.width > 350
            ? (con.passwordFlag
                ? con.pwc.text.isEmpty
                    ? 79
                    : 149
                : 64)
            : (con.passwordFlag
                ? con.pwc.text.isEmpty
                    ? 69
                    : 139
                : 54),
        width: hp.isTablet ? 300 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                style: hp.width > 350
                    ? const TextStyle()
                    : const TextStyle(
                        fontSize: 16.0, height: 1.25, color: Colors.black),
                obscureText: true,
                controller: con.pwc,
                onChanged: (textLabel) {
                  con.passwordFlag = textLabel.isEmpty;
                  passwordField();
                },
                // validator: hp.passwordValidator,
                decoration: InputDecoration(
                    isDense: hp.width > 350 ? false : true,
                    contentPadding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 25),
                    // suffixIconColor: Colors.red,
                    // contentPadding: EdgeInsets.symmetric(
                    //     vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Password')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: con.passwordFlag,
              child: Text(
                con.pwc.text.isEmpty ? 'Password is required' : '',
                // :
                //   hp.passwordValidstructure(con.pwc.text) ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget buttonBuilder(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 110,
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              con.emailFlag = con.emc.text.isEmpty;
              con.passwordFlag = con.pwc.text.isEmpty;
            });
            if (!(con.emailFlag || con.passwordFlag)) {
              con.waitForLogin();
            }
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(hp.theme.primaryColor)),
          child: const Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    con.getRememberMeValues();
  }

  @override
  Widget build(BuildContext context) {
    log(hp.height);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Login',
                style: TextStyle(
                    fontSize: hp.isMobile ? (hp.height > 850 ? 18 : 16) : 22),
              ),
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor),
          bottomNavigationBar: const BottomWidget(),
          body: SingleChildScrollView(
              // primary: true,
              // padding: hp.isMobile
              //     ? EdgeInsets.symmetric(horizontal: hp.width / 10)
              //     : EdgeInsets.symmetric(
              //         horizontal: hp.width / 10, vertical: hp.height / 5),
              padding: EdgeInsets.symmetric(
                  horizontal: hp.width / 10,
                  vertical: hp.isMobile ? 0 : hp.height / 5),
              child: Form(
                  key: con.loginFormKey,
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                              visible: kProfileMode,
                              child: SelectableText(con.token)),
                          const LogoWidget(),
                          // Container(
                          //     height: hp.height / 8.192,
                          //     padding: EdgeInsets.only(top: hp.height / 50),
                          //     child: TextFormField(
                          //         textInputAction: TextInputAction.next,
                          //         controller: emc,
                          //         validator: hp.emailValidator,
                          //         decoration: InputDecoration(
                          //             contentPadding: EdgeInsets.symmetric(
                          //                 vertical: hp.height / 100,
                          //                 horizontal: hp.width / 40),
                          //             border: const OutlineInputBorder(),
                          //             hintText: 'Email Address'))),
                          // SizedBox(
                          //     height: hp.height / 7.0368744177664,
                          //     child: TextFormField(
                          //         textInputAction: TextInputAction.done,
                          //         obscureText: true,
                          //         controller: pwc,
                          //         validator: hp.passwordValidator,
                          //         decoration: InputDecoration(
                          //             contentPadding: EdgeInsets.symmetric(
                          //                 vertical: hp.height / 100,
                          //                 horizontal: hp.width / 40),
                          //             border: const OutlineInputBorder(),
                          //             hintText: 'Password'))),
                          emailField(),
                          SizedBox(
                            height: hp.width > 375 ? 10 : 7,
                          ),
                          passwordField(),
                          SizedBox(
                            height: hp.width > 375 ? 40 : 20,
                          ),
                          buttonBuilder(context),
                          // MyLabelledButton(type: ButtonType.text, label: 'Sign In',
                          //         onPressed: () async {
                          //           Map<String, dynamic> body = {
                          //             'username': emc.text,
                          //             'password': pwc.text
                          //           };
                          //           con.waitForLogin(body);
                          //         }),
                          Container(
                            padding: EdgeInsets.only(
                                top: hp.height / 50,
                                bottom: hp.width > 375 ? 20 : 10,
                                left: 30,
                                right: 30),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      value: con.rm, onChanged: con.rememberMe),
                                  const Text('Remember me'),
                                ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              hp.goTo('/forgot_password');
                            },
                            child: const SizedBox(
                              height: 35,
                              child: Text(
                                'Forgot your password?',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              hp.goTo('/register');
                            },
                            child: const SizedBox(
                              height: 35,
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                          // HyperLinkText(
                          //     text: 'Forgot your password?',
                          //     onTap: () {
                          //       hp.goTo('/forgot_password');
                          //     }),
                          // HyperLinkText(
                          //     text: 'Register Now',
                          //     onTap: () {
                          //       hp.goTo('/register');
                          //     })
                        ]),
                  )))),
    );
  }
}
