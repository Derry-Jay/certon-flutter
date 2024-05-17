import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/my_labelled_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends StateMVC<ForgotPasswordScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);
  ForgotPasswordScreenState() : super(UserController()) {
    con = controller as UserController;
  }
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          bottomNavigationBar: const BottomWidget(),
          body: Form(
              key: con.resetPasswordFormKey,
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: hp.width / 20, vertical: hp.height / 40),
                  child: Column(
    
                    children: [
                      const SizedBox(height: 5),
    
                      Container(
                        alignment: Alignment.topLeft,
                        child:
                        const Text(
                            'Email Address',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17), textScaleFactor: 1.0
                        ),
                      ),
    
                      const SizedBox(height: 5),
                      Container(
                          height: hp.height / 8,
                          padding: EdgeInsets.only(
                              top: hp.height / 100, bottom: hp.height / 100),
                          child: TextFormField(
                              controller: con.emc,
                              validator: hp.emailValidator,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: hp.height / 100,
                                      horizontal: hp.width / 40),
                                  border: const OutlineInputBorder(),
                                  hintText: 'Email Address'))),
                      MyLabelledButton(
                          type: ButtonType.text,
                          label: 'Send',
                          onPressed: () {
                            con.waitUntilResetPassword(context);
                          })
                    ],
                  ))),
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Forgot Password',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }
}
