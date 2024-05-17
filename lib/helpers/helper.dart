import 'dart:math';
import 'utils.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import '../backend/api.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import '../widgets/loader.dart';
import '../models/document.dart';
import '../models/property.dart';
import '../models/quick_link.dart';
import '../../generated/l10n.dart';
import '../widgets/empty_widget.dart';
import '../widgets/custom_loader.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import '../models/pin_code_result.dart';
import 'package:flutter/foundation.dart';
import '../models/benefit_grid_item.dart';
import '../widgets/mobile/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum TableType { notification, document }

enum UserType { houseOwner, contractor }

enum AlertType { normal, cupertino }

enum LoaderType {
  normal,
  rotatingPlain,
  doubleBounce,
  wave,
  wanderingCubes,
  fadingFour,
  fadingCube,
  pulse,
  chasingDots,
  threeBounce,
  circle,
  cubeGrid,
  fadingCircle,
  rotatingCircle,
  foldingCube,
  pumpingHeart,
  hourGlass,
  pouringHourGlass,
  pouringHourGlassRefined,
  fadingGrid,
  ring,
  ripple,
  spinningCircle,
  spinningLines,
  squareCircle,
  dualRing,
  pianoWave,
  dancingSquare,
  threeInOut
}

enum PickImageType { camera, gallery }

enum PopupType { menu, modal, ios }

enum PossessorType { me, other, landlord }

enum DateType { birth, death }

enum ButtonType { raised, text, border }

enum ApiMode { testing, staging, dev, live }

List<BenefitGridItem> gridItems = <BenefitGridItem>[
  BenefitGridItem(
      heading: 'Easy',
      content: 'Simple set-up process',
      icon: Icons.settings_accessibility),
  BenefitGridItem(
      heading: 'Paperless',
      content: 'Stored in the cloud',
      icon: FontAwesomeIcons.searchengin),
  BenefitGridItem(
      heading: 'Secure',
      content: 'Every important document in a safe environment',
      icon: Icons.security),
  BenefitGridItem(
      heading: 'Accessible',
      content: 'Scan the QR code and access 24/7/365 days a year',
      icon: Icons.qr_code),
  BenefitGridItem(
      heading: 'Provide Assurance',
      content: 'Previously certified works viewed at the property',
      icon: Icons.image_search),
  BenefitGridItem(
      heading: 'DTC or Licenced',
      content: 'Direct to Consumer (online) or fully licenced products',
      icon: Icons.domain),
  BenefitGridItem(
      heading: 'Communal Areas',
      content: 'Individual assets and areas can have QR codes linked to them',
      icon: Icons.apartment),
  BenefitGridItem(
      heading: 'Integration',
      content: 'with 3rd party software',
      icon: FontAwesomeIcons.handshake)
];
List<String> sectors = <String>[
      'Electrical',
      'Compliance',
      'Gas Safe',
      'Construction',
      'Fire',
      'Other'
    ],
    items = <String>[
      'slide-1.png',
      'slide-2.png',
      'slide-3.png',
      'slide-4.png',
    ];
String title = 'CertOn HUB';

DateTime? currentBackPressTime;

Utils ut = Utils();

API api = API(ApiMode.staging);

Connectivity con = Connectivity();

DeviceInfoPlugin dip = DeviceInfoPlugin();

GlobalConfiguration? gc;

FlutterUxConfig uxc = FlutterUxConfig(userAppKey: '6fkwpg17zc9ma8e');

RegExp mailExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
    passExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

final flnPlugin = FlutterLocalNotificationsPlugin();

const androidChannel = AndroidNotificationChannel('certon', 'Cert-On'),
    sound = RawResourceAndroidNotificationSound('loud_notification');

final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

final isMac = defaultTargetPlatform == TargetPlatform.macOS;

final isAndroid = defaultTargetPlatform == TargetPlatform.android;

final isWindows = defaultTargetPlatform == TargetPlatform.windows;

final isLinux = defaultTargetPlatform == TargetPlatform.linux;

final isFuchsia = defaultTargetPlatform == TargetPlatform.fuchsia;

final isWeb =
    !(isAndroid || isIOS || isMac || isWindows || isLinux || isFuchsia);

final dF = isFuchsia || isLinux || isWindows;

final isPortable = isAndroid || isIOS;

final assetImagePath = gc?.getValue<String>('asset_image_path') ?? '';

WidgetsBinding? wb;

Stream<RemoteMessage>? rms1, rms2;

StreamSubscription<RemoteMessage>? rmsc1, rmsc2;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void bind() {
  wb?.addPostFrameCallback(bcb);
}

void binder() async {
  log('datasfdf');
  // await FirebaseCrashlytics.instance.setCustomKey('str_key', 'hello');
  // await FirebaseCrashlytics.instance.log('Hey');
}

void bcb(Duration time) {
  Timer(time, binder).cancel();
}

void cancelMessageSubscription() async {
  log(rmsc1);
  await rmsc1?.cancel();
  log(rmsc2);
  await rmsc2?.cancel();
}

void log(Object? object) {
  if (kDebugMode) print(object);
}

void openAppViaNotification() async {
  try {
    final p = await (currentUser.value.isNotEmpty
        ? navigatorKey.currentState
            ?.pushNamed('/notifications', arguments: RouteArgument(id: 1))
        : navigatorKey.currentState
            ?.pushNamedAndRemoveUntil('/mobile_login', predicate));
    log(p);
  } catch (e) {
    sendAppLog(e);
  }
}

void crashApp() {
  FirebaseCrashlytics.instance.crash();
}

void sendAppLog(Object? object) async {
  ((kProfileMode || kReleaseMode) && object != null)
      ? await FirebaseCrashlytics.instance.log(object.toString())
      : log(object);
}

