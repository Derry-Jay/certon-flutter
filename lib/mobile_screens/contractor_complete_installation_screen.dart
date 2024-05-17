import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/mobile/bottom_widget.dart';

class ContractorCompleteInstallationScreen extends StatefulWidget {
  final RouteArgument rar;
  const ContractorCompleteInstallationScreen({Key? key, required this.rar})
      : super(key: key);

  @override
  ContractorCompleteInstallationScreenState createState() =>
      ContractorCompleteInstallationScreenState();
}

class ContractorCompleteInstallationScreenState
    extends StateMVC<ContractorCompleteInstallationScreen> {
  late UserController con;
  Helper get hp => Helper.of(context);
  bool compnameFlag = false;
  bool compnoFlag = false;
  bool compidFlag = false;
  bool sectoridFlag = false;
  ContractorCompleteInstallationScreenState() : super(UserController()) {
    con = controller as UserController;
  }

  Widget getItemBuilder(BuildContext context, int index) {
    void onChanged(bool? val) {
      setState(() => con.ticks[index] = val ?? false);
    }

    return Row(
      children: [
        Text(con.sectors[index]),
        Checkbox(value: con.ticks[index], onChanged: onChanged)
      ],
    );
  }

  Widget getCheckBoxBuilder(BuildContext context, int index) {
    final hpc = Helper.of(context);
    void onChanged(bool? val) {
      setState(() {
        con.ticks[index] = val ?? false;
        if (con.ticks.contains(true)) {
          sectoridFlag = false;
        } else {
          sectoridFlag = true;
        }
      });
    }

    log(hpc.size.shortestSide);
    return Row(children: [
      // Expanded(child: Text(hpc.sectors[index])),
      Expanded(
          flex: hpc.size.shortestSide < 400 ? 2 : 1,
          child: (con.ticks[index] == true)
              ? Text(
                  sectors[index],
                  style: const TextStyle(fontSize: 15, color: Colors.blue),
                )
              : Text(
                  sectors[index],
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                )),
      Expanded(child: Checkbox(value: con.ticks[index], onChanged: onChanged))
    ]);
  }

  Widget sectorField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: compnameFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: compnameFlag,
              child: Text(
                con.cnc.text.isEmpty
                    ? 'Enter Company Name'
                    : con.cnc.text.length > 4
                        ? ''
                        : 'Minimum 4 characters length',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget companyNameField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: compnameFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                // maxLength: 100,
                // maxLengthEnforcement: MaxLengthEnforcement.none,
                controller: con.cnc,
                onChanged: (String val) {
                  if (RegExp('\\s+').hasMatch(con.compNa.text)) {
                    con.cnc.text = val.replaceAll(RegExp('\\s+'), ' ');
                  }
                  // con.cnc.selection = TextSelection.collapsed(
                  //     offset: con.compNa.text.length);
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  // FilteringTextInputFormatter.deny(
                  //     RegExp(r'[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]')),
                  FilteringTextInputFormatter(
                      RegExp(
                          '[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]'),
                      allow: false)
                ],
                // validator: hp.nameValidator,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Company Name')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: compnameFlag,
              child: Text(
                con.cnc.text.isEmpty
                    ? 'Enter Company Name'
                    : con.cnc.text.length > 4
                        ? ''
                        : 'Minimum 4 characters length',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ));
  }

  Widget companyNumberField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: compnoFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: con.phCc,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15),
                  FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),
                ],
                onChanged: (String val) {
                  if (phoneNumberValidator(val) != null) {
                    log(phoneNumberValidator(val));
                    compnoFlag = true;
                  } else {
                    compnoFlag = false;
                  }
                  if (phoneNumberValidator(val) == null) {
                    compnoFlag = false;
                  } else {
                    compnoFlag = true;
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Company Number')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: compnoFlag,
              child: Text(
                con.phCc.text.isEmpty
                    ? 'Please provide a Company telephone number'
                    : (phoneNumberValidator(con.phc.text) != null)
                        ? 'Invalid Format'
                        : '',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: hp.size.shortestSide < 400 ? 12.8 : 16),
              ),
            )
          ],
        ));
  }

  Widget companyregNoField() {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        height: compidFlag ? 80 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                // maxLength: 100,
                // maxLengthEnforcement: MaxLengthEnforcement.none,
                controller: con.crc,
                onChanged: (String val) {
                  if (val.isNotEmpty) {
                    compidFlag = false;
                  } else {
                    compidFlag = true;
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: hp.height / 100, horizontal: hp.width / 40),
                    border: const OutlineInputBorder(),
                    hintText: 'Company Registration No')),
            const SizedBox(
              height: 5,
            ),
            Visibility(
              visible: compidFlag,
              child: Text(
                con.crc.text.isEmpty
                    ? 'Please provide a Company registration number'
                    : '',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: hp.size.shortestSide < 400 ? 12.8 : 16),
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
        onPressed: () {
          if (con.cnc.text.isEmpty) {
            compnameFlag = true;
          } else {
            compnameFlag = false;
          }

          if (con.phCc.text.isEmpty) {
            compnoFlag = true;
          } else {
            compnoFlag = false;
          }

          if (con.crc.text.isEmpty) {
            compidFlag = true;
          } else {
            compidFlag = false;
          }
          if (con.ticks.contains(true)) {
            sectoridFlag = false;
          } else {
            sectoridFlag = true;
          }

          if (compnoFlag == false &&
              compnameFlag == false &&
              compidFlag == false &&
              con.ticks.contains(true)) {
            con.waitUntilInstallerRegister(widget.rar.params, context);
          }
          setState(() {});
        },

        style: ElevatedButton.styleFrom(
          primary: hp.theme.primaryColor,
        ), //ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(hp.theme.primaryColor)),
        child: const Text(
          'Complete Registration',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
      // padding: EdgeInsets.only(
      //     top: hp.height / 100, bottom: hp.height / 100)
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          bottomNavigationBar: const BottomWidget(),
          body: Form(
              key: con.contractorDetailsFormKey,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Register Your Account',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: hp.height / 50),
                            child: const Text('Add Some More Details',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal))),
                        companyNameField(),
                        // Container(
                        //     // color: Colors.amber,
                        //     height: 50,
                        //     padding: const EdgeInsets.only(top: 5, bottom: 5),
                        //     child: TextFormField(
                        //         // maxLength: 100,
                        //         // maxLengthEnforcement: MaxLengthEnforcement.none,
                        //         controller: con.cnc,
                        //         onChanged: (String val) {
                        //           if (RegExp('\\s+').hasMatch(con.compNa.text)) {
                        //             con.cnc.text =
                        //                 val.replaceAll(RegExp('\\s+'), ' ');
                        //           }
                        //           // con.cnc.selection = TextSelection.collapsed(
                        //           //     offset: con.compNa.text.length);
                        //         },
                        //         inputFormatters: [
                        //           LengthLimitingTextInputFormatter(30),
                        //           // FilteringTextInputFormatter.deny(
                        //           //     RegExp(r'[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]')),
                        //           FilteringTextInputFormatter(
                        //               RegExp(
                        //                   '[\\.|\\,|\\;|\\:|\\"|\\\'|\\?|\\/|\\{|\\}|\\[|\\]]|\\~|\\`|\\!|\\@|\\#|\\\$|\\%|\\^|\\&|\\*|\\(|\\)|\\_|\\-|\\+|\\=|\\<|\\>|\\||\\£|\\¥|\\§|\\s*]'),
                        //               allow: false)
                        //         ],
                        //         // validator: hp.nameValidator,
                        //         decoration: InputDecoration(
                        //             contentPadding: EdgeInsets.symmetric(
                        //                 vertical: hp.height / 100,
                        //                 horizontal: hp.width / 40),
                        //             border: const OutlineInputBorder(),
                        //             hintText: 'Company Name'))),

                        // Container(
                        //     // color: Colors.amber,
                        //     height: 50,
                        //     padding: const EdgeInsets.only(top: 5, bottom: 5),
                        //     child: TextFormField(
                        //         keyboardType: TextInputType.phone,
                        //         controller: con.phCc,
                        //         // validator: hp.nameValidator,
                        //         decoration: InputDecoration(
                        //             contentPadding: EdgeInsets.symmetric(
                        //                 vertical: hp.height / 100,
                        //                 horizontal: hp.width / 40),
                        //             border: const OutlineInputBorder(),
                        //             hintText: 'Company Number'))),
                        companyNumberField(),
                        companyregNoField(),
                        // Container(
                        //     // color: Colors.amber,
                        //     height: 50,
                        //     padding: const EdgeInsets.only(top: 5, bottom: 5),
                        //     child: TextFormField(
                        //         controller: con.crc,
                        //         // validator: hp.nameValidator,
                        //         decoration: InputDecoration(
                        //             contentPadding: EdgeInsets.symmetric(
                        //                 vertical: hp.height / 100,
                        //                 horizontal: hp.width / 40),
                        //             border: const OutlineInputBorder(),
                        //             hintText: 'Company Registration No'))),
                        const SizedBox(
                          height: 25,
                        ),
                        // SizedBox(
                        //     height: hp.height / 8,
                        //     child: TextFormField(
                        //         controller: con.cnc,
                        //         validator: companyNameValidator,
                        //         decoration: const InputDecoration(
                        //             border: OutlineInputBorder(),
                        //             hintText: 'Company Name'))),
                        // Container(
                        //     height: hp.height / 8,
                        //     padding: EdgeInsets.only(
                        //         top: hp.height / 100, bottom: hp.height / 64),
                        //     child: TextFormField(
                        //         controller: con.phCc,
                        //         validator: phoneNumberValidator,
                        //         decoration: const InputDecoration(
                        //             border: OutlineInputBorder(),
                        //             hintText: 'Company Telephone Number'))),
                        // Container(
                        //     height: hp.height / 8,
                        //     padding: EdgeInsets.only(
                        //         top: hp.height / 50, bottom: hp.height / 64),
                        //     child: TextFormField(
                        //         controller: con.crc,
                        //         // validator: phoneNumberValidator,
                        //         decoration: const InputDecoration(
                        //             border: OutlineInputBorder(),
                        //             hintText: 'Company Registration Number'))),
                        Padding(
                            padding: EdgeInsets.only(bottom: hp.height / 500),
                            child: const Center(
                                child: Text('Sectors',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18)))),
                        SizedBox(
                            height: con.sectors.length *
                                (hp.isTablet ? 40 : (hp.isMobile ? 32 : 20)),
                            child: GridView.builder(
                                shrinkWrap: true,
                                // padding: const EdgeInsets.only(
                                //     top:
                                //         0), //EdgeInsets.only(top: hp.height / 64),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:
                                            hp.width / (hp.height / 6.4),
                                        crossAxisCount: 2),
                                itemBuilder: getCheckBoxBuilder,
                                itemCount: con.sectors.length)),
                        // SizedBox(
                        //     height: (hp.height * con.sectors.length) / 25,
                        //     child: GridView.builder(
                        //         shrinkWrap: true,
                        //         padding: EdgeInsets.only(bottom: hp.height / 40),
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         gridDelegate:
                        //             SliverGridDelegateWithFixedCrossAxisCount(
                        //                 childAspectRatio: hp.height / hp.width,
                        //                 crossAxisCount: 2),
                        //         itemBuilder: getItemBuilder,
                        //         itemCount: con.sectors.length)),
                        const SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: sectoridFlag,
                          child: Text(
                            'Please select a sector',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize:
                                    hp.size.shortestSide < 400 ? 12.8 : 16),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        finishButton(),
                        // MyLabelledButton(
                        //     type: ButtonType.text,
                        //     label: 'Register',
                        //     onPressed: () {
                        //       con.waitUntilInstallerRegister(widget.rar.params, context);
                        //     })
                      ]))),
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('Register',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   hp.getConnectStatus();
  //   hp.signOutIfAnyChanges();
  // }
}
