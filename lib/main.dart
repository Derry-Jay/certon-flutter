import 'dart:async';
import 'package:global_configuration/global_configuration.dart';

import 'generated/l10n.dart';
import 'route_generator.dart';
import 'backend/api.dart';
import 'models/user.dart';
import 'firebase_options.dart';
import 'helpers/helper.dart';
import 'web_pages/login_page.dart';
import 'widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'web_pages/web_home_page.dart';
import 'widgets/route_error_screen.dart';
import 'mobile_screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    log('Handling a background message: ${message.data}');
    final notification = message.notification;
    log('Handling a background message: ${notification.hashCode}');
    AndroidNotificationDetails? android;
    IOSNotificationDetails? iOS;
    MacOSNotificationDetails? macOS;
    LinuxNotificationDetails? linux;
    final andNot = notification?.android;
    final ios = notification?.apple;
    final web = notification?.web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        android =
            AndroidNotificationDetails(androidChannel.id, androidChannel.name,
                // sound: sound,
                playSound: true,
                icon: andNot?.smallIcon,
                priority: Priority.high,
                channelDescription: androidChannel.description);
        break;
      case TargetPlatform.iOS:
        iOS = IOSNotificationDetails(
            presentBadge: true,
            presentSound: true,
            sound: ios?.sound?.name,
            subtitle: ios?.subtitle,
            presentAlert: ios?.sound?.critical,
            threadIdentifier: ios?.subtitleLocKey);
        break;
      default:
        log(web?.link);
        break;
    }
    final notificationDetails = NotificationDetails(
        linux: linux, macOS: macOS, android: android, iOS: iOS);
    await flnPlugin.show(DateTime.now().millisecond, notification?.title,
        message.data['message'], notificationDetails);
  } catch (e) {
    sendAppLog(e);
  }
}

void notificationSelected(String? payload) async {
  try {
    log(payload);
    log('worked');
    final prefs = await sharedPrefs;
    await prefs.setInt('PushNotificationClicked', 1)
        ? openAppViaNotification()
        : doNothing();
  } catch (e) {
    sendAppLog(e);
  }
}

void onDidReceiveLocalNotification(
    int n, String? str1, String? str2, String? str3) {
  log(n);
  notificationSelected(str1);
  notificationSelected(str2);
  notificationSelected(str3);
}

void initFirebase() async {
  try {
    final app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    final firebaseMessaging = FirebaseMessaging.instance;
    final prefs = await sharedPrefs;
    final notSet = await firebaseMessaging.getNotificationSettings();
    final perms = notSet.authorizationStatus == AuthorizationStatus.denied ||
            notSet.authorizationStatus == AuthorizationStatus.notDetermined
        ? await firebaseMessaging.requestPermission(announcement: true)
        : notSet;
    log(notSet.authorizationStatus);
    final apns =
        isIOS || isMac ? (await firebaseMessaging.getAPNSToken() ?? '') : '';
    log(app.options);
    final token = (await (firebaseMessaging.getToken())) ?? '';
    await runZonedGuarded<Future<void>>(
        body, FirebaseCrashlytics.instance.recordError);
    // Isolate.current.addErrorListener(RawReceivePort((pair) async {
    //   final List<dynamic> errorAndStacktrace = pair;
    //   await FirebaseCrashlytics.instance
    //       .recordError(errorAndStacktrace.first, errorAndStacktrace.last);
    // }).sendPort);
    if (token.isNotEmpty && await prefs.setString('spDeviceToken', token)) {
      log('Device Token: $token');
      log('APNS: $apns');
      const initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');
      const initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      const initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      final fl = ((await flnPlugin.initialize(initializationSettings,
                  onSelectNotification: notificationSelected) ??
              false) &&
          (isAndroid
              ? ((await flnPlugin
                          .resolvePlatformSpecificImplementation<
                              AndroidFlutterLocalNotificationsPlugin>()
                          ?.areNotificationsEnabled() ??
                      false)
                  ? true
                  : (await flnPlugin
                          .resolvePlatformSpecificImplementation<
                              AndroidFlutterLocalNotificationsPlugin>()
                          ?.initialize(initializationSettingsAndroid,
                              onSelectNotification: notificationSelected) ??
                      false))
              : (isIOS
                  ? (await flnPlugin
                          .resolvePlatformSpecificImplementation<
                              IOSFlutterLocalNotificationsPlugin>()
                          ?.requestPermissions(
                              alert: true, badge: true, sound: true) ??
                      false)
                  : (isMac
                      ? (await flnPlugin
                              .resolvePlatformSpecificImplementation<
                                  MacOSFlutterLocalNotificationsPlugin>()
                              ?.requestPermissions(
                                  alert: true, badge: true, sound: true) ??
                          false)
                      : true))) &&
          (perms.authorizationStatus == AuthorizationStatus.authorized));
      log(fl);
      log(prefs.getString('spDeviceToken'));
      if (fl) {
        rms1 = FirebaseMessaging.onMessage;
        rms2 = FirebaseMessaging.onMessageOpenedApp;
        rmsc1 = FirebaseMessaging.onMessage.listen(whenNotified);
        rmsc2 = FirebaseMessaging.onMessageOpenedApp
            .listen(onOpenAppViaNotification);
        final pv = await firebaseMessaging.getInitialMessage();
        log('individual');
        await firebaseMessaging.setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
        log('pair');
        FirebaseMessaging.onBackgroundMessage(
            firebaseMessagingBackgroundHandler);
        if (pv != null && await prefs.setInt('PushNotificationClicked', 1)) {
          log(pv.data);
          openAppViaNotification();
        }
      } else {
        log('peek-a-boo');
      }
    } else {
      log('bye');
    }
  } catch (e) {
    sendAppLog(e);
  }
}