void uxCamSetup() async {
  await FlutterUxcam.optIntoSchematicRecordings();
  log(await FlutterUxcam.startWithConfiguration(uxc) ? 'Done' : 'Error');
}

void addYearsToDateString(TextEditingController tec, int k,
    {int limit = 10, int? initialYear}) {
  try {
    log(tec.text);
    log(initialYear);
    final list = tec.text.split('/');
    List<int> li = <int>[];
    for (String number in list) {
      li.add(int.tryParse(number) ?? 0);
    }
    if (li.last + k - (initialYear ?? 0) <= limit) li.last = li.last + k;
    tec.text = li.join('/');
  } catch (e) {
    sendAppLog(e);
  }
}

void deductYearsToDateString(TextEditingController tec, int k) {
  try {
    log(tec.text);
    final list = tec.text.split('/');
    List<int> li = <int>[];
    for (String num in list) {
      li.add(int.tryParse(num) ?? 0);
    }
    li.last = li.last - k;
    tec.text = li.join('/');
  } catch (e) {
    sendAppLog(e);
  }
}

void rollbackOrientations() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
}

void lockScreenRotation() async {
  await SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp
  ]);
}

void doNothing() {}

void setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
}

void makeStatusBarVisibleInAndroid() {
  if (isAndroid) setStatusBarColor();
}

void switchAccordingToOs(
    {VoidCallback? acb,
    VoidCallback? icb,
    VoidCallback? wcb,
    VoidCallback? mcb,
    VoidCallback? fcb,
    VoidCallback? lcb,
    VoidCallback? dcb}) {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      (acb ?? (dcb ?? doNothing)).call();
      break;
    case TargetPlatform.fuchsia:
      (fcb ?? (dcb ?? doNothing)).call();
      break;
    case TargetPlatform.iOS:
      (icb ?? (dcb ?? doNothing)).call();
      break;
    case TargetPlatform.linux:
      (lcb ?? (dcb ?? doNothing)).call();
      break;
    case TargetPlatform.macOS:
      (mcb ?? (dcb ?? doNothing)).call();
      break;
    case TargetPlatform.windows:
      (wcb ?? (dcb ?? doNothing)).call();
      break;
    default:
      (dcb ?? doNothing).call();
      break;
  }
}

bool parseBool(String? source) {
  return (source?.isNotEmpty ?? false) &&
      (source?.toLowerCase() == 'true' ||
          source?.toUpperCase() == 'TRUE' ||
          source?.toLowerCase() == 'yes' ||
          source?.toUpperCase() == 'YES' ||
          source?.toLowerCase() == 'ok' ||
          source?.toUpperCase() == 'OK' ||
          ((int.tryParse(source ?? '-1') ?? -1) > 0));
}

bool predicate(Route route) {
  log(route);
  return false;
}

bool Function(Route<dynamic>) getRoutePredicate(String routeName) {
  return ModalRoute.withName(routeName);
}

String? nameValidator(String? name) =>
    name != null && name.length > 1 ? null : 'Please enter a Valid Name!!!';

String? firstNameValidator(String? name) =>
    name != null && name.length > 1 ? null : 'Minimum 2 Characters';

String? lastNameValidator(String? name) =>
    name != null && name.length > 1 ? null : 'Please enter a Last Name!!!';

String? phoneNumberValidator(String? phone) =>
    int.tryParse(phone?.trim().replaceAll(RegExp(' +'), '') ?? '') != null &&
            (phone?.trim().replaceAll(RegExp(' +'), '') ?? '').length >= 10
        ? null
        : 'Please enter a Valid Phone Number!!!';

String? companyNameValidator(String? companyName) =>
    companyName != null && companyName.length > 10
        ? null
        : 'Please enter a Valid Company Name!!!';

String? companyNumberValidator(String? companyNumber) => companyNumber == null
    ? null
    : companyNumber.length > 30 && companyNumber.length < 4
        ? null
        : 'Your Company Number contains minimum least 4 characters to maximum 30 characters';

String? companyRegistrationValidator(String? companyRegistration) =>
    companyRegistration == null
        ? null
        : companyRegistration.length > 30 && companyRegistration.length < 4
            ? null
            : 'Your Company Registration contains minimum least 4 characters to maximum 30 characters';

String putDateToString(DateTime dt) => '${dt.day}/${dt.month}/${dt.year}';

OverlayEntry overlayLoader(Duration time, {LoaderType? type}) {
  Widget overlayBuilder(BuildContext context) {
    final hp = Helper.of(context);
    return Positioned(
        top: 0,
        left: 0,
        width: hp.width,
        height: hp.height,
        child: Material(
            color: hp.theme.scaffoldBackgroundColor.withOpacity(0.85),
            child: CustomLoader(
                duration: time,
                loaderType: type,
                // heightFactor: 16,
                // widthFactor: 16,
                color: hp.theme.primaryColor)));
  }

  return OverlayEntry(builder: overlayBuilder);
}

Widget errorBuilder(BuildContext context, Object object, StackTrace? trace) {
  final hpe = Helper.of(context);
  log('--------------------');
  log(trace);
  log('====================');
  log(object);
  log('____________________');
  return Icon(Icons.error_sharp,
      color: hpe.theme.secondaryHeaderColor, size: hpe.radius / 40);
}

Widget getImageLoader(
    BuildContext context, Widget child, ImageChunkEvent? event) {
  try {
    final theme = Theme.of(context);
    final secs =
        (event?.expectedTotalBytes ?? 0) - (event?.cumulativeBytesLoaded ?? 0);
    return CustomLoader(
        color: theme.primaryColor,
        loaderType: LoaderType.fadingCircle,
        duration: Duration(seconds: secs >= 0 ? secs : 10));
  } catch (e) {
    sendAppLog(e);
    return child;
  }
}

