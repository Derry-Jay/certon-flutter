import '../helpers/helper.dart';
import '../widgets/logo_widget.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/web/bottom_widget.dart';
import '../widgets/web/benefit_grid_widget.dart';
import 'package:global_configuration/global_configuration.dart';

class OtherDataPage extends StatefulWidget {
  final String title;
  const OtherDataPage({Key? key, required this.title}) : super(key: key);

  @override
  OtherDataPageState createState() => OtherDataPageState();
}

class OtherDataPageState extends State<OtherDataPage> {
  List<String> actions = <String>[
        'About Us',
        'What is CertOn',
        'CertOn HUB',
        'CertOn PRO',
        'Benefits',
        'News',
        'Contact'
      ],
      drop = <String>['How Does it Work?', 'Pricing', 'Mobile App'];

  List<bool> actionTexts = <bool>[], flags = <bool>[];

  bool actionMode = false;

  int index = 0;

  TextEditingController sc = TextEditingController(),
      nc = TextEditingController(),
      phc = TextEditingController(),
      emc = TextEditingController(),
      mc = TextEditingController();

  Widget mapActions(String e) {
    void allocateVal() {
      index = actions.indexOf(e);
      flags[index] = !flags[index];
      actionMode = flags.contains(true);
    }

    void assignVal() {
      actionTexts[index] = !actionTexts[index];
    }

    void allotVal() {
      setState(allocateVal);
    }

    void setVal(PointerEvent event) async {
      log(event);
      index = actions.indexOf(e);
      // if (index == 2 || index == 3) {
      //   final word = await showMenus();
      //   log(word);
      // }
      setState(assignVal);
    }

    void onEnter(PointerEnterEvent event) async {
      setVal(event);
    }

    void onExit(PointerExitEvent event) {
      // if(!(context.findRenderObject()!.debugDisposed ?? true)) {
      //   context.findRenderObject()!.dispose();
      // }
      setVal(event);
    }

    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: onEnter,
        onExit: onExit,
        child: GestureDetector(
            onTap: allotVal,
            child: Padding(
                padding:
                    EdgeInsets.only(top: hp.height / 32, right: hp.width / 100),
                child: Text(e,
                    style: TextStyle(
                        color: actionTexts[actions.indexOf(e)]
                            ? Colors.grey
                            : Colors.black)))));
  }

  PopupMenuEntry<String> mapDrop(String e) =>
      PopupMenuItem(value: e, child: Text(e));

  Helper get hp => Helper.of(context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flags = List.filled(actions.length, false);
    actionTexts = List.filled(actions.length, false);
    actionMode = flags.contains(true);
  }

  @override
  Widget build(BuildContext context) {
    final title = SelectableText(
        actionMode ? actions[flags.indexOf(actionMode)] : widget.title,
        style: TextStyle(
            fontSize: hp.height / 20,
            fontWeight: FontWeight.w900,
            color: hp.theme.primaryColor));
    final data = title.data ?? '';
    int index = actions.indexOf(data);
    log(index);
    log(data);
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          bottomNavigationBar: BottomWidget(
              heightFactor: actionMode && index == 6 ? 12.8 : 10),
          appBar: AppBar(
              actions: actions.map(mapActions).toList(),
              leading: GestureDetector(
                  child: const LogoWidget(heightFactor: 3.2, widthFactor: 80),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              leadingWidth: hp.width / 10,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0),
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: hp.width / 32),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                title,
                actionMode && index == 5
                    ? Image.asset('${GlobalConfiguration()
                            .getValue<String>('asset_image_path')}technology_1-600x291.jpg')
                    : const EmptyWidget(),
                actionMode && index == 4
                    ? BenefitGridWidget(items: gridItems)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Expanded(
                                child: SelectableText(actionMode
                                    ? (index == 0
                                        ? '\nWe are an online document management company that was founded from many years experience in the new build property sector, issuing and producing certificates & manuals - we launched CertOn in 2018.\n\n\n Our goal is to save people time, improve safety and show compliance in all properties, for all users.\n\n\n  The idea from the outset with CertOn was to be able to find any important property document at any location in a building, instantly.'
                                        : (index == 1
                                            ? "CertOn is a paperless document management system that helps tradespeople, homeowners, housing associations, construction, landlords, compliance and maintenance teams.\nPretty much anyone involved in property can upload and access all important property documents instantly.\n\nLink the PDF or JPEG documents to a unique QR code specific to your building and using an App and website portal to help manage your documents.\n\nSpot the CertOn QR code and you'll know that previously signed off and certified documentation and manuals are instantly ready to view. Unique QR Code stickers can be attached anywhere in a property, fuse boards, boilers, alarm panels, wherever is deemed necessary.\n\nKeeping those all-important documents, safe and secure, easily accessed on your smart phone or tablet.\n\nFor a smart, paperless way to easily access your property documents, you can be certain with CertOn."
                                            : (index == 6
                                                ? '\nCertOn\n77 Marlowes, \nHemel Hempstead, \nHertfordshire, \nHP1 1LF'
                                                : (index == 5
                                                    ? 'Technology Focus: CertOn | Creating a golden thread – LABM March/April 2021 issue Being able to demonstrate compliance and offer full transparency of data on a building project is hugely important,… […]'
                                                    : ''))))
                                    : (data == 'Terms and Conditions'
                                        ? "\n\nPosted: 1st March 2019\n\nEffective: 1st March 2019\n\nThank you for using Certon. These Terms and Conditions of Service (“Terms”) cover your use of and access to our services, client software (including apps) and websites (“Services“). Our Privacy Policy explains how we collect and use your information while our Acceptable Use Policy outlines your responsibilities when using our Services. By using our Services, you're agreeing to be bound by these Terms, our Privacy Policy and our Acceptable Use Policy . If you're using our Services for an organisation, you're agreeing to these Terms on behalf of that organisation."
                                        : (data == 'Privacy Policy'
                                            ? '\nWe Respect Your Privacy\n\nThis privacy policy applies to the website of:\n\nCertOn Ltd\n77 Marlowes,\nHemel Hempstead,\nHertfordshire,\nUnited Kingdom,\nHP1 1LF\nTel: 07944 017168\n\nPlease take the time to review this document. Any changes we may make to this policy will be posted on this page.\n\nWe will collect and process information in accordance with the following policies:'
                                            : (data == 'Acceptable Use Policy'
                                                ? '\nCerton is used by professionals and consumers and we rely on our position of trust. In exchange, we trust you to use our services responsibly.\n\nYou agree not to misuse the Certon services (“Services”) or help anyone else to do so.'
                                                : ''))))),
                            Expanded(
                                child: Visibility(
                                    visible: actionMode && index == 6,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SelectableText('Your Name*'),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: hp.height / 32),
                                              child: TextFormField(
                                                  validator: nameValidator,
                                                  controller: nc,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder()))),
                                          const SelectableText(
                                              'Your Phone Number*'),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: hp.height / 32),
                                              child: TextFormField(
                                                  validator:
                                                      phoneNumberValidator,
                                                  controller: phc,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder()))),
                                          const SelectableText('Your Email*'),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: hp.height / 32),
                                              child: TextFormField(
                                                  validator:
                                                      hp.emailValidator,
                                                  controller: emc,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder()))),
                                          const SelectableText(
                                              'Your Subject*'),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: hp.height / 32),
                                              child: TextFormField(
                                                  validator: nameValidator,
                                                  controller: sc,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder()))),
                                          const SelectableText(
                                              'Your Message*'),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: hp.height / 32),
                                              child: TextFormField(
                                                  validator: nameValidator,
                                                  controller: mc,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder()))),
                                        ])))
                          ])
              ]))),
    );
  }
}