void whenNotified(RemoteMessage message) async {
  try {
    log(message);
    log(message);
    await firebaseMessagingBackgroundHandler(message);
  } catch (e) {
    sendAppLog(e);
  }
}

void onOpenAppViaNotification(RemoteMessage message) async {
  try {
    log('onMessage: ${message.data}');
    log('worked');
    final prefs = await sharedPrefs;
    await prefs.setInt('PushNotificationClicked', 1)
        ? openAppViaNotification()
        : doNothing();
  } catch (e) {
    sendAppLog(e);
  }
}

Future<void> body() async {
  wb = WidgetsFlutterBinding.ensureInitialized();
  log(wb);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

void main() async {
  try {
    wb = WidgetsFlutterBinding.ensureInitialized();
    gc = await GlobalConfiguration().loadFromAsset('configurations');
    if (!(wb?.buildOwner?.debugBuilding ?? true)) {
      log(gc?.getValue('asset_image_path'));
      log(gc?.getValue('live'));
      uxCamSetup();
      setUser();
      initFirebase();
    } else {
      log(defaultTargetPlatform);
    }
    runApp(const MyApp());
  } catch (e) {
    sendAppLog(e);
    cancelMessageSubscription();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Helper get hp => Helper.of(context);

  Widget rootBuilder(
      BuildContext context, AsyncSnapshot<ConnectivityResult> result) {
    final hpr = Helper.of(context);
    if (result.connectionState == ConnectionState.active ||
        result.connectionState == ConnectionState.done) {
      hpr.getConnectStatus();
    }
    Widget appBuilder(BuildContext context, User user, Widget? child) {
      // final hpa = Helper.of(context);

      return MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(boldText: false, textScaleFactor: 1.0),
        child: MaterialApp(
            // useInheritedMediaQuery: true,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: title,
            home: result.hasData && !result.hasError
                ? (isPortable
                    ? SplashScreen(
                        result: result.data ?? ConnectivityResult.none)
                    : (user.isEmpty ? const LoginPage() : const WebHomePage()))
                : const RouteErrorScreen(flag: false),
            onGenerateRoute: RouteGenerator.generateRoute,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            theme: ThemeData(
                fontFamily: 'Segoe-UI',
                hintColor: Colors.grey,
                focusColor: Colors.blue,
                primarySwatch: Colors.amber,
                secondaryHeaderColor: Colors.black,
                splashColor: const Color(0xffffbb33),
                scaffoldBackgroundColor: Colors.white,
                primaryColor: const Color(0xffe09c58))),
      );
    }

    return ValueListenableBuilder<User>(
        builder: appBuilder,
        valueListenable: currentUser,
        child: const Scaffold(body: EmptyWidget()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hp.getConnectStatus();
    // newVersionCheck();
    // setStatusBarColor();
    // lockScreenRotation();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        builder: rootBuilder, stream: con.onConnectivityChanged);
  }
}