Widget getFrameBuilder(
    BuildContext context, Widget child, int? value, bool flag) {
  try {
    final theme = Theme.of(context);
    return flag
        ? child
        : CustomLoader(
            color: theme.primaryColor,
            loaderType: LoaderType.fadingCircle,
            duration: Duration(seconds: value ?? 10));
  } catch (e) {
    sendAppLog(e);
    return child;
  }
}

Widget getPlaceHolder(BuildContext context, String url) {
  final hpp = Helper.of(context);
  log(url);
  return Image.asset('${assetImagePath}loading.gif',
      height: hpp.height / 12.8, width: hpp.width / 6.4, fit: BoxFit.fill);
}

Widget getPlaceHolderNoImage(BuildContext context, String url) {
  final hpp = Helper.of(context);
  log(url);
  return Image.asset('${assetImagePath}noImage.png',
      height: hpp.height / 12.8, width: hpp.width / 6.4, fit: BoxFit.fill);
}

Widget getErrorWidgetNoImage(BuildContext context, String url, dynamic error) {
  final hpp = Helper.of(context);
  log(error);
  return Image.asset('${assetImagePath}noImage.png',
      height: hpp.height / 12.8, width: hpp.width / 6.4, fit: BoxFit.fill);
}

String getData(List<int> values) {
  return base64.encode(values);
}

Uint8List putData(String data) {
  return base64.decode(data);
}

Uint8List processData(List<int> values) {
  return putData(getData(values));
}

num mapNum(dynamic e) {
  return num.tryParse(e?.toString().trim() ?? '0.0') ?? 0.0;
}

int mapInt(dynamic e) {
  return int.tryParse(e?.toString().trim() ?? '0') ?? 0;
}

Future<String> getAPNSToken(FirebaseMessaging fm) async {
  try {
    return isIOS || isMac ? (await fm.getAPNSToken() ?? '') : '';
  } catch (e) {
    sendAppLog(e);
    return '';
  }
}

Future<bool> isRealDevice() async {
  bool flag = true;
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      flag = flag && ((await dip.androidInfo).isPhysicalDevice ?? false);
      break;
    case TargetPlatform.iOS:
      flag = flag && ((await dip.iosInfo).isPhysicalDevice);
      break;
    default:
      break;
  }
  return flag;
}

Future<FormData> generateFormData(List<XFile> files) async {
  List<MultipartFile> multipartImageList = <MultipartFile>[];

  for (XFile file in files) {
    multipartImageList
        .add(await MultipartFile.fromFile(file.path, filename: file.name));
  }

  // package_photo is a key parameter,
  return FormData.fromMap({'file[]': multipartImageList});
}

class Helper extends ChangeNotifier {
  late BuildContext buildContext;
  Helper.of(BuildContext context) {
    buildContext = context;
  }
  ThemeData get theme => Theme.of(buildContext);
  OverlayState? get ol => Overlay.of(buildContext);
  S get loc => S.maybeOf(buildContext) ?? S.of(buildContext);
  State? get st => buildContext.findAncestorStateOfType();
  ScaffoldState get sct =>
      Scaffold.maybeOf(buildContext) ?? Scaffold.of(buildContext);
  NavigatorState get nav =>
      Navigator.maybeOf(navigatorKey.currentContext ?? buildContext) ??
      Navigator.of(navigatorKey.currentContext ?? buildContext);
  MediaQueryData get dimensions =>
      MediaQuery.maybeOf(buildContext) ?? MediaQuery.of(buildContext);
  ModalRoute<Object?>? get route => ModalRoute.of(buildContext);
  Orientation get pageOrientation => dimensions.orientation;
  bool get isDialogOpen => !(route?.isCurrent ?? true);
  Widget get wd =>
      st?.widget ??
      (buildContext.findAncestorWidgetOfExactType() ?? const EmptyWidget());
  ScaffoldMessengerState get smcT =>
      ScaffoldMessenger.maybeOf(buildContext) ??
      ScaffoldMessenger.of(buildContext);
  FocusScopeNode get currentScope => FocusScope.of(buildContext);
  double get textScaleFactor => MediaQuery.textScaleFactorOf(buildContext);
  double get width => size.width;
  Size get size => dimensions.size;
  double get height => size.height;
  bool get mounted => st?.mounted ?? false;
  EdgeInsets get screenPadding => dimensions.viewPadding;
  EdgeInsets get screenInsets => dimensions.viewInsets;
  bool get isMobile => isPortable && size.shortestSide < 600;
  bool get isTablet => isPortable && size.shortestSide >= 600;
  double get aspectRatio => size.aspectRatio;
  double get devicePixelRatio => dimensions.devicePixelRatio;
  double get radius => sqrt(pow(width, 2) + pow(height, 2));
  double get factor => pow(
          (pow(aspectRatio, 3) +
              pow(textScaleFactor, 3) +
              pow(devicePixelRatio, 3)),
          1 / 3)
      .toDouble();
  double get drawerWidth => (width * 6.4) / 10;
  double get leadingWidth =>
      width / (factor * (isTablet ? 4 : (isMobile ? 1.31072 : 2)));
  GlobalKey<ScaffoldState> key = GlobalKey();
  TextTheme get textTheme => theme.textTheme;
  double appbarHeight = AppBar().preferredSize.height;
  List<QuickLink> get linkList => <QuickLink>[
        QuickLink('Home', () async {
          goBack();
          if (route?.settings.name != '/mobile_home') {
            goBackForeverTo('/mobile_home');
          } else {
            final data = await dip.iosInfo;
            log(data.model);
            log(data.name);
            log(dimensions.boldText);
          }
        }),
        QuickLink('About', () {
          goBack();
          goTo('/mobile_about');
        }),
        QuickLink('Welcome Screen', () {
          goBack();
          goTo('/get_started', args: true);
        }),
        QuickLink('FAQs', () async {
          goBack();
          goTo('/help');
        }),
        QuickLink('Settings', () async {
          goBack();
          goTo('/settings');
        }),
        QuickLink('Logout', logout),
        QuickLink('Delete My Account', () async {
          try {
            if (await revealDialogBox([
              loc.no,
              loc.yes
            ], [
              () {
                goBack(result: false);
                log('Error');
              },
              () async {
                goBack(result: true);
              }
            ],
                action: 'Are you sure to Delete Account?',
                type: AlertType.cupertino,
                title: 'Confirm!',
                dismissive: true)) {
              bool val = true;
              Loader.show(buildContext);
              final prefs = await sharedPrefs;
              final rp = await api.deleteUser();
              Loader.hide();
              for (String key in prefs.getKeys()) {
                val = val &&
                    rp.success &&
                    (key == 'spDeviceToken' || key == 'gsf' || key == 'BuildNo'
                        ? true
                        : await prefs.remove(key));
              }
              currentUser.value = User.emptyUser;
              docs.value = Document.emptyDocument;
              props.value = Property.emptyProperty;
              location.value = PinCodeResult.emptyResult;
              notifyAll();
              gotoForever('/mobile_login');
            } else {
              goBackEmpty();
            }
          } catch (e) {
            sendAppLog(e);
            if (Loader.isShown) Loader.hide();
          }
        })
      ];

