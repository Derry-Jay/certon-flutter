import '../helpers/helper.dart';
import '../widgets/logo_widget.dart';
import '../widgets/web/bottom_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool checked = false;
  Helper get hp => Helper.of(context);
  List<String> fields = ['Email', 'Password'];
  List<TextEditingController> tecs = [
    TextEditingController(),
    TextEditingController()
  ];
  Widget mapFields(String e) {
    bool flag = e == fields.first;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Flexible(child: SelectableText(e, style: hp.theme.textTheme.headline6)),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(
                  top: flag ? 0 : hp.height / 100,
                  bottom: flag ? hp.height / 100 : 0),
              child: TextFormField(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  controller: tecs[fields.indexOf(e)])))
    ]);
  }

  void onChanged(bool? flag) {
    checked = flag ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: const BottomWidget(heightFactor: 20),
            body: Center(
                child: Form(
                    child: SingleChildScrollView(
                        child: Column(children: [
              SelectableText('Login With CertOn HUB Now',
                  style: hp.theme.textTheme.headline6),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: hp.height / 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: fields.map(mapFields).toList(),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Checkbox(value: checked, onChanged: onChanged),
                GestureDetector(
                    onTap: () {
                      onChanged(!checked);
                    },
                    child: const Text('Remember Me'))
              ]),
              Padding(
                  padding: EdgeInsets.only(top: hp.height / 40),
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Login', style: hp.theme.textTheme.button)))
            ])))),
            appBar: AppBar(
                leadingWidth: hp.width / 10,
                elevation: 0,
                backgroundColor: hp.theme.scaffoldBackgroundColor,
                foregroundColor: hp.theme.secondaryHeaderColor,
                leading:
                    const LogoWidget(heightFactor: 1.28, widthFactor: 10))));
  }
}
