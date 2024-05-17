import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AccessListScreen extends StatefulWidget {
  final RouteArgument rar;
  const AccessListScreen({Key? key, required this.rar}) : super(key: key);

  @override
  AccessListScreenState createState() => AccessListScreenState();
}

class AccessListScreenState extends StateMVC<AccessListScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false, textScaleFactor: 1.0),
      child: Container(
        color: Colors.black.withOpacity(0.50),
      ),
    );
  }
}