  void reload({VoidCallback? vcb}) {
    try {
      if (mounted) {
        st?.setState(vcb ?? () {});
        notifyAll();
      } else {
        vcb?.call();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void goTo(String routeName, {dynamic args, VoidCallback? vcb}) async {
    try {
      if (route?.settings.name != routeName) {
        final p = await nav.pushNamed(routeName, arguments: args);
        reload(vcb: vcb);
        log(p);
      } else {
        log(routeName);
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void gotoOnce(String routeName,
      {dynamic args, dynamic result, VoidCallback? vcb}) async {
    try {
      if (route?.settings.name != routeName) {
        final p = await nav.pushReplacementNamed(routeName,
            arguments: args, result: result);
        reload(vcb: vcb);
        log(p);
      } else {
        log(routeName);
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void gotoForever(String routeName, {dynamic args}) async {
    try {
      if (route?.settings.name != routeName) {
        final p = await nav.pushNamedAndRemoveUntil(routeName, predicate,
            arguments: args);
        log(p);
      } else {
        log(routeName);
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void goBackForeverTo(String routeName) {
    try {
      nav.popUntil(getRoutePredicate(routeName));
    } catch (e) {
      sendAppLog(e);
    }
  }

  void goBack({dynamic result}) {
    try {
      log(result);
      nav.pop(result);
    } catch (e) {
      sendAppLog(e);
    }
  }

  void goBackEmpty() {
    goBack();
  }

  String? emailValidator(String? email) => email != null &&
          email.isNotEmpty &&
          mailExp.hasMatch(email) &&
          mailExp.allMatches(email).length == 1
      ? null
      : 'Email Address Invalid';

  String? passwordValidator(String? password) => password != null &&
          passExp.hasMatch(password) &&
          password.length > 9
      ? null
      : 'Your password must be at least 10 characters \n\nYour password must contain at least 1 digit (i.e. 0-9) \n\n Your password must contain Uppercase';

  String generatePassword(bool isWithLetters, bool isWithUppercase,
      bool isWithNumbers, bool isWithSpecial, double numberCharPassword) {
    try {
      //Define the allowed chars to use in the password
      String lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
      String upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      String numbers = '0123456789';
      String special = '@#=+!£\$%&?[](){}_*';

      //Create the empty string that will contain the allowed chars
      String allowedChars = '';

      //Put chars on the allowed ones based on the input values
      allowedChars += (isWithLetters ? lowerCaseLetters : '');
      allowedChars += (isWithUppercase ? upperCaseLetters : '');
      allowedChars += (isWithNumbers ? numbers : '');
      allowedChars += (isWithSpecial ? special : '');
      // log(_allowedChars);
      // log('_allowedChars');
      int i = 0;
      String result = '';

      //Create password
      while (i < numberCharPassword.round()) {
        //Get random int
        int randomInt = Random.secure().nextInt(allowedChars.length);
        //Get random char and append it to the password
        result += allowedChars[randomInt];
        i++;
      }
      if (result.length == 1) {
        result = '${result}12fd05A&*';
      }
      if (result.length == 2) {
        result = '${result}2fd05A&*';
      }
      if (result.length == 3) {
        result = '${result}fd05A&*';
      }
      if (result.length == 4) {
        result = '${result}d05A&*';
      }
      if (result.length == 5) {
        result = '${result}05A&)';
      }
      if (result.length == 6) {
        result = '${result}5A&)';
      }
      if (result.length == 7) {
        result = '${result}A&8';
      }
      if (result.length == 8) {
        result = '$result&8';
      }
      if (result.length == 9) {
        result = '${result}0';
      }
      return result;
    } catch (e) {
      sendAppLog(e);
      return '';
    }
  }

  var textPasswordFull = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain uppercase ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain special character ',
            style: TextStyle(
              color: Colors.red,
            )),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );

  var textPasswordFirst = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
      ],
    ),
  );

  var textPasswordsecond = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(text: 'contain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
      ],
    ),
  );

  var textPasswordthird = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'contain uppercase ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
      ],
    ),
  );

  var textPasswordFour = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'contain special character ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );

  var twotextPasswordFirst = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain special character ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );

  var twotextPasswordsecond = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
      ],
    ),
  );

  var twotextPasswordthird = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain uppercase ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
      ],
    ),
  );

  var threetextPasswordfirst = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain one special character ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );

  var threetextPasswordsecond = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain Uppercase ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain one special character ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );
  var threetextPasswordthird = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: 'must be at least 10 characters ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain Uppercase ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
      ],
    ),
  );
  var threetextPasswordfour = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: '\n\ncontain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain uppercase ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain one special character ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );

  var twotextPasswordfour = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: '\n\ncontain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain one special character ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );
  var twotextPasswordfive = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: '\n\ncontain Uppercase ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain one special character ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red))
      ],
    ),
  );
  var twotextPasswordsix = RichText(
    text: const TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
            text: '\n\ncontain 1 digit ', style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
        TextSpan(
            text: '\n\ncontain Uppercase ',
            style: TextStyle(color: Colors.red)),
        TextSpan(
            text: '',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red)),
      ],
    ),
  );

  RichText? passwordValidstructure(String? password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_.£, ]).{10,}$';
    RegExp regExp = RegExp(pattern);
    log(regExp.hasMatch(password ?? ''));
    log('regExp.hasMatch(password ?? ' ')');
    final pwd = password ?? '';
    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        pwd.length < 10) {
      return textPasswordFull;
    } else if (pwd.length < 10 &&
        !RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return threetextPasswordfirst;
    } else if (pwd.length < 10 &&
        RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return threetextPasswordsecond;
    } else if (pwd.length < 10 &&
        !RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return threetextPasswordthird;
    } else if (pwd.length >= 10 &&
        !RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return threetextPasswordfour;
    } else if (pwd.length < 10 &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[0-9])').hasMatch(pwd)) {
      return twotextPasswordFirst;
    } else if (pwd.length < 10 &&
        !RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return twotextPasswordsecond;
    } else if (pwd.length < 10 &&
        !RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd)) {
      return twotextPasswordthird;
    } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length >= 10 &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return twotextPasswordfour;
    } else if (RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length >= 10 &&
        !RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return twotextPasswordfive;
    } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length >= 10 &&
        !RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return twotextPasswordsix;
    } else if (RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length < 10 &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return textPasswordFirst;
    } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length >= 10 &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return textPasswordsecond;
    } else if (RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length >= 10 &&
        !RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return textPasswordthird;
    } else if (RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        !RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length >= 10 &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return textPasswordFour;
    } else if (RegExp(r'^(?=.*?[0-9])').hasMatch(pwd) &&
        RegExp(r'^(?=.*?[!@#\$&*~_.£\[\"\]\{\}%\^+=\|\<\>\(\)\?,\/\;\:\¥\-\` ])')
            .hasMatch(pwd) &&
        pwd.length >= 10 &&
        RegExp(r'^(?=.*?[A-Z])').hasMatch(pwd)) {
      return null;
    }
    return null;
  }

  void signOutIfAnyChanges(int roleIDs) async {
    try {
      if (st?.mounted ?? false) {
        // showLoader();
        final prefs = await sharedPrefs;
        var roleID = prefs.getInt('RoleID') ?? 0;
        // concealLoader();
        log(roleID);
        log(currentUser.value.role.roleID);
        if (roleID != roleIDs) {
          bool flag = true;
          log(isDialogOpen);
          log('dialog');
          if (!isDialogOpen) {
            flag = flag &&
                await showSimplePopup(loc.ok, () {
                  goBack(result: true);
                },
                    dismissive: false,
                    action:
                        'Your session has expired. Please re-login to continue',
                    type: AlertType.cupertino);
          }
          final prefs = await sharedPrefs;
          prefs.containsKey('rememberme') &&
                  (prefs.getBool('rememberme') ?? false)
              ? log('fhhgewi')
              : flag = flag &&
                  await prefs.remove('rup') &&
                  await prefs.remove('ruem');
          for (String key in prefs.getKeys()) {
            flag = flag &&
                (key == 'spDeviceToken' ||
                        key == 'gsf' ||
                        key == 'rememberme' ||
                        key == 'ruem' ||
                        key == 'rup' ||
                        key == 'BuildNo'
                    ? true
                    : await prefs.remove(key));
          }
          log('Error');
          if (flag) {
            currentUser.value = User.emptyUser;
            docs.value = Document.emptyDocument;
            props.value = Property.emptyProperty;
            location.value = PinCodeResult.emptyResult;
            notifyAll();
            gotoForever('/mobile_login');
          }
        } else {
          doNothing();
        }
      } else {
        doNothing();
      }
    } catch (e) {
      sendAppLog(e);
      if (navigatorKey.currentState?.mounted ?? false) {
        final prefs = await sharedPrefs;
        var roleID = prefs.getInt('RoleID') ?? 0;
        if (roleID != currentUser.value.role.roleID) {
          bool flag = true;
          final ido =
              !(ModalRoute.of(navigatorKey.currentContext ?? buildContext)
                      ?.isCurrent ??
                  true);
          log('dialog');
          if (!ido) {
            flag = flag &&
                await showSimplePopup(loc.ok, () {
                  goBack(result: true);
                },
                    dismissive: false,
                    action:
                        'Your session has expired. Please re-login to continue',
                    type: AlertType.cupertino);
          }
          final prefs = await sharedPrefs;
          prefs.containsKey('rememberme') &&
                  (prefs.getBool('rememberme') ?? false)
              ? log('fhhgewi')
              : flag = flag &&
                  await prefs.remove('rup') &&
                  await prefs.remove('ruem');
          for (String key in prefs.getKeys()) {
            flag = flag &&
                (key == 'spDeviceToken' ||
                        key == 'gsf' ||
                        key == 'rememberme' ||
                        key == 'ruem' ||
                        key == 'rup' ||
                        key == 'BuildNo'
                    ? true
                    : await prefs.remove(key));
          }
          log('Error');
          if (flag) {
            currentUser.value = User.emptyUser;
            docs.value = Document.emptyDocument;
            props.value = Property.emptyProperty;
            location.value = PinCodeResult.emptyResult;
            notifyAll();
            gotoForever('/mobile_login');
          }
        } else {
          doNothing();
        }
      } else {
        doNothing();
      }
    }
  }

  void forceLogout() async {
    try {
      final p = await revealDialogBox([
        loc.ok
      ], [
        () async {
          final prefs = await sharedPrefs;
          bool val = true;
          prefs.containsKey('rememberme') &&
                  (prefs.getBool('rememberme') ?? false)
              ? log('fhhgewi')
              : val = val &&
                  await prefs.remove('rup') &&
                  await prefs.remove('ruem');
          for (String key in prefs.getKeys()) {
            val = val &&
                (key == 'spDeviceToken' ||
                        key == 'gsf' ||
                        key == 'rememberme' ||
                        key == 'ruem' ||
                        key == 'rup' ||
                        key == 'BuildNo'
                    ? true
                    : await prefs.remove(key));
          }
          currentUser.value = User.emptyUser;
          location.value = PinCodeResult.emptyResult;
          props.value = Property.emptyProperty;
          docs.value = Document.emptyDocument;
          notifyAll();
          goBack(result: val);
        }
      ],
          action: 'Your session has expired. Please re-login to continue',
          type: AlertType.cupertino,
          title: title,
          dismissive: true);
      /*p ? gotoForever('/mobile_login') : goBack();*/
    } catch (e) {
      sendAppLog(e);
    }
  }

  void logout() async {
    try {
      final p = await revealDialogBox([
        loc.no,
        loc.yes
      ], [
        () {
          goBack(result: false);
          log('Error');
        },
        () async {
          final prefs = await sharedPrefs;
          bool val = true;
          prefs.containsKey('rememberme') &&
                  (prefs.getBool('rememberme') ?? false)
              ? log('fhhgewi')
              : val = val &&
                  await prefs.remove('rup') &&
                  await prefs.remove('ruem');
          for (String key in prefs.getKeys()) {
            val = val &&
                (key == 'spDeviceToken' ||
                        key == 'gsf' ||
                        key == 'rememberme' ||
                        key == 'ruem' ||
                        key == 'rup' ||
                        key == 'BuildNo'
                    ? true
                    : await prefs.remove(key));
          }
          currentUser.value = User.emptyUser;
          location.value = PinCodeResult.emptyResult;
          props.value = Property.emptyProperty;
          docs.value = Document.emptyDocument;
          notifyAll();
          goBack(result: val);
        }
      ],
          action: 'Are you sure to Logout?',
          type: AlertType.cupertino,
          title: 'Confirm!',
          dismissive: true);
      p ? gotoForever('/mobile_login') : goBack();
    } catch (e) {
      sendAppLog(e);
    }
  }

  Future<T?> appearDialogBox<T>(
      {Widget? child,
      Widget? title,
      AlertType? type,
      Widget? content,
      bool? dismissive,
      String? barrierLabel,
      List<Widget>? actions,
      TextStyle? titleStyle,
      Curve? insetAnimation,
      TextStyle? actionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      EdgeInsets? contentPadding,
      RouteSettings? routeSettings,
      ScrollController? scrollController,
      MainAxisAlignment? actionsAlignment,
      ScrollController? actionScrollController}) {
    Widget dialogBuilder(BuildContext context) {
      switch (type) {
        case AlertType.cupertino:
          return CupertinoAlertDialog(
              title: title,
              content: content,
              actions: actions ?? <Widget>[],
              scrollController: scrollController,
              actionScrollController: actionScrollController,
              insetAnimationCurve: insetAnimation ?? Curves.decelerate,
              insetAnimationDuration:
                  insetDuration ?? const Duration(milliseconds: 100));
        case AlertType.normal:
        default:
          return AlertDialog(
              title: title,
              content: content,
              actions: actions,
              titlePadding: titlePadding,
              titleTextStyle: titleStyle,
              buttonPadding: buttonPadding,
              contentTextStyle: actionStyle,
              actionsAlignment: actionsAlignment,
              actionsPadding: actionPadding ?? EdgeInsets.zero,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                      horizontal: width / 25, vertical: height / 100));
      }
    }

    switch (type) {
      case AlertType.cupertino:
        return showCupertinoDialog<T>(
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            routeSettings: routeSettings,
            barrierDismissible: dismissive ?? false,
            context: navigatorKey.currentContext ?? buildContext);
      case AlertType.normal:
      default:
        return showDialog<T>(
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            routeSettings: routeSettings,
            barrierDismissible: dismissive ?? false,
            context: navigatorKey.currentContext ?? buildContext);
    }
  }

  Future<T?> manifestDialogBox<T>(
      List<String> options, List<VoidCallback> actions,
      {String? title,
      String? action,
      AlertType? type,
      bool? dismissive,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController,
      Curve? insetAnimation}) async {
    Widget optionsMap(String e) {
      final child = Text(e, style: optionStyle);
      final onTap = actions[options.indexOf(e)];
      log(type);
      switch (type) {
        case AlertType.cupertino:
          return CupertinoDialogAction(
              onPressed: onTap, textStyle: actionStyle, child: child);
        case AlertType.normal:
        default:
          return CustomButton(
              type: ButtonType.text, onPressed: onTap, child: child);
      }
    }

    return options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty
        ? await appearDialogBox<T>(
            type: type,
            dismissive: dismissive,
            titleStyle: titleStyle,
            actionStyle: actionStyle,
            titlePadding: titlePadding,
            buttonPadding: buttonPadding,
            actionPadding: actionPadding,
            insetDuration: insetDuration,
            insetAnimation: insetAnimation,
            scrollController: scrollController,
            title: title == null ? null : Text(title),
            content: action == null ? null : Text(action),
            actionScrollController: actionScrollController,
            actions: options.map<Widget>(optionsMap).toList())
        : null;
  }

  Future<bool?> showDialogBox(
      {Widget? title,
      AlertType? type,
      Widget? content,
      bool? dismissive,
      String? barrierLabel,
      List<Widget>? actions,
      TextStyle? titleStyle,
      Curve? insetAnimation,
      TextStyle? actionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      EdgeInsets? contentPadding,
      RouteSettings? routeSettings,
      ScrollController? scrollController,
      MainAxisAlignment? actionsAlignment,
      ScrollController? actionScrollController}) {
    return appearDialogBox<bool>(
        type: type,
        title: title,
        content: content,
        actions: actions,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        titlePadding: titlePadding,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetDuration: insetDuration,
        insetAnimation: insetAnimation,
        scrollController: scrollController,
        actionScrollController: actionScrollController);
  }

  Future<bool> revealDialogBox(List<String> options, List<VoidCallback> actions,
      {String? action,
      String? title,
      AlertType? type,
      bool? dismissive,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      ScrollController? scrollController,
      ScrollController? actionScrollController,
      Duration? insetDuration,
      Curve? insetAnimation}) async {
    Widget optionsMap(String e) {
      final child = Text(e, style: optionStyle);
      final onTap = actions[options.indexOf(e)];
      log(type);
      switch (type) {
        case AlertType.cupertino:
          return CupertinoDialogAction(
              onPressed: onTap, textStyle: actionStyle, child: child);
        case AlertType.normal:
        default:
          return TextButton(onPressed: onTap, child: child);
      }
    }

    return options.isNotEmpty &&
            actions.isNotEmpty &&
            options.length == actions.length
        ? (await showDialogBox(
                type: type,
                dismissive: dismissive,
                titleStyle: titleStyle,
                actionStyle: actionStyle,
                titlePadding: titlePadding,
                buttonPadding: buttonPadding,
                actionPadding: actionPadding,
                insetDuration: insetDuration,
                insetAnimation: insetAnimation,
                scrollController: scrollController,
                actionScrollController: actionScrollController,
                actions: options.map<Widget>(optionsMap).toList(),
                title: title == null ? null : Text(title),
                content: action == null ? null : Text(action)) ??
            false)
        : options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty;
  }

  Future<bool> showSimplePopup(String option, VoidCallback onActionDone,
      {String? action,
      String? title,
      AlertType? type,
      bool? dismissive,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      ScrollController? scrollController,
      ScrollController? actionScrollController,
      Duration? insetDuration,
      Curve? insetAnimation}) {
    return revealDialogBox([option], [onActionDone],
        type: type,
        title: title,
        action: action,
        dismissive: dismissive,
        titleStyle: titleStyle,
        optionStyle: optionStyle,
        actionStyle: actionStyle,
        titlePadding: titlePadding,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetDuration: insetDuration,
        insetAnimation: insetAnimation,
        scrollController: scrollController,
        actionScrollController: actionScrollController);
  }

  Future<bool> showSimpleYesNo(
      {bool? flag,
      bool? reverse,
      String? title,
      String? action,
      AlertType? type,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) {
    VoidCallback mapAction(String action) {
      return () {
        goBack(result: parseBool(action));
      };
    }

    final options = <String>[
      (flag ?? true) ? loc.yes : loc.ok,
      (flag ?? true) ? loc.no : loc.cancel
    ];
    final actions = ((reverse ?? false) ? options.reversed : options)
        .map<VoidCallback>(mapAction)
        .toList();
    return revealDialogBox(options, actions,
        type: type,
        title: title,
        action: action,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        optionStyle: optionStyle,
        titlePadding: titlePadding,
        insetDuration: insetDuration,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetAnimation: insetAnimation,
        scrollController: scrollController,
        actionScrollController: actionScrollController);
  }

  void delayedFunc(Duration duration, VoidCallback vcb) async {
    await Future.delayed(duration, vcb);
  }

  void showPopup(
      String heading, Widget content, AlertType type, Duration duration) async {
    Widget popupBuilder(BuildContext context) {
      delayedFunc(duration, goBack);
      switch (type) {
        case AlertType.cupertino:
          return CupertinoAlertDialog(title: Text(heading), content: content);
        case AlertType.normal:
        default:
          return AlertDialog(title: Text(heading), content: content);
      }
    }

    await showDialog(builder: popupBuilder, context: buildContext);
  }

  void showLoadingPopup(
      String text, LoaderType lt, AlertType at, Duration duration, Color color,
      {double? sizeFactor}) {
    showPopup(
        text,
        CustomLoader(
            duration: duration,
            color: color,
            loaderType: lt,
            sizeFactor: sizeFactor),
        at,
        duration);
  }

  Future<DateTime> getDatePicker(
      {AlertType? alertType, DateTime? dateTime, DateType? dateType}) async {
    final today = DateTime.now();
    final DateTime picked, startDate, endDate;
    switch (dateType) {
      case DateType.birth:
        startDate = DateTime(
            (dateTime == null ? today.year : dateTime.year) - 10, 1, 1);
        endDate = dateTime ?? today;
        break;
      case DateType.death:
        log(dateTime);
        log('date start');
        startDate = dateTime ?? today;
        endDate = DateTime((dateTime == null ? today.year : dateTime.year) + 10,
            12, 31, 23, 59, 59);
        break;
      default:
        startDate = DateTime(
            (dateTime == null ? today.year : dateTime.year) - 50, 1, 1);
        endDate = DateTime((dateTime == null ? today.year : dateTime.year) + 10,
            12, 31, 23, 59, 59);
        break;
    }
    switch (alertType) {
      case AlertType.cupertino:
        picked = await showIOSStyleDatePicker(
            initial: dateTime, firstDate: startDate, lastDate: endDate);
        break;
      case AlertType.normal:
      default:
        picked = await showDatePicker(
                context: buildContext,
                initialDate: dateTime ?? today,
                firstDate: startDate,
                lastDate: endDate) ??
            today;
        break;
    }
    log(picked.day);
    return picked;
  }

  Future<DateTime> showIOSStyleDatePicker(
      {DateTime? initial, DateTime? firstDate, DateTime? lastDate}) async {
    Widget iOSDatePickerBuilder(BuildContext context) {
      DateTime? dat, donedat;
      void onDateTimeChanged(DateTime dt) {
        dat = dt;
      }

      return Card(
          color: Colors.white,
          margin: EdgeInsets.only(
              top: dimensions.orientation == Orientation.portrait
                  ? height / 1.5
                  : height / 3),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.blue),
                                            borderRadius: BorderRadius.circular(
                                                radius / 160))),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: height / 40,
                                        horizontal: width / 10))),
                            onPressed: () {
                              log(dat);
                              log('camcel');
                              goBack(result: donedat);
                            },
                            child: const Text('Cancel')),
                        OutlinedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.blue),
                                            borderRadius: BorderRadius.circular(
                                                radius / 160))),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: height / 40,
                                        horizontal: width / 10))),
                            onPressed: () {
                              log(dat);
                              log('check');
                              donedat = dat;
                              goBack(result: donedat);
                            },
                            child: const Text('Done'))
                      ],
                    ))),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child: CupertinoDatePicker(
                    minimumDate: (firstDate ?? DateTime.now())
                        .subtract(const Duration(minutes: 5)),
                    maximumDate: lastDate,
                    initialDateTime: initial,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: onDateTimeChanged))
          ]));
    }

    final today = DateTime.now();
    if (initial == null) {
      final picked = await showCupertinoModalPopup<DateTime>(
              context: buildContext, builder: iOSDatePickerBuilder) ??
          today;
      return picked;
    } else {
      final picked = await showCupertinoModalPopup<DateTime>(
              context: buildContext, builder: iOSDatePickerBuilder) ??
          initial;
      return picked;
    }
  }

  void addLoader(Duration time, {LoaderType? type}) {
    try {
      ol?.insert(overlayLoader(time, type: type));
    } catch (e) {
      sendAppLog(e);
    }
  }

  void hideLoader(Duration time, {LoaderType? type}) {
    try {
      overlayLoader(time, type: type).remove();
      if (ol?.mounted ?? false) {
        ol?.dispose();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void getConnectStatus({VoidCallback? vcb}) async {
    final connectivityResult = await con.checkConnectivity();
    log(textTheme.bodyLarge?.fontFamily);
    if (connectivityResult == ConnectivityResult.none) {
      final f1 = await showSimplePopup('Try Again', () {
        goBack(result: connectivityResult != ConnectivityResult.none);
        getConnectStatus();
      },
          action: 'You are Off-Line!!!!!',
          type: AlertType.cupertino,
          dismissive: false);
      if (f1) log(ConnectivityResult.values);
    } else {
      vcb?.call();
    }
  }

  String limitString(String text, int limit, {String hiddenText = '...'}) {
    return text.substring(0, min<int>(limit, text.length)) +
        (text.length > limit ? hiddenText : '');
  }

  void notifyLocation() {
    location.notifyListeners();
  }

  void notifyUser() {
    currentUser.notifyListeners();
  }

  void notifyProperty() {
    props.notifyListeners();
  }

  void notifyDocument() {
    docs.notifyListeners();
  }

  void notifyAll() {
    notifyUser();
    notifyLocation();
    notifyProperty();
    notifyDocument();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> getSnackBar(
      String content,
      {double? width,
      double? elevation,
      Clip? clipBehavior,
      Duration? duration,
      ShapeBorder? shape,
      SnackBarAction? action,
      Color? backgroundColor,
      VoidCallback? onVisible,
      EdgeInsetsGeometry? margin,
      SnackBarBehavior? behavior,
      EdgeInsetsGeometry? padding,
      Animation<double>? animation,
      DismissDirection? dismissDirection}) {
    return renderSnackBar(Text(content),
        shape: shape,
        width: width,
        action: action,
        margin: margin,
        padding: padding,
        behavior: behavior,
        duration: duration,
        animation: animation,
        elevation: elevation,
        onVisible: onVisible,
        clipBehavior: clipBehavior,
        backgroundColor: backgroundColor,
        dismissDirection: dismissDirection);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> renderSnackBar(
      Widget content,
      {double? width,
      double? elevation,
      Clip? clipBehavior,
      Duration? duration,
      ShapeBorder? shape,
      SnackBarAction? action,
      Color? backgroundColor,
      VoidCallback? onVisible,
      EdgeInsetsGeometry? margin,
      SnackBarBehavior? behavior,
      EdgeInsetsGeometry? padding,
      Animation<double>? animation,
      DismissDirection? dismissDirection}) {
    return smcT.showSnackBar(SnackBar(
        shape: shape,
        width: width,
        action: action,
        margin: margin,
        content: content,
        padding: padding,
        behavior: behavior,
        animation: animation,
        elevation: elevation,
        onVisible: onVisible,
        backgroundColor: backgroundColor,
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        duration: duration ?? const Duration(seconds: 4),
        dismissDirection: dismissDirection ?? DismissDirection.down));
  }

  void displayBar(String text) async {
    try {
      final p = getSnackBar(text);
      p.close.call();
      final q = await p.closed;
      log(q);
    } catch (e) {
      sendAppLog(e);
    }
  }

  void revealSnackBar(Widget child, Duration duration) async {
    try {
      final p = smcT.showSnackBar(SnackBar(content: child, duration: duration));
      p.close.call();
      final q = await p.closed;
      log(q);
    } catch (e) {
      sendAppLog(e);
    }
  }

  void reloadOnly() {
    st?.setState(doNothing);
  }
}
