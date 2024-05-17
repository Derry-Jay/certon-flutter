import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../widgets/mobile/bottom_widget.dart';
import '../widgets/mobile/drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends StateMVC<AboutScreen> {
  String v = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newVersionCheck();
  }

  void newVersionCheck() async {
    final newVersion =
        NewVersion(iOSId: 'com.certonapp.app', androidId: 'com.certon.app');
    final packageInfo = await PackageInfo.fromPlatform();
    final versionStatus = await newVersion.getVersionStatus();
    String appName = packageInfo.appName,
        packageName = packageInfo.packageName,
        version = packageInfo.version,
        buildNumber = packageInfo.buildNumber;
    log(version);
    log('object');
    log(buildNumber);
    log('sjdjhcidj');
    log(appName);
    log('nkdsoisjdcodc');
    log(packageName);
    log('nferugroifnwedei');
    log(versionStatus?.localVersion);
    log('kdfjcieodcugrr');
    log(versionStatus?.releaseNotes);
    log('afssdgdfsggdf');
    log(versionStatus?.storeVersion);
    log('for inside');
    log(versionStatus?.appStoreLink);
    log('typeName');
    log(v);
    log('lakdfj;jfasihesouhseaufhasduhdhsjhfajsdhf');
    log(versionStatus?.canUpdate.toString());
    mounted
        ? setState(() {
            v = packageInfo.version;
          })
        : doNothing();
  }

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    hp.getConnectStatus();
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Scaffold(
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset('${assetImagePath}logo.png',
                            fit: hp.isTablet ? BoxFit.contain : BoxFit.fitWidth,
                            width: hp.isMobile ? 100 : 150,
                            height: hp.isMobile ? 75 : 100,
                            errorBuilder: errorBuilder)),
                    const Center(
                        // heightFactor: 0,
                        child: Text('CertOn HUB App',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 50,
                    ),
                    Text('App Version: ${v.isEmpty ? "loading..." : v}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text('© 2022 CertOn HUB Ltd.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                    const SizedBox(
                      height: 3,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (await launchUrl(
                            Uri.tryParse('https://www.certon.co.uk') ??
                                Uri())) {
                          log('Hi');
                        }
                      },
                      child: const SizedBox(
                        height: 35,
                        child: Text(
                          'www.certon.co.uk',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text('Privacy Policy', style: hp.textTheme.bodyText2),
                    GestureDetector(
                      onTap: () async {
                        const uri = 'https://www.certon.co.uk/privacy-policy';
                        if (await canLaunchUrl(Uri.tryParse(uri) ?? Uri()) &&
                            await launchUrl(Uri.tryParse(uri) ?? Uri())) {
                          log(uri);
                        }
                      },
                      child: const SizedBox(
                        height: 35,
                        child: Text(
                          'www.certon.co.uk/privacy-policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    // HyperLinkText(
                    //     text: 'www.certon.co.uk/privacy-policy',
                    //     onTap: () async {
                    //       const uri = 'https://www.certon.co.uk/privacy-policy';
                    //       if (await canLaunchUrl(Uri.tryParse(uri) ?? Uri()) &&
                    //           await launchUrl(Uri.tryParse(uri) ?? Uri())) {
                    //         log(uri);
                    //       }
                    //     }),
                    Text('Acceptable Use Policy',
                        style: hp.textTheme.bodyText2),
                    GestureDetector(
                      onTap: () async {
                        const uri =
                            'https://www.certon.co.uk/acceptable-use-policy';
                        if (await canLaunchUrl(Uri.tryParse(uri) ?? Uri()) &&
                            await launchUrl(Uri.tryParse(uri) ?? Uri())) {
                          log(uri);
                        }
                      },
                      child: const SizedBox(
                        height: 35,
                        child: Text(
                          'www.certon.co.uk/acceptable-use-policy',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    // HyperLinkText(
                    //     text: 'www.certon.co.uk/acceptable-use-policy',
                    //     onTap: () async {
                    //       const uri =
                    //           'https://www.certon.co.uk/acceptable-use-policy';
                    //       if (await canLaunchUrl(Uri.tryParse(uri) ?? Uri()) &&
                    //           await launchUrl(Uri.tryParse(uri) ?? Uri())) {
                    //         log(uri);
                    //       }
                    //     })
                  ])),
          bottomNavigationBar: const BottomWidget(),
          drawer: Drawer(width: hp.drawerWidth, child: const DrawerWidget()),
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: hp.theme.primaryColor,
              foregroundColor: hp.theme.scaffoldBackgroundColor,
              title: const Text('About',
                  style: TextStyle(fontWeight: FontWeight.w600)))),
    );
  }
}
